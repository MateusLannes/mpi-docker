from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

if rank == 0:
    data = {'x': 1, 'y': 2.0}
    for i in range (1, size):
        comm.send(data, dest=i, tag=i)
        print('Process {} sent data:'.format(rank), data)
else:
    data = comm.recv(source=0, tag=rank)
    print('Process {} received data:'.format(rank), data)
