#!/usr/bin/env bash
# Clear state: strip any UI Patterns formatter from the Article default view display.
# body -> text_default; any other field on a ui_patterns_* formatter is hidden.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  foreach ($d->getComponents() as $name => $c) {
    if (isset($c["type"]) && strpos((string) $c["type"], "ui_patterns_") === 0) {
      if ($name === "body") {
        $d->setComponent("body", ["type" => "text_default", "label" => "hidden", "weight" => $c["weight"] ?? 1, "region" => "content", "settings" => []]);
      } else { $d->removeComponent($name); }
    }
  }
  $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article default display cleared of ui_patterns formatters"
