package picturemaker.logic;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import picturemaker.logic.ModelReader;;

/**
 * Servlet implementation class PicServlet
 */
@WebServlet(name = "PicServlet", urlPatterns = {"/PicServlet"})
@MultipartConfig
public class PicServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static String metamodelUri = "/PictureMaker/models/ModeloFamilia.ecore";
	private static final String UPLOAD_DIR = "uploads";
	
	
    /**
	 * @see HttpServlet#HttpServlet()
	 */
	public PicServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		ModelReader mr = new ModelReader();
		mr.setMetamodelUri(metamodelUri);
		ArrayList<Entity> entities = mr.readModel();
		request.setAttribute("entities", entities);
		request.getRequestDispatcher("/editor.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//Part filePart = request.getPart("file");
        //String file = ((Object) filePart).getSubmittedFileName();
        //request.setAttribute("file", file);
		
		// gets absolute path of the web application
        String applicationPath = request.getServletContext().getRealPath("");
        // constructs path of the directory to save uploaded file
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
          
        // creates the save directory if it does not exists
        File fileSaveDir = new File(uploadFilePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }
        //System.out.println("Upload File Directory="+fileSaveDir.getAbsolutePath());
         
        String fileName = null;
        //Get all the parts from request and write it to the file on server
        for (Part part : request.getParts()) {
            fileName = getFileName(part);
            part.write(uploadFilePath + File.separator + fileName);
        }
        ArrayList<Entity> entities = null;
        if (fileName != null){
        	ModelReader mr = new ModelReader();
    		mr.setMetamodelUri(uploadFilePath + File.separator + fileName);
    		entities = mr.readModel();
    		request.setAttribute("entities", entities);
    		request.setAttribute("fileName", fileName);
        }        
		request.getRequestDispatcher("/editor.jsp").forward(request, response);
		/*
		// Create a factory for disk-based file items
		DiskFileItemFactory factory = new DiskFileItemFactory();

		// Configure a repository (to ensure a secure temp location is used)
		ServletContext servletContext = this.getServletConfig().getServletContext();
		File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
		factory.setRepository(repository);

		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);

		// Parse the request
		List<FileItem> items = null;
		try {
			items = upload.parseRequest(request);
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// Process the uploaded items
		Iterator<FileItem> iter = items.iterator();
		while (iter.hasNext()) {
		    FileItem item = iter.next();

		    if (!item.isFormField()) {
		        int i = 0;
		    } 
		}
		
        request.getRequestDispatcher("/editor.jsp").forward(request, response);
        */
        
        
		
	}
	
	private String getFileName(final Part part) {
	    final String partHeader = part.getHeader("content-disposition");
	    for (String content : part.getHeader("content-disposition").split(";")) {
	        if (content.trim().startsWith("filename")) {
	            return content.substring(
	                    content.indexOf('=') + 1).trim().replace("\"", "");
	        }
	    }
	    return null;
	}

}
