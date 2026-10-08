#!/usr/bin/env bash
# Execution VERIFY: PASS when va_task default display exposed_form.type === autosubmit.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("va_task");
  $t = $v ? ($v->getDisplay("default")["display_options"]["exposed_form"]["type"] ?? "none") : "missing";
  $ok = ($t === "autosubmit");
  print ($ok ? "PASS" : "FAIL") . " exposed_form.type=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
