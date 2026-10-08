#!/usr/bin/env bash
# Execution VERIFY: PASS when va_conf autosubmit exposed form has autosubmit_hide===TRUE and
# timeout==2500.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("va_conf");
  $ef = $v ? ($v->getDisplay("default")["display_options"]["exposed_form"] ?? []) : [];
  $type = $ef["type"] ?? "none";
  $hide = $ef["options"]["autosubmit_hide"] ?? NULL;
  $to = $ef["options"]["timeout"] ?? NULL;
  $ok = ($type === "autosubmit" && $hide === TRUE && (int)$to === 2500);
  print ($ok ? "PASS" : "FAIL") . " type=$type hide=" . var_export($hide, TRUE) . " timeout=" . var_export($to, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
