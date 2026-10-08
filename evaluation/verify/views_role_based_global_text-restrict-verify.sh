#!/usr/bin/env bash
# HARD VERIFY: PASS when the vrbgt_task_view header text area's roles_fieldset.roles selects the
# 'authenticated' role (truthy value). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vrbgt_task_view");
  $roles = NULL;
  if ($v) {
    $d = $v->get("display");
    $roles = $d["default"]["display_options"]["header"]["area_text"]["roles_fieldset"]["roles"] ?? NULL;
  }
  $ok = is_array($roles) && !empty($roles["authenticated"]);
  print ($ok ? "PASS" : "FAIL") . " roles=" . json_encode($roles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
