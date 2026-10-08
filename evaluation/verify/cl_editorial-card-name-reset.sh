#!/usr/bin/env bash
# Execution RESET: remove the output file so verify FAILS until the agent looks the component up
# through cl_editorial's component manager. Idempotent. Exit 0.
set -uo pipefail
rm -f /tmp/cl_editorial_card_name.txt
echo "reset: /tmp/cl_editorial_card_name.txt removed"
