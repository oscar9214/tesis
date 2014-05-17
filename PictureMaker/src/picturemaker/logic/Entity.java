package picturemaker.logic;

import java.util.ArrayList;

public class Entity {
	public ArrayList<Attribute> attributes;
	public ArrayList<Reference> references;
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String name;
	
	public Entity(String iName){
		name = iName;
		attributes = new ArrayList<Attribute>();
		references = new ArrayList<Reference>();
	}
	
	public ArrayList<Attribute> getAttributes() {
		return attributes;
	}
	public void setAttributes(ArrayList<Attribute> attributes) {
		this.attributes = attributes;
	}
	public ArrayList<Reference> getReferences() {
		return references;
	}
	public void setReferences(ArrayList<Reference> relationships) {
		this.references = relationships;
	}
	
	public void addAttribute (Attribute att){
		attributes.add(att);
	}
	
	public void addReference (Reference rel){
		references.add(rel);
	}
	
}
