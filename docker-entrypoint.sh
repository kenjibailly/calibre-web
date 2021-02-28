#!/bin/bash
BOOKS_SCRIPT="/app/Auto_Books_Calibre.sh"
NOTIFICATIONS=$(echo $NOTIFICATIONS | tr a-z A-Z)

# Checking Notifications are enabled
echo "###########################"
echo "# Checking Notifications  #"
echo "###########################"
echo ""
if [ "$NOTIFICATIONS" = "ENABLED" ]; then
        echo "# Notifications enabled"
        echo "# Adding Telegram info to Script..."
        sed -i 's,'"TOKENBOT"','"$TOKEN"',' $BOOKS_SCRIPT
        sed -i 's,'"CHATIDBOT"','"$CHATID"',' $BOOKS_SCRIPT
        echo "# Token = $TOKEN"
        echo "# CHATID = $CHATID"
fi
echo ""
echo "# Adding cronjob and starting..."
# echo '0-59 * * * * /app/Auto_Books_Calibre.sh >> /Books_Calibre_Backup/01-Calibre.log 2>&1' | crontab
echo "0-59 * * * * abc /app/Auto_Books_Calibre.sh >> /tmp/crontab_script_log.txt 2>&1" >> /etc/crontab
# { crontab -l; echo "0-59 * * * * /app/Auto_Books_Calibre.sh 2> /tmp/crontab_script_log2.txt 2>&1"; } | crontab -u abc -
touch /etc/cron.allow
touch /etc/at.allow
chmod u+x /app/Auto_Books_Calibre.sh
chmod 777 /app/Auto_Books_Calibre.sh
echo "abc" > /etc/cron.allow
echo "abc" > /etc/at.allow
service cron start
echo ""
echo "###########################"
echo "# Config completed        #"
echo "###########################"
echo ""
echo "# Starting Calibre-Web... "
if [ ! -f /books/metadata.db ]; then
    cp /app/metadata.db /books/metadata.db
fi
chmod -R 777 /books/
/init