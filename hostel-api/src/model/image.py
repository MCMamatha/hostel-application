from sqlalchemy import*
from sqlalchemy.ext.declarative import declarative_base


Base=declarative_base()

class Image(Base):
    __tablename__='image'
    __table_args__={'schema':'hostel'}
    
    i_id=Column(Integer,nullable=False,primary_key=True,autoincrement='auto')
    t_id=Column(Integer,nullable=False)
    t_name=Column(String,nullable=False)
    t_image=Column(BLOB,nullable=False)
   