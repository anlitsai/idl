PRO IMF

; Matsushita et al. 2000, apj, 545, L107-L111, p.L109

; dni/dm=a0*mi^ind
; dn=m^inddm
; i=(1-100)M_sun

dm=5
i=100/dm
ind=-2.5

dni_25_30=1500.0
mi_25_30=27.5
; dni_25_30/dm=a0*mi_25_30^ind
;
; dni_25_30/dni_1_5=mi_25_30^ind/mi_1_5^ind
; log[dni_25_30/dni_1_5]=log[mi_25_30^ind/mi_1_5^ind]
; log[dni_25_30]-log[dni_1_5]=ind*log[mi_25_30]-ind*log[mi_1_5]

; dni_25_30/dm=a0*mi_25_30^ind
a0=dni_25_30/dm/mi_25_30^ind
print,"a0",a0

;dni/dm=a0*mi^ind

mi=findgen(i)*dm+0.5*dm

dni=a0*mi^ind*dm
;n=a*dm^(ind+1)
;print,n

sum_n=0.0
sum_m=0.0
	print,"     [j]","        mi[j]","       dni[j]","       sum_n","         mi[j]","  dni[j]*mi[j]","       sum_m"
for j=0,i-1 do begin
	sum_n=sum_n+dni[j]
	dmi=dni[j]*mi[j]
	sum_m=sum_m+dmi
	print,j,mi[j],dni[j],sum_n,mi[j],dmi,sum_m
endfor

sum_n=0.0
sum_m=0.0
for k=6,i-1 do begin
	sum_n=sum_n+dni[k]
	dmi=dni[k]*mi[k]
	sum_m=sum_m+dmi
endfor
print,sum_n,sum_m


; dN = a * m^ind * dm
; N = int [ a* m^ind * dm ]
; N = a * [ m^(ind+1) ]
; N_25_30 = a * [ m^(ind+1) ] 25_30
; 1500 = a * [ (25^(ind+1)-30^(ind+1) ] 
; a = 1500 / [ (25^(ind+1)-30^(ind+1) ] 
a = 1500 / (25^(ind+1)-30^(ind+1) )
N_1_100 = a * ( 1^(ind+1)-100^(ind+1) )
print,"	a =", a 
print,"	N (1-100 Msun) =", N_1_100
; dM = m * dN 
; M = int [ m * dN ]
; M = int [ m * a * m^ind * dm ]
; M = a * m * [ m^(ind + 1) ]
; M = a * [ m^(ind + 2) ]
M_1_100 = a * ( 1 - 100^(ind + 2) )
print, "	M (1-100 Msun) =", M_1_100



RETURN
END

