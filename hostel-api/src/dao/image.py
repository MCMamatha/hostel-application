from sqlalchemy import Text
from model import image,tenent

def get_id(connection,id):
    obj =connection.query(tenent.Tenent.t_id,tenent.Tenent.t_name).filter(tenent.Tenent.t_id == id).first()   
    
    data={
        't_id':obj.t_id,
        't_name':obj.t_name
    }
    
    return data

# def upload(connection):
#     obj=connection.query(image.Image.t_id,image.Image.t_name)