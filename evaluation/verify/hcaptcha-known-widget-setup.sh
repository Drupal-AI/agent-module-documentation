#!/usr/bin/env bash
# Introspection SETUP: write known hCaptcha widget settings (theme=dark, max_score=0.3) to the
# live hcaptcha.settings config so an inspecting agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("hcaptcha.settings");
  $c->set("widget.theme", "dark")->set("widget.max_score", 0.3)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: hcaptcha.settings widget.theme=dark widget.max_score=0.3"
