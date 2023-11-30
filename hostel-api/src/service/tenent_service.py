
import pathlib,sys
root_path=pathlib.Path(__file__).parent.resolve().parent.resolve()
sys.path.append(str(root_path))


import json
import os
import re
from flask import Flask, redirect, render_template,request
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import yaml
from dao import room,tenent,merge_table,image
from werkzeug.utils import secure_filename
# from model import image



app=Flask(__name__)

#tenent

def get_db_connection():
   Session=sessionmaker(bind=ora_engine)
   return Session()




#API to get newly adds tenent
@app.route('/details',methods=['GET'])
def tenentdetails():
    res= {
        'status' : 'success',
        'message': None,
        'data':None
    }
    try:
        
        connection=get_db_connection()
        res['data'] = tenent.all_details(connection)
        print(res['data'])
        tenentData=res['data']
        
    except Exception as e:
        print(str(e))
        res['status']='failure'
        res['message']= 'Unable to get the tenent details'

    return json.dumps(res)                

   
@app.route('/addtenent',methods=['POST'])
def newtenent():
    print("Add tenent initated")
    res={
        'status':'success',
        'message':None,
        'data':None
    }
    try:
        input=request.get_json(force=True)
        print("These are the inputs",input)
        if 't_name' not in input:
            res['status']='failure'
            res['message']='tenent name not given'
        
        elif 't_address' not in input:
            res['status']='failure'
            res['message']=' tenent address not given'
           
        elif 't_profession' not in input:
            res['status']='failure'
            res['message']=' tenent profession not given'       
        else:
            connection=get_db_connection()
            res['data']=tenent.tenent_details(
                connection=connection,
                t_name=input['t_name'],
                t_address=input['t_address'],
                t_phone=input['t_phone'],
                room_no=input['room_no'],
                t_profession=input['t_profession']
            )    
            
    except Exception as e:
        print("this is error",str(e))      
        res['status']='failure' 
        res['message']='unable to set the tenent details'
    return json.dumps(res)


@app.route('/updatedetails/<id>', methods=['GET']) # to get the details to edit
def updatedetails(id):
    print(id)
    res= {
        'status' : 'success',
        'message': None,
        'data':None
    }
    try:
        connection=get_db_connection()
        res['data'] = tenent.update_details(connection,id)

    except Exception as e:
        print(str(e))
        res['status']='failure'
        res['message']= 'Unable to get the tenent details'

    return json.dumps(res) 

@app.route('/edittenent',methods=['POST'])# to post the edited details
def edittenent():
    res={
        'status':'success',
        'message':None,
        'data':None
    }
    try:
        input=request.get_json(force=True)
        if 't_id' not in input:
            res['status']='failure'
            res['message']=' tenent id not given'
            print(125) 
        elif 't_name' not in input:
            res['status']='failure'
            res['message']='tenent name not given'
            
        elif 't_address' not in input:
            res['status']='failure'
            res['message']=' tenent address not given'
           
        elif 't_phone' not in input:
            res['status']='failure'
            res['message']=' tenent phone no not given' 
        
        elif 'room_no' not in input:
            res['status']='failure'
            res['message']=' tenent room not given'     
            
        elif 't_profession' not in input:
            res['status']='failure'
            res['message']=' tenent profession not given'    
                  
        else:
            connection=get_db_connection()
            print(148)
            res['data']=tenent.edit_details(
                t_id=int(input["t_id"]),
                t_name=input['t_name'],
                t_address=input['t_address'],
                t_phone=input['t_phone'],
                room_no=int(input['room_no']),
                t_profession=input['t_profession'],
                connection=connection
            )
            print(res['data'])    
    except Exception as e:
        print("this is error",str(e))      
        res['status']='failure' 
        res['message']='unable to set the changes'
    return json.dumps(res)

@app.route('/deletedetails/<id>', methods=['DELETE'])
def deletedata(id):
    res= {
        'status' : 'success',
        'message': None,
        'data':None
    }
    try:
        connection=get_db_connection()
        print(id,"from service")
        res['data'] = tenent.delete_details(
            connection=connection,
            id=int(id))
        
    except Exception as e:
        print(str(e))
        res['status']='failure'
        res['message']= 'Unable to delete the tenent details'

    return json.dumps(res)
 
@app.route('/onedetail/<id>',methods=['GET'])
def tdetails(id):
    res= {
        'status' : 'success',
        'message': None,
        'data':None
    }
    try:
        
        connection=get_db_connection()
        res['data'] = tenent.one_detail(
        connection=connection,
        id=int(id))
        
    except Exception as e:
        print(str(e))
        res['status']='failure'
        res['message']= 'Unable to get the tenent details'

    return json.dumps(res)  

@app.route('/getalltenent',methods=['GET'])
def getalltenent():
    res={
        'status':'success',
        'message':None,
        'data':None
    } 
    try:
        connection=get_db_connection()
        res['data'] = tenent.get_all(
        connection=connection)
    except Exception as e:
        print(e)
        res['status']='failure'
        res['message']= 'Unable to get the tenent details'

    return json.dumps(res) 
            

