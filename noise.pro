PRO noise

openr,lun,'noise.dat',/get_lun 

n=40

noiza=make_array(n)

t51_70=0.0
for i=0, n/2-1 do begin
	readf,lun,a
	noiza[i]=a
	t51_70=t51_70+a
endfor
n51_70=t51_70/20
print,'n51_70',n51_70

t181_200=0.0
for i=n/2, n-1 do begin
	readf,lun,a
	noiza[i]=a
	t181_200=t181_200+a
endfor
n181_200=t181_200/20
print,'n181_200',n181_200
print

ttl=t51_70+t181_200
avrg=ttl/n

print,'noise for each channel'
print,noiza
print
print,' ttl ',' number ',' average ',' average ',' 1/2 average '
print,ttl,n,avrg,avrg/2


close,lun
free_lun,lun

;print,noizaray

RETURN
END

