webserver="172.16.213.165"
keyword="Student" # enter the keyword for test content
if curl -s "$webserver" | grep "$keyword"
then
    # if the keyword is in the content
    echo "coucou ça marche"
    exit 0
else
    echo "couocu ça ne marche PAS"
    exit 1
fi
