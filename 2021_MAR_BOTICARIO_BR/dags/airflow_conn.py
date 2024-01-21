user="root"
pass_w="test_user"
add="localhost"
port_nm="5432"
db_nm="challenge_db"

conn_string = 'postgresql://{}:{}@{}:{}/{}'.format(user,pass_w,add,port_nm,db_nm)
