from model import room

def room_details(r_no,r_sharing,connection):
    obj=room.Room(r_no=r_no,r_sharing=r_sharing)
    connection.add(obj)
    connection.commit()
    
    return "successfully posted"

def one_detail(connection,id):
    obj=connection.query(room.Room.r_id,room.Room.r_no,room.Room.r_sharing).filter(room.Room.r_id==id).first()
    
    data={
        'r_id':obj.r_id,
        'r_no':obj.r_no,
        'r_sharing':obj.r_sharing
    }
    return data

def delete_single_room(connection,id):
    obj=connection.query(room.Room).filter(room.Room.r_id==id).first()
    print("from dao 1")
    if obj is not None:
    
        
        connection.delete(obj)
        connection.commit()

        return "deleted successfully"
  
    
    return "no such id"
def get_details_to_edit(connection,id):
    obj=connection.query(room.Room.r_id,room.Room.r_no,room.Room.r_sharing).filter(room.Room.r_id==id).first()
    
    data={
        'r_id':obj.r_id,
        'r_no':obj.r_no,
        'r_sharing':obj.r_sharing
    }
    return data

def update_details(connection,r_id,r_no,r_sharing):
    obj=connection.query(room.Room).filter(room.Room.r_id==r_id).first()
    print(type(obj.r_no))
    print(type(obj.r_sharing))
    if obj is not None:
        print("jkhassdkf")
        obj.r_no=r_no
        obj.r_sharing=r_sharing
        connection.commit()
        return "successfully updated"
        
    return "unable to add"

def view_all_rooms(connection):
    obj=connection.query(room.Room.r_id,room.Room.r_no,room.Room.r_sharing).all()
    
    data=[]
    for i in obj:
                data.append({
                    'r_id':i.r_id,
                    'r_no':i.r_no,
                    'r_sharing':i.r_sharing
                })
    return data    