from model import room,tenent

def get_details_all(connection):
    obj=connection.query(tenent.Tenent.t_id,tenent.Tenent.t_name,room.Room.r_id,room.Room.r_no
                         ).join(room.Room,tenent.Tenent.room_no == room.Room.r_no,).all()
                         
                        
    data=[]
    
    for row in obj:
        data.append({
            "t_id":row.t_id,
            "t_name":row.t_name,
            "r_id":row.r_id,
            "r_no":row.r_no,
        })
      
    return data                       