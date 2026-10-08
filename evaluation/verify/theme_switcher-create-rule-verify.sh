#!/usr/bin/env bash
# Execution VERIFY: PASS when theme_switcher.rule.ts_task_rule exists, is enabled, uses the
# claro theme and carries a request_path visibility condition covering /ts-task.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\theme_switcher\Entity\ThemeSwitcherRule::load("ts_task_rule");
  if (!$r) { print "FAIL rule-missing\n"; return; }
  $vis = $r->get("visibility");
  $pages = $vis["request_path"]["pages"] ?? "";
  $ok = ($r->status() === TRUE)
    && ($r->getTheme() === "claro")
    && isset($vis["request_path"])
    && (strpos($pages, "/ts-task") !== FALSE);
  print ($ok ? "PASS" : "FAIL")
    . " status=" . var_export($r->status(), TRUE)
    . " theme=" . var_export($r->getTheme(), TRUE)
    . " conditions=" . implode(",", array_keys($vis))
    . " pages=" . str_replace("\n", "|", $pages) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
