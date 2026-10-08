#!/usr/bin/env bash
# Execution VERIFY: PASS when /tmp/site_audit_eval_report.html exists and looks like a Site Audit
# HTML report for the Cache checklist. exit 0 pass / 1 fail.
set -uo pipefail
F=/tmp/site_audit_eval_report.html
if [ -s "$F" ] && grep -q 'Site Audit' "$F" && grep -q 'Cache' "$F"; then
  echo "PASS file=$F size=$(wc -c < "$F")"
  exit 0
fi
echo "FAIL file=$F exists=$([ -f "$F" ] && echo yes || echo no)"
exit 1
