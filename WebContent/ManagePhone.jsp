<?xml version="1.0" encoding="UTF-8" ?>
<%@ page import="app.Person"%>
<%@ page import="app.Phonebook"%>
<%@page import="java.util.Enumeration"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html">
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <title>Управление данными о телефоне</title>
   </head>
   <body>
      <%
         String user_message = "";
         String error_message = "";
         HashMap<String,String> jsp_parameters = new HashMap<String,String>();
         Person person = new Person();
         Phonebook phonebook = (Phonebook)request.getAttribute("phonebook");
         
         if (request.getAttribute("jsp_parameters") != null)
         {
         	jsp_parameters = (HashMap<String,String>)request.getAttribute("jsp_parameters");
         }
         	String queryString = request.getQueryString();
         	error_message = jsp_parameters.get("error_message");      	
         	
         	
         	
         %>
      <form action="<%=request.getContextPath()%>/" method="post">
         <input type="hidden" name="id" value="<%=person.getId()%>"/>
         <table align="center" border="1" width="30%">
            <%
               if ((error_message != null)&&(!error_message.equals("")))
               {
               %>
            <tr>
               <td colspan="2" align="center"><span style="color:red"><%=error_message%></span></td>
            </tr>
            <%
               }
               %>
            <tr>
               <td colspan="2" align="center">Информация о телефоне владельца:
                  <%   
                     try{             
                     person =phonebook.getPerson(request.getParameter("id"));   
                     out.write(person.getSurname()+"  " + person.getName()+"  " + person.getMiddlename());
                     }
                     catch(Exception e){
                     	person =phonebook.getPerson(request.getParameter("id").split("tel")[0]);   
                         out.write(person.getSurname()+"  " + person.getName()+"  " + person.getMiddlename());
                     }
                     %>
               </td>
            </tr>
            <tr>
               <td>Номер:</td>
               <%if("edit_phone".equals(jsp_parameters.get("current_action"))) 
                  {   ;
                    	person =phonebook.getPerson(request.getParameter("id").split("tel")[0]);
                    
                    	%>
               <td><input type="text" name="newPhone" value="<%= person.getPhones().get(request.getParameter("id").split("tel")[1])  %>"></input></td>
               <%} %>
               <%if("add_phone".equals(jsp_parameters.get("current_action"))) 
                  { %>
               <td><input type="text" name="newPhone" ></input></td>
               <%} %>
            </tr>
            <tr>
               <td colspan="2" align="center">
                  <%if("add_phone".equals(jsp_parameters.get("current_action"))) 
                     { %>
                  <button   type="submit" name="<%=jsp_parameters.get("next_action")%>" value="<%=jsp_parameters.get("next_action_label")%>" >Добавить номер</button>        
                  <%} %>
                  <%if("edit_phone".equals(jsp_parameters.get("current_action"))) 
                     { %>
                  <button   type="submit" name="<%=jsp_parameters.get("next_action")%>" value="<%=jsp_parameters.get("next_action_label")%>" >Сохранить номер</button>        
                  <%} %>
                  <br />        
                  <a href="<%=request.getContextPath()%>/?action=edit&id=<%=person.getId()%>">Вернуться к списку</a>
               </td>
            </tr>
         </table>
      </form>
   </body>
</html>