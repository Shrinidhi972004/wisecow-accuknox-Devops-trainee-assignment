#!/usr/bin/env bash

SRVPORT=4499
RSPFILE=response

# Clean up any old pipe
rm -f "$RSPFILE"
mkfifo "$RSPFILE"

# Ignore SIGPIPE so the script doesn't crash when clients disconnect
trap '' SIGPIPE

get_api() {
    # Read one HTTP request line
    read -r line
    echo "$line"
}

handleRequest() {
    get_api
    mod=$(fortune)

    cat <<EOF > "$RSPFILE"
HTTP/1.1 200 OK
Content-Type: text/html

<pre>$(cowsay "$mod")</pre>
EOF
}

prerequisites() {
    command -v cowsay >/dev/null 2>&1 || { echo "cowsay missing"; exit 1; }
    command -v fortune >/dev/null 2>&1 || { echo "fortune missing"; exit 1; }
}

main() {
    set -e
    prerequisites
    echo "Wisdom served on port=$SRVPORT..."

    # Infinite loop to serve requests forever
    while true; do
        cat "$RSPFILE" | nc -lN "$SRVPORT" | handleRequest || true
        sleep 0.01
    done
}

main
