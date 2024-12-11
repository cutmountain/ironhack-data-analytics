import numpy as np

def print_indices (indices):
    '''
        Función de ayuda para crear el DataFrame de ratings
        Imprime lista que le pasamos como parámetro, y también dos veces esa lista,
         como preparatorio para el DataFrame de ratings.

        Ejemplo de uso:
            get_users([9666, 9667, 9668, 9669, 9670, 9671, 9672, 9673, 9674, 9675])
    '''
    # Indices
    print(', '.join(map(str, indices)))
    joined_idx = np.concatenate((indices, indices))
    print(', '.join(map(str, joined_idx.tolist())))
    print()

    return


def print_users (indices):
    '''
        Función de ayuda para crear el DataFrame de ratings
        En base a la lista que le pasamos como parámetro, 
         crea una lista de igual longitud que contiene el user_id de cada
         uno de los usuarios para los cuales queremos crear un rating.

        Ejemplo de uso:
            get_users([9666, 9667, 9668, 9669, 9670, 9671, 9672, 9673, 9674, 9675])
    '''
    # Usuarios
    usuario_3 = np.full(len(indices), 3, dtype=np.int8)
    print(', '.join(map(str, usuario_3.tolist())))

    usuario_4 = np.full(len(indices), 4, dtype=np.int8)
    print(', '.join(map(str, usuario_4.tolist())))

    joined_users = np.concatenate((usuario_3, usuario_4))
    joined_users_str = ', '.join(map(str, joined_users.tolist()))
    print(joined_users_str)
    print()

    return

def print_ratings (indices, rating_user_3, rating_user_4):
    '''
        Función de ayuda para crear el DataFrame de ratings
        En base a la lista que le pasamos como parámetro, 
         crea una lista de igual longitud que representa, a modo
         de contenedor para los ratings de los usuarios

        Ejemplo de uso:
            get_users([9666, 9667, 9668, 9669, 9670, 9671, 9672, 9673, 9674, 9675])
    '''
    # Calificaciones
    # rating_user_3 = 5
    # rating_user_4 = 1

    rating_3 = np.full(len(indices), rating_user_3, dtype=np.int8)
    rating_3_str = ', '.join(map(str, rating_3.tolist()))
    print(rating_3_str)

    rating_4 = np.full(len(indices), rating_user_4, dtype=np.int8)
    rating_4_str = ', '.join(map(str, rating_4.tolist()))
    print(rating_4_str)

    joined_rating = np.concatenate((rating_3, rating_4))
    joined_rating_str = ', '.join(map(str, joined_rating.tolist()))
    print(joined_rating_str)
    print()

    return