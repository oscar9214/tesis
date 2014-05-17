package picturemaker.logic;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import picturemaker.logic.ModelReader;;

/**
 * Servlet implementation class PicServlet
 */
@WebServlet(name = "PicServlet", urlPatterns = {"/PicServlet"})
@MultipartConfig
public class PicServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static String metamodelUri = "C:/Users/template/Documents/web_workspace/PictureMaker/models/ModeloFamilia.ecore";
	
	
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
		PrintWriter out = response.getWriter();
		out.print("Primera impresión");

		ModelReader mr = new ModelReader();
		mr.setMetamodelUri(metamodelUri);
		ArrayList<Entity> entities = mr.readModel(out);
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
		Part filePart = request.getPart("file");
        //String file = ((Object) filePart).getSubmittedFileName();
        //request.setAttribute("file", file);
        request.getRequestDispatcher("/editor.jsp").forward(request, response);
		
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
