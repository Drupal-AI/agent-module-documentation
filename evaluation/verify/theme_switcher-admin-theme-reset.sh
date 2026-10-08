#!/usr/bin/env bash
# Execution RESET: create the rule with only a front-end theme and NO admin theme, so verify
# fails until the agent sets the admin theme. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\theme_switcher\Entity\ThemeSwitcherRule;
  $r = ThemeSwitcherRule::load("ts_admin_rule") ?: ThemeSwitcherRule::create(["id" => "ts_admin_rule"]);
  $r->set("label", "TS admin rule")
    ->set("status", TRUE)
    ->set("weight", 0)
    ->set("theme", "claro")
    ->set("admin_theme", "")
    ->set("conjunction", "and")
    ->set("visibility", [
      "request_path" => [
        "id" => "request_path", "negate" => FALSE, "context_mapping" => [],
        "pages" => "/ts-admin\n/ts-admin/*",
      ],
    ])
    ->save();
' >/dev/null 2>&1
echo "reset: ts_admin_rule present with admin_theme empty"
