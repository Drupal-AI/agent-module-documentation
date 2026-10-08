#!/usr/bin/env bash
# Execution VERIFY: PASS when the ts_admin_rule rule has admin_theme olivero while keeping its
# claro front-end theme and its /ts-admin request_path condition. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\theme_switcher\Entity\ThemeSwitcherRule::load("ts_admin_rule");
  if (!$r) { print "FAIL rule-missing\n"; return; }
  $vis = $r->get("visibility");
  $pages = $vis["request_path"]["pages"] ?? "";
  $ok = ($r->getAdminTheme() === "olivero")
    && ($r->getTheme() === "claro")
    && ($r->status() === TRUE)
    && (strpos($pages, "/ts-admin") !== FALSE);
  print ($ok ? "PASS" : "FAIL")
    . " theme=" . var_export($r->getTheme(), TRUE)
    . " admin_theme=" . var_export($r->getAdminTheme(), TRUE)
    . " status=" . var_export($r->status(), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
