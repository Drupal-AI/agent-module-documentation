#!/usr/bin/env bash
# Introspection SETUP: HTMX Block htmx_med2 wrapping the Site branding block, so an agent can
# read back its plugin id / label.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\htmx\Entity\HtmxBlock;
  if (!HtmxBlock::load("htmx_med2")) {
    HtmxBlock::create([
      "id" => "htmx_med2", "label" => "HTMX Site Branding",
      "plugin" => "system_branding_block",
      "settings" => ["id" => "system_branding_block", "label" => "Site branding", "provider" => "system", "label_display" => "0", "use_site_logo" => TRUE, "use_site_name" => TRUE, "use_site_slogan" => TRUE],
      "visibility" => [],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: htmx.htmx_block.htmx_med2 plugin=system_branding_block"
