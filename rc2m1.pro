PRO rc2m1
; copy from PRO vel28func02
; show unit in [km/s]
; show pv + rotation curve in window
; ---------------------------------------------------------------
; read fits data 
; ---------------------------------------------------------------
PV_fits_ms=fits06m1('N2146U_12CO.XSU943.1.FITS')
; PV_fits_ms=fits06m1('N2146U_12CO.M1.R43.6112.FITS')
; ---------- define constant and claim variable -----------------
PV_fits_kms=PV_fits_ms/1000.0
pv_rang=size(PV_fits_ms,/dimensions)
help, PV_fits_ms
posi_rang=pv_rang[0]
vel_rang=pv_rang[1]
pi = !pi/180
inclination=70.0
print,"inclination [deg]",inclination
R_intv=1.0
R_pt=posi_rang*R_intv
;PV_mod_kms=make_array(R_pt,vel_rang,value=-1/0.0,/double)
PV_mod_kms=make_array(R_pt,value=9999.0,/double)
;PV_mod_kms=make_array(R_pt,vel_rang,value=9999.0,/double)
;V2pix_mod_kms=make_array(vel_rang+1,value=0.0,/double)
;PV_mod_kms=make_array(R_pt,R_pt,value=0.0,/double)
;PV_resi_kms=make_array(R_pt,R_pt,value=0.0,/double)
PV_resi_kms=make_array(R_pt,value=0.0,/double)
resi_cur=make_array(R_pt,value=0.0,/double)
resi_x=make_array(R_pt,value=0.0,/double)
;m1_num=40.0
chsiz=1
xsiz=600	; window display size
;ysiz=xsiz
ysiz=600
xdeg=60
Xc=512.48
Vc=59.00
;Vc=900.00
R_px_mm=116.0/600.0	; the number comes from FUNCTION curmod19,Ro
;R_px_mm=1.0	; the number comes from FUNCTION curmod19,Ro
;V_px_kms=400.0/164.5	; the number comes from FUNCTION curmod19,Ro
xrg=[300,700]
vrg_px=[0,120]
;vrg_px=[10,110]
vrg_kms=vrg_px
;vrg_kms=[0,0]
;vrg_kms=[Vc-200,Vc+200]
Vc_lin=make_array(pv_rang[0],pv_rang[1],value=1/0.0)
Vc_lin[59,*]=1.0
; ---------------------------------------------------------------
; Use a Model of Rotation Curve 
; ---------------------------------------------------------------
;i_pi = inclination * pi
;inclin = cos(i_pi)
;for xi0 = 0, 1023 do begin
for xi0 = xrg[0], xrg[1] do begin
	xi=xi0*R_intv-Xc
	if xi ge 0 then begin
		del_v=curmod19(xi)
;		PV_mod_kms[xi0]=del_v
;		PV_mod_kms[xi0]=(del_v+Vc)
;		PV_mod_kms[xi0]=(del_v)*R_px_mm
;		PV_mod_kms[xi0]=(del_v+Vc)*R_px_mm
		PV_mod_kms[xi0]=(del_v)*R_px_mm+Vc
;		PV_mod_kms[xi0]=(del_v+Vc)*V_px_kms
	endif else begin
		del_v=curmod19(abs(xi))
;		PV_mod_kms[xi0]=-del_v
;		PV_mod_kms[xi0]=(-del_v+Vc)
;		PV_mod_kms[xi0]=(-del_v)*R_px_mm
;		PV_mod_kms[xi0]=(-del_v+Vc)*R_px_mm
		PV_mod_kms[xi0]=(-del_v)*R_px_mm+Vc
;		PV_mod_kms[xi0]=(-del_v+Vc)*V_px_kms
	endelse
endfor
for xi0=0,1023 do begin
	if abs(PV_mod_kms[xi0]) ge 500.0 then begin
		PV_mod_kms[xi0] = 1/0.0
	endif