#room 

@app.route('/addroom',methods=['POST'])
def add_room():
    res={
        'status':'success',
        'message':None,
        'data':None
    }
    
    try:
        input=request.get_json(force=True)
        if 'r_no' not in input:
            res['status']='failure'
            res['message']='no room on given'
        elif not re.match('^\d{1,12}$',str(input['r_no'])) :
            res['status']='failure'
            res['message']='invalid room no'
        elif 'r_sharing' not in input:
            res['status']='failure'
            res['message']='no room sharing no given'
        elif not re.match('^\d{1,5}$',str(input['r_sharing'])):
            res['status']='failure'
            res['message']='invalid room sharing no given'
            
        else:
            connection=get_db_connection()
            res['data']=room.room_details(
                 connection=connection,
                r_no=int(input['r_no']),
                r_sharing=int(input['r_sharing'])
            )
            print(res['data'])
    except Exception as e:
        print(str(e),"this is error")
        res['status']='failure' 
        res['message']='unable to set the room details'
    return json.dumps(res) 

@app.route('/oneviewdetail/<id>',methods=['GET'])
def rdetails(id):
    res= {
        'status' : 'success',
        'message': None,
        'data':None
    }
    try:
        
        connection=get_db_connection()
        res['data'] = room.one_detail(
        connection=connection,
        id=int(id))
        
    except Exception as e:
        print(str(e))
        res['status']='failure'
        res['message']= 'Unable to get the tenent details'

    return json.dumps(res) 
 
@app.route('/deleteroom/<int:id>',methods=['DELETE'])
def roomdelete(id):
    res={
        'status':'success',
        'message':None,
        'data':None
    } 
    try:
        connection=get_db_connection()
        res['data']=room.delete_single_room(
            connection=connection,
            id=int(id)    
        ) 
        print(res['data'])
    except Exception as e:
        res['status']='failure'
        res['message']='Unable to delete the room details'
        
    return json.dumps(res)        

@app.route('/getone/<id>',methods=['GET'])
def getone(id):
    res={
        'status':'success',
        'message':None,
        'data':None
    }
    try:
        connection=get_db_connection()
        res['data']=room.get_details_to_edit(
            connection=connection,
            id=int(id)
        )  
    except Exception as e:
        res['status']='failure'
        res['message']='unable to get the room details'  
        print(res)                
      
    return json.dumps(res)

@app.route('/editroom',methods=['POST'])
def editroom():
    res={
        'status':'success',
        'message':None,
        'data':None
    }   
    try:
        input=request.get_json(force=True)
        if 'r_id' not in input:
            res['status']='failure'
            res['message']='no id is given'
          
        elif 'r_no' not in input:
            res['status']='failure'
            res['message']='no room on given'
       
        elif 'r_sharing' not in input:
            res['status']='failure'
            res['message']='no room sharing no given'
       
        else:
            connection=get_db_connection()
            res['data']=room.update_details(
            connection=connection,
            r_id=int(input["r_id"]),
            r_no=int(input["r_no"]),
            r_sharing=int(input["r_sharing"])
        ) 
        
    except Exception as e:
        print(str(e))
        res['status']='failure'
        res['message']='unable to update the room details'
        
    return json.dumps(res) 

@app.route('/',methods=['GET'])
def get_detail_all():
    get={
        'status':'success',
        'message':None,
        'data':None
    } 
    
    try:
        connection=get_db_connection()
        get['data']=merge_table.get_details_all(connection)
        
    except Exception as e:
        get['status']='failure' 
        get['message']='unable to get the student details'        
    return json.dumps(get) 



@app.route('/get/<id>',methods=['GET'])
def getoneid(id):
    res= {
        'status' : 'success',
        'message': None,
        'data':None
    }
    try:
        
        connection=get_db_connection()
        res['data'] = image.get_id(
        connection=connection,
        id=id)
        
    except Exception as e:
        print(str(e))
        res['status']='failure'
        res['message']= 'Unable to get the tenent details'

    return json.dumps(res)


@app.route('/')
def index():
    return render_template('image.jsp')
 
# @app.route('/upload',methods=['POST'])
# def upload():
#     # res= {
#     #     'status' : 'success',
#     #     'message': None,
#     #     'data':None
#     # }
#     file=request.files['filename']
     
#     file.save(f'uploads/{file.filename}') 
#     if not file:
#         return 'no pic uploaded',400
    
#     filename=secure_filename(file.filename)
#     mimetype=file.mimetype 
#     img=image(img=file.read(),mimetype=mimetype,name=filename)
#     get_db_connection.add(img)
#     get_db_connection.commit()
    
#     return 'image has been uploaded',200

#     return redirect('/')
    
              
            
file_config=yaml.load(open(os.path.join(root_path,"..","con","config.yml")))  
ora_engine=create_engine(file_config['db_connection_string'],pool_size=50,isolation_level="READ COMMITTED",echo=True)   

app.run('localhost',5000)  
        