#1. Importa el paquete NUMPY bajo el nombre np.

import numpy as np


#2. Imprime la versión de NUMPY y la configuración.

print(np.version.version)
'''
1.26.4
'''


#3. Genera un array tridimensional de 2x3x5 con valores aleatorios. Asigna el array a la variable "a"
# Desafío: hay al menos tres maneras fáciles que usan numpy para generar arrays aleatorios. ¿Cuántas formas puedes encontrar?

a = np.random.random((2, 3, 5))
a = np.random.randint(10, size=(2, 3, 5))

#4. Imprime a.
print(a)
print("\nThe dimension is:", a.ndim)
print("The shape is:", a.shape)
print("The size is:", a.size)

#5. Crea un array tridimensional de 5x2x3 con todos los valores igual a 1.
#Asigna el array a la variable "b"

b = np.ones((5, 2, 3))
b = np.full((5, 2, 3), 1)

#6. Imprime b.

print(b)

#7. ¿Tienen a y b el mismo tamaño? ¿Cómo lo demuestras en código Python?

print("The size of a (", a.size, ") is equal to the size of b (", b.size, ")")

#8. ¿Es posible sumar a y b? ¿Por qué sí o por qué no?

# No se pueden sumar porque tienen formas distintas
print(a.shape, " vs. ", b.shape)

#9. Transpone b para que tenga la misma estructura que a (es decir, se convierta en un array de 2x3x5). Asigna el array transpuesto a la variable "c".

c = np.transpose(b, (1, 2, 0))
print(c)
print("a is ", a.shape, " and c is ", c.shape)


#10. Intenta sumar a y c. Ahora debería funcionar. Asigna la suma a la variable "d". Pero, ¿por qué funciona ahora?

d = a + c # Ahora funciona porque ambas matrices tienen la misma forma 2x3x5

#11. Imprime a y d. ¿Notas la diferencia y la relación entre los dos arrays en términos de los valores? Explica.

print(a)
print(d)
# Como la matriz original b (y su transpuesta c) era una matriz de valores uno, la matriz resultante d es la a + 1 en todos los valores

#12. Multiplica a y c. Asigna el resultado a e.

e = a * c

#13. ¿Es e igual a a? ¿Por qué sí o por qué no?

# Sí, son iguales porque multiplicar x 1 (que son todos los valores de la matrix c) deja los valores de a como están.

#14. Identifica los valores máximos, mínimos y medios en d. Asigna esos valores a las variables "d_max", "d_min" y "d_mean"

d_max = np.max(d)
d_min = np.min(d)
d_mean = np.mean(d)

print("d_max = ", d_max)
print("d_min = ", d_min)
print("d_meam = ", d_mean)


#15. Ahora queremos etiquetar los valores en d. Primero crea un array vacío "f" con la misma forma (es decir, 2x3x5) que d usando `np.empty`.

#f = np.empty((2, 3, 5), dtype=int)
f = np.empty((2, 3, 5))

print(f)



"""
#16. Rellena los valores en f. Para cada valor en d, si es mayor que d_min pero menor que d_mean, asigna 25 al valor correspondiente en f.
Si un valor en d es mayor que d_mean pero menor que d_max, asigna 75 al valor correspondiente en f.
Si un valor es igual a d_mean, asigna 50 al valor correspondiente en f.
Asigna 0 al valor correspondiente(s) en f para d_min en d.
Asigna 100 al valor correspondiente(s) en f para d_max en d.
Al final, f debería tener solo los siguientes valores: 0, 25, 50, 75 y 100.
Nota: no necesitas usar Numpy en esta pregunta.
"""

for x in range(0,d.shape[0]):
 for y in range(0,d.shape[1]):
    for z in range(0,d.shape[2]):
        valor = d[x,y,z]
        if valor > d_min and valor < d_mean:
            f[x,y,z] = 25
        elif valor > d_mean and valor < d_max:
            f[x,y,z] = 75
        elif valor == d_mean:
            f[x,y,z] = 50
        elif valor == d_min:
            f[x,y,z] = 0
        else:
            f[x,y,z] = 100        


print(f)



"""
#17. Imprime d y f. ¿Tienes el f esperado?
Por ejemplo, si tu d es:
array([[[1.85836099, 1.67064465, 1.62576044, 1.40243961, 1.88454931],
        [1.75354326, 1.69403643, 1.36729252, 1.61415071, 1.12104981],
        [1.72201435, 1.1862918 , 1.87078449, 1.7726778 , 1.88180042]],

       [[1.44747908, 1.31673383, 1.02000951, 1.52218947, 1.97066381],
        [1.79129243, 1.74983003, 1.96028037, 1.85166831, 1.65450881],
        [1.18068344, 1.9587381 , 1.00656599, 1.93402165, 1.73514584]]])

Tu f debería ser:
array([[[ 75.,  75.,  75.,  25.,  75.],
        [ 75.,  75.,  25.,  25.,  25.],
        [ 75.,  25.,  75.,  75.,  75.]],

       [[ 25.,  25.,  25.,  25., 100.],
        [ 75.,  75.,  75.,  75.,  75.],
        [ 25.,  75.,   0.,  75.,  75.]]])
"""

print("d_min = ", d_min, ", d_meam = ", d_mean, ", d_max = ", d_max)
print(d)
print(f) # Sí, el resultado es el esperado



"""
#18. Pregunta de bonificación: en lugar de usar números (es decir, 0, 25, 50, 75 y 100), ¿cómo usar valores de cadena 
("A", "B", "C", "D" y "E") para etiquetar los elementos del array? Esperas el resultado sea:
array([[[ 'D',  'D',  'D',  'B',  'D'],
        [ 'D',  'D',  'B',  'B',  'B'],
        [ 'D',  'B',  'D',  'D',  'D']],

       [[ 'B',  'B',  'B',  'B',  'E'],
        [ 'D',  'D',  'D',  'D',  'D'],
        [ 'B',  'D',   'A',  'D', 'D']]])
De nuevo, no necesitas Numpy en esta pregunta.
"""

f = np.empty((2, 3, 5), dtype=str)

for x in range(0,d.shape[0]):
 for y in range(0,d.shape[1]):
    for z in range(0,d.shape[2]):
        valor = d[x,y,z]
        if valor > d_min and valor < d_mean:
            f[x,y,z] = "B"
        elif valor > d_mean and valor < d_max:
            f[x,y,z] = "D"
        elif valor == d_mean:
            f[x,y,z] = "C"
        elif valor == d_min:
            f[x,y,z] = "A"
        else:
            f[x,y,z] = "E"        

print(f)