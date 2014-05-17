package picturemaker.logic;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;  
import java.util.HashMap;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EAttribute;
import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EFactory;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.EReference;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.emf.ecore.xmi.impl.EcoreResourceFactoryImpl;
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl;

public class ModelWriter {

	private String metamodelUri;
	private String newModelUri;
	private String modelFileUri;
	
	public void saveModel() {
		
		try {
			XMIResourceFactoryImpl factory = new XMIResourceFactoryImpl();
			URI destinyURI = URI.createFileURI(newModelUri);
			Resource newResource = factory.createResource(destinyURI);
			ResourceSet XMIDestinationResourceSet = new ResourceSetImpl();
			XMIDestinationResourceSet.getResourceFactoryRegistry().getExtensionToFactoryMap().put("xmi", new XMIResourceFactoryImpl());
			
			ResourceSet resourceSet = new ResourceSetImpl();
			resourceSet.getResourceFactoryRegistry().getExtensionToFactoryMap().put("ecore", new EcoreResourceFactoryImpl());
			Resource metaResource = resourceSet.getResource(URI.createFileURI(metamodelUri), true);
			EPackage metaPackage = (EPackage)metaResource.getContents().get(0);
			
			EFactory metafactory = metaPackage.getEFactoryInstance();
			
			EObject rootClass = null;
			EClass metaRootClass = null;
			EObject papaClass = null;
			EClass metaPapaClass = null;
			EObject mamaClass = null;
			EClass metaMamaClass = null;
			
			BufferedReader reader = new BufferedReader(new FileReader(modelFileUri));
			String line;
			while ((line = reader.readLine()) != null) {

				if(line.startsWith("#CLASS")){
					
					//Create class
					String className = line.split("#CLASS: ")[1];
					EClass eclass = (EClass) metaPackage.getEClassifier(className);
					EObject newClass = metafactory.create(eclass);
					
					//Add attributes
					line = reader.readLine();
					while (!(line = reader.readLine()).equals("REFERENCES")){
						String attributeName = line.split(": ")[0];
						String attributeValue = line.split(": ")[1];
						EAttribute attribute = (EAttribute) eclass.getEStructuralFeature(attributeName);
						newClass.eSet(attribute, attributeValue);
					}
					
					if(rootClass == null) {
						rootClass = newClass;
						metaRootClass = eclass;
					}						
					
					//Adds Family references
					else {
						if(className.equals("Papa")) {
							EReference reference = (EReference) metaRootClass.getEStructuralFeature("padre");
							rootClass.eSet(reference, newClass);
							papaClass = newClass;
							metaPapaClass = eclass;
						}
						else if(className.equals("Mama")) {
							EReference reference = (EReference) metaRootClass.getEStructuralFeature("madre");
							rootClass.eSet(reference, newClass);
							mamaClass = newClass;
							metaMamaClass = eclass;
						}
						if(className.equals("Hijo")) {
							EReference reference = (EReference) metaRootClass.getEStructuralFeature("hijos");
							((EList)rootClass.eGet( reference )).add( newClass );
						}
					}
						
				}
				
			}
			
			//Adds marriage references
			EReference reference1 = (EReference) metaMamaClass.getEStructuralFeature("esposo");
			mamaClass.eSet(reference1,papaClass);
			EReference reference2 = (EReference) metaPapaClass.getEStructuralFeature("esposa");
			papaClass.eSet(reference2,mamaClass);
			
			newResource.getContents().add(rootClass);
			newResource.save(new HashMap<String,String>());
		
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void setModelFileUri(String modelFileUri) {
		this.modelFileUri = modelFileUri;
	}

	public void setMetamodelUri(String metamodelUri) {
		this.metamodelUri = metamodelUri;
	}

	public void setNewModelUri(String newModelUri) {
		this.newModelUri = newModelUri;
	}
	
}