endfor
help, PV_mod_kms
help, Vc_lin
help, PV_fits_ms
;print, PV_mod_kms
; ---------------------------------------------------------------
; residual = fits data - model 
; ---------------------------------------------------------------
;PV_resi_kms=PV_fits_kms-PV_mod_kms
; ===============================================================
; ---------- set the contour levels of model --------------------
;PV_mod_kms_nan=PV_mod_kms
;for xi0=0,R_pt-1 do begin
;	for vi0=0,R_pt-1 do begin
;		if ((PV_mod_kms_nan[xi0,vi0]) eq 0.0) then begin
;			PV_mod_kms_nan[xi0,vi0] = 1.0/0.0
;		endif
;	endfor
;endfor
; ---------- set the contour levels of resi ----------------------
;PV_resi_kms_nan=PV_fits_kms-PV_mod_kms_nan
; --- find the residual rotational curve along major axis ---
;for xi0 = 0,R_pt-1 do begin 
;	xi=xi0*R_intv
;	resi_cur[xi0]=PV_resi_kms_nan[xi0,fix(Vc)]
;	resi_x[xi0]=xi-Xc
;	print,xi,resi_cur[xi0]
;endfor
;help,resi_cur
; ---------- set the contour levels of fits ----------------------
;m1_num=20.0
; --- contour value of fits file ---
;lev_fits_kms=findgen(m1_num)*12+670.0	; [km/s]
lev_fits_ms=[0.3,0.5,0.7,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,8.5,9,9.5]*0.114853	; [m/s]
lev_fits_kms=lev_fits_ms/1000	; [km/s]
;print,"fits",lev_fits_kms
; --- contour value of model ---
;mod_max=max(PV_mod_kms_nan,/nan)
;mod_min=min(PV_mod_kms_nan,/nan)
;mod_intv=(mod_max-mod_min)/m1_num
;lev_mod_kms=findgen(m1_num+1)*mod_intv+mod_min	; [km/s]
;print,"lev_mod_kms",lev_mod_kms
; --- contour value of residual ---
;resi_max=max(PV_resi_kms_nan,/nan)
;resi_min=min(PV_resi_kms_nan,/nan)
;resi_intv=(resi_max-resi_min)/m1_num
;lev_resi_kms=findgen(m1_num+1)*resi_intv+resi_min	; [km/s]
;print,"resi",lev_resi_kms
; --- show lab ---
;lab=make_array(m1_num,value=1,/integer)
; ----------------------------------------------------------------
; ---------- test ----------
;a=480
;b=550
;print,a,b,PV_mod_kms[a,b]
; ========== define window ======================================
!P.MULTI=[0,1,1]
device,set_character_size=[9,12]
; ---------- fits ----------
window,0,retain=2,xsize=xsiz,ysize=ysiz
contour,PV_fits_kms, $
	xrange=xrg,yrange=vrg_px, $
	title="Fits Data", xtitle="pixels (RA)",ytitle="pixel (velocity)", $;,ztitle="velocity [km/s]", $
	levels=lev_fits_kms, $
	c_label=lab, c_charsize=chsiz, $
	charsize=chsiz, $
	xstyle=1,ystyle=1;, $
;oplot,PV_mod_kms
oplot,Vc_lin
; ---------- model ----------
window,1,retain=2,xsize=xsiz,ysize=ysiz
plot,PV_mod_kms,$
	xrange=xrg, yrange=vrg_kms, $
	title="Model", xtitle="pixels (RA)",ytitle="velocity (km/s)"
;print,PV_mod_kms
;ncol_mod_kms=(m1_num+1)+1
;btm=10
;print,ncol_mod_kms
;loadct,39,ncolors=ncol_mod_kms,bottom=btm
; --- 2d contour ---
;contour,PV_mod_kms_nan, $
;	xrange=xrg,yrange=vrg, $
;	title="Model", xtitle="pixels (RA)",ytitle="pixels (DEC)", $;,ztitle="velocity [km/s]", $
;	levels=lev_mod_kms,c_label=lab, c_charsize=chsiz, $
;	charsize=chsiz, $
;	xstyle=1,ystyle=1, $
;	c_colors=findgen(20), /fill;, $
; ---------- residual ----------
;window,2,retain=2,xsize=xsiz,ysize=ysiz
; --- 2d contour ---
;contour,PV_resi_kms,$
;	xrange=xrg,yrange=vrg, $
;	title="Data - Model", $ ;xtitle="pixels (RA)",ytitle="pixels (DEC)",ztitle="velocity [km/s]", $
;	levels=lev_resi_kms,c_label=lab, c_charsize=chsiz, $
;	charsize=chsiz
; ---------- residual curve ----------
;window,3,retain=2,xsize=xsiz/2,ysize=ysiz/2
;plot,resi_cur,xrange=xrg, $
;	title="Data - Mod", xtitle="pixels (RA)",ytitle="delta velocity [km/s]"
; ---------------------------------------------------------------


RETURN
END


