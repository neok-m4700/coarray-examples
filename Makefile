MPI_DIR=$(CONDA_PREFIX)
OPENCOARRAYS_DIR=$(CONDA_PREFIX)/lib

ALLCOARRAYF90=$(wildcard */*-coarray.f90 ) 
ALLMPIF90=$(wildcard */*-mpi.f90 ) 

ALLCOARRAY=$(basename $(ALLCOARRAYF90))
ALLMPI=$(basename $(ALLMPIF90))

.PHONY: clean

all: allcoarray allmpi

allcoarray: $(ALLCOARRAY)

allmpi:     $(ALLMPI)

%-coarray:%-coarray.f90
	${MPI_DIR}/bin/mpifort $^ -fcoarray=lib -o $@ -L${OPENCOARRAYS_DIR} -lcaf_mpi

%-mpi:%-mpi.f90
	${MPI_DIR}/bin/mpifort $^ -o $@

runcoarray: allcoarray
	@for exe in $(ALLCOARRAY); do echo "\n\t==> $$exe <==\n"; mpiexec -n 4 -l $$exe; done

runmpi: allmpi
	@for exe in $(ALLMPI); do echo "\n\t==> $$exe <==\n"; mpiexec -n 4 -l $$exe; done

runall: runcoarray runmpi

clean:
	-rm -f $(ALLCOARRAY) $(ALLMPI)
	-rm -f */*.o
