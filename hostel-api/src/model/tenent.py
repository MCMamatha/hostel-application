from sqlalchemy import*
from sqlalchemy.ext.declarative import declarative_base


Base=declarative_base()


class Tenent(Base):
    __tablename__='tenent'
    __table_args__={'schema':'hostel'}
    
    t_id=Column(Integer,nullable=False,primary_key=True,autoincrement=True)
    t_name=Column(Integer,nullable=False,primary_key=True)
    t_address=Column(String,nullable=False)
    t_phone=Column(BIGINT,nullable=False)
    date_of_joining=Column(TIMESTAMP,nullable=False)
    room_no=Column(Integer,nullable=False)
    t_profession=Column(String,nullable=False)
  
    
    
    