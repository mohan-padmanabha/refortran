program hdf5write
use HDF5
IMPLICIT NONE

CHARACTER(LEN=11), PARAMETER :: filename = "mesh.h5" ! File name
CHARACTER(LEN=11), PARAMETER :: cordf = "coordinates" , velf = "velocity", pref = "pressure", nodef = "nodes"    ! Dataset name
!INTEGER :: dimsize = n ! Size of the dataset

INTEGER(HID_T) :: file_1       ! File identifier
INTEGER(HID_T) :: dset_1, dset_2, dset_3, dset_4       ! Dataset identifier
INTEGER(HID_T) :: dspace_1, dspace_2, dspace_3, dspace_4      ! Dataspace identifier


INTEGER(HSIZE_T), DIMENSION(2) :: dims_1 ! Dataset dimensions
INTEGER(HSIZE_T), DIMENSION(2) :: dims_2 ! Dataset dimensions
INTEGER(HSIZE_T), DIMENSION(1) :: dims_3 ! Dataset dimensions
INTEGER(HSIZE_T), DIMENSION(1) :: dims_4 ! Dataset dimensions
INTEGER     ::   rank_1, rank_2, rank_3, rank_4  ! Dataset rank

INTEGER     ::   error ! Error flag

INTEGER :: i, n

REAL, allocatable :: cord(:,:), vel(:,:), pre(:)
INTEGER, allocatable :: node(:)
open(1, file="raw_data.dat", status='old', action='read')
n = 480
allocate (cord(3,n))
allocate (vel(3,n))
allocate (pre(n))
allocate (node(n))
rank_1 = 2
rank_2 = 2
rank_3 = 1
rank_4 = 1

dims_1 = (/3,n/)
dims_2 = (/3,n/)
dims_3 = n
dims_4 = n
do i = 1, n
 read(1,*) cord(1,i), cord(2,i), cord(3,i), vel(1,i), vel(2,i), vel(3,i), pre(i), node(i)
end do
 close(1) 

CALL h5open_f(error)

CALL h5fcreate_f(filename, H5F_ACC_TRUNC_F, file_1, error)

CALL h5screate_simple_f(rank_1, dims_1, dspace_1, error)

CALL h5dcreate_f(file_1, cordf, H5T_NATIVE_REAL, dspace_1, dset_1, error)

CALL h5screate_simple_f(rank_2, dims_2, dspace_2, error)

CALL h5dcreate_f(file_1, velf, H5T_NATIVE_REAL, dspace_2, dset_2, error)

CALL h5screate_simple_f(rank_3, dims_3, dspace_3, error)

CALL h5dcreate_f(file_1, pref, H5T_NATIVE_REAL, dspace_3, dset_3, error)

CALL h5screate_simple_f(rank_4, dims_4, dspace_4, error)

CALL h5dcreate_f(file_1, nodef, H5T_NATIVE_INTEGER, dspace_4, dset_4, error)



dims_1(1:2) = (/3, n/) 
CALL h5dwrite_f(dset_1, H5T_NATIVE_REAL, cord, dims_1, error)

dims_2(1:2) = (/3, n/) 
CALL h5dwrite_f(dset_2, H5T_NATIVE_REAL, vel, dims_2, error)

dims_3(1) = n
CALL h5dwrite_f(dset_3, H5T_NATIVE_REAL, pre, dims_3, error)

dims_4(1) = n 
CALL h5dwrite_f(dset_4, H5T_NATIVE_INTEGER, node, dims_4, error)



CALL h5dclose_f(dset_1, error)
CALL h5dclose_f(dset_2, error)
CALL h5dclose_f(dset_3, error)
CALL h5dclose_f(dset_4, error)

CALL h5sclose_f(dspace_1, error)
CALL h5sclose_f(dspace_2, error)
CALL h5sclose_f(dspace_3, error)
CALL h5sclose_f(dspace_4, error)

CALL h5fclose_f(file_1, error)

CALL h5close_f(error)

end program hdf5write
