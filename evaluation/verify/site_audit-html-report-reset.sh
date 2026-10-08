#!/usr/bin/env bash
# Execution RESET: remove the target HTML report file so verify FAILS until the agent generates
# it. Exit 0.
set -uo pipefail
rm -f /tmp/site_audit_eval_report.html
echo "reset: /tmp/site_audit_eval_report.html removed"
