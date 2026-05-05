import qrcode

def generar_codigos_qr(rango_codigos):
    for i in range(1, rango_codigos + 1):
        codigo = "{:03d}".format(i)
        qr = qrcode.QRCode(
            version=1,
            error_correction=qrcode.constants.ERROR_CORRECT_L,
            box_size=10,
            border=4,
        )
        qr.add_data(codigo)  # Se agrega el número del código directamente
        qr.make(fit=True)

        img = qr.make_image(fill_color="black", back_color="white")
        img.save("codigoQR_{}.png".format(codigo))

# Generar códigos QR con solo el número al que pertenece
generar_codigos_qr(80)
