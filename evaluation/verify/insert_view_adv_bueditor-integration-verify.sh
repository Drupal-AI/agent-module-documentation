#!/usr/bin/env bash
# Execution VERIFY (insert_view_adv_bueditor): PASS when the agent has written the submodule's real
# BUEditor integration facts to /tmp/iva_bueditor_integration.txt, i.e. the BUEditor plugin id
# 'drupalviews' AND the attached library machine name 'insert_view_adv_bueditor/drupalviews'
# (both taken from the submodule's real DrupalViews plugin / libraries.yml). exit 0 pass / 1 fail.
set -uo pipefail
f=/tmp/iva_bueditor_integration.txt
if [ ! -f "$f" ]; then echo "FAIL: $f missing"; exit 1; fi
if grep -q 'drupalviews' "$f" && grep -q 'insert_view_adv_bueditor/drupalviews' "$f"; then
  echo "PASS: integration facts recorded (drupalviews plugin id + insert_view_adv_bueditor/drupalviews library)"
  exit 0
fi
echo "FAIL: $f does not contain both the 'drupalviews' plugin id and the 'insert_view_adv_bueditor/drupalviews' library"
exit 1
