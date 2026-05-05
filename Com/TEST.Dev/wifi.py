import qrcode

def generar_codigo_qr_wifi(ssid, password, security='WPA'):
    wifi_data = f'WIFI:T:{security};S:{ssid};P:{password};;'
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data(wifi_data)
    qr.make(fit=True)
    qr_img = qr.make_image(fill_color="black", back_color="white")
    qr_img.save("codigoQR_wifi.png")

# Ejemplo de uso:
nombre_red = "GT.GT.GUEST"
contraseña = "guest.gt.gt"
tipo_seguridad = "WPA"  # Puedes usar 'WEP' o 'nopass' para otros tipos de seguridad
generar_codigo_qr_wifi(nombre_red, contraseña, tipo_seguridad)
