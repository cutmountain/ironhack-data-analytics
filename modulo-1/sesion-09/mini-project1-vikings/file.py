from vikingsClasses import Soldier
from vikingsClasses import Viking
from vikingsClasses import Saxon
from vikingsClasses import War

print("Construyendo ejércitos...")
war = War()
war.addViking(Viking("María José", 300, 150))
war.addViking(Viking("Cristian", 500, 100))
war.addSaxon(Saxon(800, 200))
war.addSaxon(Saxon(600, 200))

print("Empieza al guerra!")
war.vikingAttack()
war.vikingAttack()
war.saxonAttack()
war.showStatus()
