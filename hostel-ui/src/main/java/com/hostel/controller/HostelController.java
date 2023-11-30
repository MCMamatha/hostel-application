package com.hostel.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.catalina.connector.Response;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.naming.java.javaURLContextFactory;
import org.apache.tomcat.util.log.SystemLogHandler;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.hostel.util.RestUtil;

@Configuration
@RestController
public class HostelController {

    @Autowired
    private RestUtil restUtil;
    public static String detail = null;
    public static String delete = null;
    public static String det = null;
    public static String roomdel = null;
    public static String getedit = null;
    // public static String editdetails=null;

    private static final Logger LOGGER = LogManager.getLogger(HostelController.class);

    @GetMapping(value = "/home")
    public ModelAndView home() {
        return new ModelAndView("home");
    }

    @PostMapping(value = "/newtenent")
    public String addtenent(HttpSession session, String t_name, String t_address, String t_phone, String room_no,
            String t_profession) throws JsonProcessingException {
        try {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("t_name", t_name);
            params.put("t_address", t_address);
            params.put("t_phone", t_phone);
            params.put("room_no", room_no);
            params.put("t_profession", t_profession);

            String details = restUtil.post("http://localhost:5000/addtenent", params);

            return details.toString();

        } catch (Exception ex) {
            LOGGER.error("details", ex);
            JSONObject response = new JSONObject();
            response.put("status", "failure");
            response.put("message", "Unable to get the details!");
            response.put("data", JSONObject.NULL);

            return response.toString();
        }
    }

    @GetMapping(value = "/main")
    public ModelAndView main() {
        return new ModelAndView("main");
    }

    @GetMapping(value = "/details")
    public String details(HttpSession session) {
        try {
            Map<String, Object> params = new HashMap<String, Object>();
            String detail = restUtil.get("http://localhost:5000/details", params);
            return detail.toString();
        } catch (Exception ex) {
            JSONObject response = new JSONObject();
            response.put("status", "failure");
            response.put("message", "You need to be logged in to view details!");
            response.put("data", JSONObject.NULL);

            return response.toString();
        }
    }

    @GetMapping(value = "/updateEx/{id}")
    public static String mainupdate(@PathVariable("id") String id) {
        try {
            RestUtil restUtil = new RestUtil();
            Map<String, Object> params = new HashMap<String, Object>();
            System.out.println(id);
            detail = restUtil.get("http://localhost:5000/updatedetails/" + id, params);
            System.out.println(detail);
            return detail;
        } catch (Exception ex) {
            JSONObject response = new JSONObject();
            response.put("status", "failure");
            response.put("message", "You r not redirecting to updatedetails");
            response.put("data", JSONObject.NULL);

            return response.toString();
        }
    }

    @GetMapping(value = "/mainupdate/{id}")
    public ModelAndView details() {
        return new ModelAndView("/mainUpdate");
    }

    public static String getDetails() {
        return detail;
    }

    @PostMapping(value = "/edit/details/")
    public String edittenent(HttpSession session, String t_id, String t_name, String t_address, String t_phone,
            String room_no, String t_profession) throws JsonProcessingException {
        try {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("t_id", t_id);
            params.put("t_name", t_name);
            params.put("t_address", t_address);
            params.put("t_phone", t_phone);
            // params.put("date_of_joining",date_of_joining);
            params.put("room_no", room_no);
            params.put("t_profession", t_profession);

            String details = restUtil.post("http://localhost:5000/edittenent", params);
            System.out.println(details);

            return details.toString();

        } catch (Exception ex) {
            LOGGER.error("details", ex);
            JSONObject response = new JSONObject();
            response.put("status", "failure");
            response.put("message", "Unable to get the details!");
            response.put("data", JSONObject.NULL);

            return response.toString();
        }
    }

    @DeleteMapping(value = "/delete/details")
    public String deleteTenent(HttpSession session, String id) {
        try {
            RestUtil restUtil = new RestUtil();
            Map<String, Object> params = new HashMap<String, Object>();
            System.out.println(id);
            delete = restUtil.delete("http://localhost:5000/deletedetails/" + id, params);
            return delete.toString();
        } catch (Exception ex) {
            JSONObject response = new JSONObject();
            response.put("status", "failure");
            response.put("message", "You r not redirecting to updatedetails");
            response.put("data", JSONObject.NULL);

            return response.toString();
        }
    }

    @GetMapping(value = "/onedetails/{id}")
    public static String onedetail(@PathVariable("id") String id) {
        try {
            RestUtil restUtil = new RestUtil();
            Map<String, Object> params = new HashMap<String, Object>();
            System.out.println(id);
            detail = restUtil.get("http://localhost:5000/onedetail/" + id, params);
            System.out.println(detail);
            return detail;
        } catch (Exception ex) {
            JSONObject response = new JSONObject();
            response.put("status", "failure");
            response.put("message", "unable");
            response.put("data", JSONObject.NULL);

            return response.toString();
        }
    }

