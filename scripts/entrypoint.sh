#!/bin/bash
OPTION="$1"
FILE="$2"
PORT=5000

if [ -z "$OPTION" ]
then
    echo "Empty argument... using default (flask)"
    OPTION='flask'
fi

if [ "$OPTION" = 'streamlit' ]
then
    nginx -g "daemon off;" &
    if [ -z "$FILE" ]
    then
        echo "Empty file... using default (hello)"
        exec streamlit hello --server.enableCORS true --server.port $PORT
    else
        exec streamlit run $FILE --server.enableCORS true --server.port $PORT
    fi
elif [ "$OPTION" = 'flask' ]
then
    nginx -g "daemon off;" &
    exec uwsgi --pp app/ --socket 0.0.0.0:$PORT --protocol=http -w wsgi:app
elif [ "$OPTION" = 'bash' ]
then
    exec bash
else
    echo "Option $OPTION not recognized"
fi
