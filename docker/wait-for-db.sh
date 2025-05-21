#!/bin/sh
# Script original: https://github.com/eficode/wait-for

TIMEOUT=15
QUIET=0

while getopts "t:q" option; do
    case "$option" in
        t) TIMEOUT=$OPTARG ;;
        q) QUIET=1 ;;
    esac
done

shift $((OPTIND-1))

host=$1
port=$2
shift 2

if ! command -v nc >/dev/null; then
    echo "→ Installation de netcat..."
    apk add --no-cache netcat-openbsd >/dev/null 2>&1 || apt-get update && apt-get install -y netcat >/dev/null 2>&1
fi

until nc -z "$host" "$port"; do
    if [ $QUIET -eq 0 ]; then
        echo "→ En attente de $host:$port..."
    fi
    sleep 1
    TIMEOUT=$((TIMEOUT-1))
    if [ $TIMEOUT -le 0 ]; then
        echo "Timeout ! La base de données n'est pas accessible." >&2
        exit 1
    fi
done

exec "$@"