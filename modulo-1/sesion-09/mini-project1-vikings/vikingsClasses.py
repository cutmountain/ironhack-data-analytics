import random

# Soldier

class Soldier:
    def __init__(self, health, strength):
        self.health = health
        self.strength = strength
    
    def attack(self):
        return self.strength

    def receiveDamage(self, damage):
        self.health -= damage
    

# Viking

class Viking(Soldier):
    def __init__(self, name, health, strength):
        super().__init__(health, strength)
        self.name = name

    def battleCry(self):
        return "Odin Owns You All!"

    def receiveDamage(self, damage):
        self.health -= damage        
        if self.health > 0:
            mensaje = f"{self.name} ha recibido {damage} puntos de daño"
        else:
            mensaje = f"{self.name} ha muerto en acto de combate"
        return print(mensaje)

# Saxon

class Saxon(Soldier):
    def __init__(self, health, strength):
        super().__init__(health, strength)

    def receiveDamage(self, damage):
        self.health -= damage
        if self.health > 0:
            mensaje = f"Un 'Saxon' ha recibido {damage} puntos de daño"
        else:
            mensaje = f"Un 'Saxon' ha muerto en combate"
        return print(mensaje)

# Davicente

class War():
    def __init__(self):
        self.vikingArmy = []
        self.saxonArmy = []
        
    def addViking(self, viking):
        self.vikingArmy.append(viking)
        
    def addSaxon(self, saxon):
        self.saxonArmy.append(saxon)
        
    def vikingAttack(self):
        # Seleccionar soldados aleatoriamente
        saxon = random.choice(self.saxonArmy)
        viking = random.choice(self.vikingArmy)        
        # Daño
        mensaje = saxon.receiveDamage(viking.strength)
        # Eliminar muertos
        if saxon.health <= 0:
            self.saxonArmy.remove(saxon)
        
    def saxonAttack(self):
        # Seleccionar soldados aleatoriamente
        saxon = random.choice(self.saxonArmy)
        viking = random.choice(self.vikingArmy)        
        # Daño
        mensaje = viking.receiveDamage(saxon.strength)
        # Eliminar muertos
        if viking.health <= 0:
            self.vikingArmy.remove(viking)
        
    def showStatus(self):
        if len(self.saxonArmy) == 0:
            mens = "¡Los Vikingos han ganado la guerra del siglo!"
        elif len(self.vikingArmy) == 0:
            mens = "Los Sajones han luchado por sus vidas y sobreviven otro día..."            
        else:
            mens = "Los Vikingos y los Sajones todavía están en plena batalla."            
        return print(mens)
    pass
    
#yop
#class War2:
    #def __init__(self):
        # your code here
    #def addViking(self, Viking):
        # your code here
    #def addSaxon(self, Saxon):
        # your code here
    #def vikingAttack(self):
        # your code here
    #def saxonAttack(self):
        # your code here
    #def showStatus(self):
        # your code here
    #pass










