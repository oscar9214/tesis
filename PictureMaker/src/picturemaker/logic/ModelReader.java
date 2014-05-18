package picturemaker.logic;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.common.util.TreeIterator;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.EStructuralFeature;
import org.eclipse.emf.ecore.impl.DynamicEObjectImpl;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.emf.ecore.xmi.impl.EcoreResourceFactoryImpl;
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl;

public class ModelReader {

	private String metamodelUri;

	@SuppressWarnings("unchecked")
	public ArrayList<Entity> readModel() {
		ArrayList<Entity> result = new ArrayList<Entity>();
		ResourceSet metaResourceSet = new ResourceSetImpl();
		metaResourceSet.getResourceFactoryRegistry().getExtensionToFactoryMap().put("ecore", new EcoreResourceFactoryImpl());
		Resource metaResource = metaResourceSet.getResource(URI.createFileURI(metamodelUri), true);
						
		Iterator<EObject> iterator = metaResource.getAllContents();
		while (iterator.hasNext()) {
			EObject classObject = iterator.next();
			if (classObject.eClass().getName().equals("EClass")){
				String name = "NONE";
				if (classObject.eClass().getEAllAttributes().size() > 0){
					name = (String) classObject.eGet(classObject.eClass().getEAllAttributes().get(0));
				}
				
				Entity entity = new Entity(name);
				
				/* Gets the attributes of the class such as: Abstract:bool Interface:bool Name:String
				for (EStructuralFeature attribute : classObject.eClass().getEAllAttributes()) {
					if (classObject.eGet(attribute) != null)
					entity.addAttribute(new Attribute(classObject.eGet(attribute).getClass().getName()+"123"+classObject.eGet(attribute).toString()));
				}
				*/
				
				for (EStructuralFeature reference : classObject.eClass().getEAllReferences()) {
					if(reference.getName().equals("eAllAttributes")){
						String element_properties = classObject.eGet(reference).toString();
						addElementValue(element_properties, entity, true);
					}
					if(reference.getName().equals("eAllReferences")){
						String element_properties = classObject.eGet(reference).toString();
						addElementValue(element_properties, entity, false);
												
					}		
				}
				result.add(entity);
			}
			
			
		}
		
		return result;
	}
	
	private String addElementValue(String element, Entity entity, boolean attributes){
		if (attributes){
			String[] elements = element.split("org.eclipse.emf.ecore.impl.EAttributeImpl");
			for (int i = 1; i < elements.length; i++){
				if (elements[i].length() > 10){
					entity.addAttribute(new Attribute(elements[i].split(" ")[2].substring(0,elements[i].split(" ")[2].length()-1)));
				}			
			}
			return element;
		}
		else {
			String[] elements = element.split("org.eclipse.emf.ecore.impl.EReferenceImpl");
			for (int i = 1; i < elements.length; i++){
				if (elements[i].length() > 10){
					entity.addReference(new Reference(elements[i].split(" ")[2].substring(0,elements[i].split(" ")[2].length()-1)));
				}			
			}
			return element;
		}
		
	}

	public void setMetamodelUri(String metamodelUri) {
		this.metamodelUri = metamodelUri;
	}
	
}
