#!/usr/bin/env bash
# Execution CLEANUP: remove the generated HTML report file. Exit 0.
set -uo pipefail
rm -f /tmp/site_audit_eval_report.html
echo "cleanup: /tmp/site_audit_eval_report.html removed"
