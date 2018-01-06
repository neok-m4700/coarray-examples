program broadcast2
    implicit none
    integer :: a[*] 

    if (this_image() == 1) then 
        ! print *, "Please enter a number." 
        ! read *, a
        open(7, file="inp"); read(7, *) a; close(7)
    end if

    sync all 

    a = a[1]

    print *, this_image(), ' has a = ', a
end program broadcast2
