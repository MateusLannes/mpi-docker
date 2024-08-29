from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

# Process master
if rank == 0:
    data = {'x': 1, 'y': 2.0}
    # Master process sends data to worker processes by
    # going through the ranks of all worker processes
    for i in range(1, size):
        comm.send(data, dest=i, tag=i)
    print(f'Process {rank} sent data:', data)
# Worker processes
else:
    # Each worker process receives data from master process
    data = comm.recv(source=0, tag=rank)
    print(f'Process {rank} received data:', data)
