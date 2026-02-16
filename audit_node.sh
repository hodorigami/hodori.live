#!/bin/bash

DOMAIN="hodori.live"
IDENTITY_RECORD="_identity.$DOMAIN"
LOCAL_PUBKEY="$HOME/.ssh/id_ed25519.pub"

# 1. Extraction: Local Hardware Anchor
LOCAL_FP=$(ssh-keygen -lf "$LOCAL_PUBKEY" | awk '{print $2}')

# 2. Audit: The DNS Pulse (Bypass Host Cache)
REMOTE_TXT=$(dig @1.1.1.1 +short TXT "$IDENTITY_RECORD" | tr -d '"')
REMOTE_FP=$(echo "$REMOTE_TXT" | sed -n 's/.*fp=\([^;]*\).*/\1/p')

# 3. Handshake Logic
echo "--- Handshake Audit: NODE_02 ---"
echo "LOCAL:  $LOCAL_FP"
echo "REMOTE: SHA256:$REMOTE_FP"

if [[ "$LOCAL_FP" == "SHA256:$REMOTE_FP" ]]; then
    echo "STATUS: HANDSHAKE VALID"
    echo "RESULT: NODE ACTIVE"
else
    echo "STATUS: HANDSHAKE FAILURE"
    echo "RESULT: LOGICAL MISMATCH"
    exit 1
fi
