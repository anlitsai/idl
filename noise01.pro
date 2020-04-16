PRO noise

openr,lun,'noise.dat',/get_lun 

n=20

noiza=double(n)
print,noiza

for i=0,n-1 do begin
	readf,lun,noiza[i]
	print,i,noiza[i]
endfor

close,lun
free_lun,lun

;print,noizaray

RETURN
END

