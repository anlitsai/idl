PRO IMF

; Matsushita et al. 2000, apj, 545, L107-L111, p.L109

; dn=m^(-2.5)dm
; i=(1-100)M_sun

a=1500.0*30
ind=-2.5

dm=findgen(100)+1
dn=a*dm^(ind)
;n=a*dm^(ind+1)
;print,n

sum_n=0.0
for i=0,99 do begin
	sum_n=sum_n+dn[i]
	print,i,dm[i],dn[i],sum_n
endfor

;print,0.5*a*(1+100.0^(-1.5))

RETURN
END

