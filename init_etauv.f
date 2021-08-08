          parameter(m=1100,n=700)
          real eta(m,n), u(m,n), v(m,n)
          real hNorm, uNorm, So
          
          hNorm = 0.00798
          uNorm = 0.5596
          So = 0.0

          do j=1,n
          do i=1,m
            eta(i,j)=0.0
c             eta(i,j)=0.0
            u(i,j)=uNorm
            v(i,j)=0.0
          enddo
          enddo

          open(2,file='eta.txt')
          do j=1,n
            write(2,100)(eta(i,j),i=1,m)
          enddo
100       format(1000f12.5)

          close(2)
          
          open(3,file='u.txt')
          do j=1,n
            write(3,200)(u(i,j),i=1,m)
          enddo
200       format(1000f12.5)

          close(3)
          
          open(4,file='v.txt')
          do j=1,n
            write(4,300)(v(i,j),i=1,m)
          enddo
300       format(1000f12.5)

          close(4)
          end

          
