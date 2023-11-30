from sqlalchemy import text
from model import tenent


def all_details(connection):

    # select query  .t_id,tenent.Tenent.t_name,tenent.Tenent.t_address,tenent.Tenent.t_phone,tenent.Tenent.date_of_joining,tenent.Tenent.room_no,tenent.Tenent.t_profession
    obj= connection.query(tenent.Tenent.t_id,tenent.Tenent.t_name,tenent.Tenent.t_address,tenent.Tenent.t_phone,tenent.Tenent.date_of_joining,tenent.Tenent.room_no,tenent.Tenent.t_profession).all()

    data={ 't_id':obj[-1].t_id,
            't_name':obj[-1].t_name,
            't_address':obj[-1].t_address,
            't_phone':obj[-1].t_phone,
            'date_of_joining':str(obj[-1].date_of_joining),
            'room_no':obj[-1].room_no,
            't_profession':obj[-1].t_profession}
   
    return data 

def tenent_details(connection,t_name,t_address,t_phone,room_no,t_profession): #tenent service variables
    obj=tenent.Tenent(t_name=t_name,t_phone=t_phone,room_no=room_no,t_address=t_address,t_profession=t_profession) #column name=tenent service variables
    connection.add(obj)
    connection.commit()
    
    return "added successfully"

def update_details(connection,t_id):
    obj=connection.query(tenent.Tenent.t_id,tenent.Tenent.t_name,tenent.Tenent.t_address,tenent.Tenent.t_phone,tenent.Tenent.date_of_joining,tenent.Tenent.room_no,tenent.Tenent.t_profession).filter(tenent.Tenent.t_id==t_id).first()
    
        
    data={ 't_id':obj.t_id,
            't_name':obj.t_name,
            't_address':obj.t_address,
            't_phone':obj.t_phone,
            'date_of_joining':str(obj.date_of_joining),
            'room_no':obj.room_no,
            't_profession':obj.t_profession}
           
    return data 


def edit_details(t_id,t_name,t_address,t_phone,room_no,t_profession,connection):
    
    obj = connection.query(tenent.Tenent).filter(tenent.Tenent.t_id == t_id).first()
    print(obj)
    if obj is not None:
        obj.t_name = t_name
        obj.t_address = t_address
        obj.t_phone = t_phone
        obj.room_no= room_no
        obj.t_profession = t_profession
        connection.commit()
        return True
    return False

def delete_details(connection,id):
    
    obj =connection.query(tenent.Tenent).filter(tenent.Tenent.t_id == id).first()
    
    connection.delete(obj)
    connection.commit()
    return 
 
def one_detail(connection,id):

    # select query  .t_id,tenent.Tenent.t_name,tenent.Tenent.t_address,tenent.Tenent.t_phone,tenent.Tenent.date_of_joining,tenent.Tenent.room_no,tenent.Tenent.t_profession
    obj= connection.query(tenent.Tenent.t_id,tenent.Tenent.t_name,tenent.Tenent.t_address,tenent.Tenent.t_phone,tenent.Tenent.date_of_joining,tenent.Tenent.room_no,tenent.Tenent.t_profession).filter(tenent.Tenent.t_id==id).first()

    data={ 't_id':obj.t_id,
            't_name':obj.t_name,
            't_address':obj.t_address,
            't_phone':obj.t_phone,
            'date_of_joining':str(obj.date_of_joining),
            'room_no':obj.room_no,
            't_profession':obj.t_profession}
   
    return data     
    
    
def get_all(connection):
    obj= connection.query(tenent.Tenent.t_id,tenent.Tenent.t_name,tenent.Tenent.t_address,tenent.Tenent.t_phone,tenent.Tenent.date_of_joining,tenent.Tenent.room_no,tenent.Tenent.t_profession).all()
   
    data=[]
    for i in obj:
                data.append({ 't_id':i.t_id,
                        't_name':i.t_name,
                        't_address':i.t_address,
                        't_phone':i.t_phone,
                        'date_of_joining':str(i.date_of_joining),
                        'room_no':i.room_no,
                        't_profession':i.t_profession})
   
    return data  




     
