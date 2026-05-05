#!/bin/bash
DB_NAME="GTGTOLD"
DB_USER="root"
DB_PASS="Virgo.66"

# Obtener lista de tablas
TABLES=$(mariadb -u "$DB_USER" -p"$DB_PASS" -e "SELECT table_name FROM information_schema.tables WHERE table_schema = '$DB_NAME';" | grep -v "table_name")

# Optimizar cada tabla
#for TABLE in $TABLES; do
#    echo "Optimizando tabla: $TABLE"
#    mysql -u "$DB_USER" -p"$DB_PASS" -e "USE $DB_NAME; OPTIMIZE TABLE \`$TABLE\`;"
#done

for TABLE in $TABLES; do
    echo "Reoptimizando tabla (InnoDB): $TABLE"
    mariadb -u "$DB_USER" -p"$DB_PASS" -e "USE $DB_NAME; ALTER TABLE \`$TABLE\` ENGINE=InnoDB;"
done