    @GetMapping(value = "/viewall/tenent")
    public String viewalltenent(HttpSession session) throws JsonProcessingException {
        try {
            Map<String, Object> params = new HashMap<String, Object>();
            String get = restUtil.get("http://localhost:5000/getalltenent", params);
            System.out.println(get);
            return get.toString();
        } catch (Exception ex) {
            LOGGER.error("get", ex);
            JSONObject response = new JSONObject();
            response.put("status", "failure");
            response.put("message", "Unable to post the data");
            response.put("data", JSONObject.NULL);

            return response.toString();
        }
    }

    @PostMapping(value = "/newroom")
    public String addroom(HttpSession session, String r_no, String r_sharing) throws JsonProcessingException {
        try {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("r_no", r_no);
            params.put("r_sharing", r_sharing);

            String details = restUtil.post("http://localhost:5000/addroom", params);

            return details.toString();

        } catch (Exception ex) {
            LOGGER.error("details", ex);
            JSONObject response = new JSONObject();
            response.put("status", "failure");
            response.put("message", "Unable to post the data");
            response.put("data", JSONObject.NULL);

            return response.toString();
        }
    }

    @GetMapping(value = "/room")
    public ModelAndView room() {
        return new ModelAndView("room");
    }

    @GetMapping(value = "/oneviewdetails/{id}")
    public static String oneview(@PathVariable("id") String id) {
        try {
            RestUtil restUtil = new RestUtil();
            Map<String, Object> params = new HashMap<String, Object>();
            System.out.println(id);
            det = restUtil.get("http://localhost:5000/oneviewdetail/" + id, params);
            System.out.println(det);
            return det.toString();
        } catch (Exception ex) {
            JSONObject response = new JSONObject();
            response.put("status", "failure");
            response.put("message", "unable");
            response.put("data", JSONObject.NULL);

            return response.toString();
        }
    }

    @DeleteMapping(value = "/delete/roomdetails")
    public String deleteroom(HttpSession session, String id) {
        try {
            RestUtil restUtil = new RestUtil();
            Map<String, Object> params = new HashMap<String, Object>();
            // params.put("id",id);
            System.out.println(id);
            System.out.println(params);
            roomdel = restUtil.delete("http://localhost:5000/deleteroom/" + id, params);
            System.out.println(roomdel);
            return roomdel.toString();
        } catch (Exception ex) {
            JSONObject response = new JSONObject();
            response.put("status", "failure");
            response.put("message", "unable to delete the room details");
            response.put("data", JSONObject.NULL);

            return response.toString();
        }
    }

    @GetMapping(value = "/getedit/details/{getid}")
    public String getiddetails(@PathVariable("getid") String getid) {
        try {
            RestUtil restUtil = new RestUtil();
            Map<String, Object> params = new HashMap<String, Object>();
            getedit = restUtil.get("http://localhost:5000/getone/" + getid, params);
            System.out.println(getedit);
            return getedit.toString();
        } catch (Exception ex) {
            LOGGER.error("getedit", ex);
            JSONObject response = new JSONObject();
            response.put("status", "failure");
            response.put("message", "unable to get the details");
            response.put("data", JSONObject.NULL);
            return response.toString();
        }
    }

    @PostMapping(value = "/edit/tenent/details")
    public String editDetails(HttpSession session, Integer r_id, Integer r_no, Integer r_sharing)
            throws JsonProcessingException {
        try {
            RestUtil restUtil = new RestUtil();
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("r_id", r_id);
            params.put("r_no", r_no);
            params.put("r_sharing", r_sharing);
            String editdetails = restUtil.post("http://localhost:5000/editroom", params);

            return editdetails.toString();
        } catch (Exception ex) {
            LOGGER.error("editdetails", ex);
            JSONObject response = new JSONObject();
            response.put("status", "failure");
            response.put("message", "unable to edit the details");
            response.put("data", JSONObject.NULL);
            return response.toString();
        }
    }

    @GetMapping(value = "/image")
    public ModelAndView image() {
        return new ModelAndView("image");
    }

    public static String getone = null;

    @GetMapping(value = "/getoneid/{id}")
    public static String getdetailsof(@PathVariable("id") String id) {
        try {
            RestUtil restUtil = new RestUtil();
            Map<String, Object> params = new HashMap<String, Object>();
            getone = restUtil.get("http://localhost:5000/get/" + id, params);
            return getone;
        } catch (Exception ex) {
            LOGGER.error("this is the error", ex);
            JSONObject response = new JSONObject();
            response.put("status", "failure");
            response.put("message", "unable to get the details");
            response.put("data", JSONObject.NULL);

            return response.toString();
        }
    }

    public static String getTenentDetails() {
        System.out.println(getone);
        return getone;
    }
    // @PostMapping(value="/uploads")
    // public static String uploadimage(@PathVariable(""))

}
