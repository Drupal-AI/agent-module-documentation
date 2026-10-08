#!/usr/bin/env bash
# Execution CLEANUP: restore Better Messages shipped defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c = \Drupal::configFactory()->getEditable("better_messages.settings");
  $c->set("position", "center")
    ->set("vertical", 0)->set("horizontal", 10)->set("fixed", 1)
    ->set("width", "400px")->set("autoclose", 0)->set("opendelay", 0.3)
    ->set("disable_autoclose", 0)->set("show_countdown", 1)->set("hover_autoclose", 1)
    ->set("popin", ["effect" => "fadeIn", "duration" => "slow"])
    ->set("popout", ["effect" => "fadeOut", "duration" => "slow"])
    ->set("jquery_ui", ["draggable" => 1, "resizable" => 0])
    ->set("visibility", [])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: better_messages.settings restored to shipped defaults"
