#!/usr/bin/env bash
# Introspection SETUP: save a known theme_switcher_rule config entity so the agent must read
# the live site to discover which theme it applies and on which paths. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\theme_switcher\Entity\ThemeSwitcherRule;
  $r = ThemeSwitcherRule::load("ts_known_rule") ?: ThemeSwitcherRule::create(["id" => "ts_known_rule"]);
  $r->set("label", "TS known rule")
    ->set("status", TRUE)
    ->set("weight", 0)
    ->set("theme", "claro")
    ->set("admin_theme", "")
    ->set("conjunction", "and")
    ->set("visibility", [
      "request_path" => [
        "id" => "request_path", "negate" => FALSE, "context_mapping" => [],
        "pages" => "/ts-known\n/ts-known/*",
      ],
    ])
    ->save();
' >/dev/null 2>&1
echo "setup: theme_switcher.rule.ts_known_rule -> theme claro on /ts-known*"
