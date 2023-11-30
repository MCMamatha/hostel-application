from sqlalchemy import*
from sqlalchemy.ext.declarative import declarative_base


Base=declarative_base()


class Room(Base):
    __tablename__='room'
    __table_args__={'schema':'hostel'}
    
    r_id=Column(Integer,nullable=False,primary_key=True,autoincrement='auto')
    r_no=Column(Integer,nullable=False,primary_key=True)
    r_sharing=Column(Integer,nullable=False)