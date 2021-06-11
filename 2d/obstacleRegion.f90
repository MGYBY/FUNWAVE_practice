         parameter(m=1300,n=700)
         real x(m,n),y(m,n)
         real dx, dy
         real leftCoord, rightCoord, topCoord, bottomCoord
         integer iobs(m,n)
         integer i, j
         integer :: leftInd=10000, rightInd=0, topInd=0, bottomInd=70000
         integer :: rmaxYInd=0

         dx = 0.01
         dy = 0.01
         leftCoord = 10.0
         rightCoord = 10.40
         topCoord = 2.20
         bottomCoord = 1.80

! obstacles

        do j=1,n
         do i=1,m
           iobs(i,j)=1
         enddo
        enddo    
        
        ! get the x,y coordinates
        do j=1,n
          do i=1,m
            x(i,j)=(i-0.5)*dx
            y(i,j)=(j-0.5)*dy
          enddo
        enddo
        ! get the critical index
        do j=1,n
          do i=1,m
            if((x(i,j)>=leftCoord) .and. (x(i,j)<=rightCoord) .and. (y(i,j)>=bottomCoord) .and. (y(i,j)<=topCoord))then
              if(i<leftInd)then
                leftInd=i
              endif
              if(i>rightInd)then
                rightInd=i
              endif
              if(j<bottomInd)then
                bottomInd=j
              endif
              if(j>topInd)then
                topInd=j
              endif
            endif
          enddo
        enddo
        rmaxYInd = int((topInd+bottomInd)/2)

        do j=1,n
          do i=1,m
            if ((i>=leftInd) .and. (i<=rightInd) .and. (j>=bottomInd) .and. (j<=topInd))then
              iobs(i,j)=0
            endif
         enddo
        enddo


        open(1,file='obs.txt')
         do j=1,n
           write(1,111)(iobs(i,j),i=1,m)
         enddo
        close(1)

        open(2,file='leftInds.txt')
         do j=bottomInd, topInd
           write(2,'(*(I4.2))') leftInd-1, j
         enddo
        close(2)     
        
        open(3,file='rightInds.txt')
        do j=bottomInd, topInd
          write(3,'(*(I4.2))') rightInd+1, j
        enddo
        close(3)    
        
        open(4,file='rmaxYInds.txt')
          write(4,'(*(I4.2))') leftInd-1, rmaxYInd+1
        close(4)   


100     format(3000f12.3) !for real optputs
111     format(3000I3) !for integer optputs

        end
