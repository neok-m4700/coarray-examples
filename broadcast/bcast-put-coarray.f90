program broadcast
   implicit none
   integer :: a[*]
   integer :: i

   if (this_image() == 1) then
      ! print *, "Please enter a number."
      ! read *, a
      open(7, file="inp"); read (7, *) a; close (7)
      do i = 1, num_images()
         a[i] = a
      end do
   end if

   sync all

   print *, this_image(), ' has a = ', a
end program broadcast
