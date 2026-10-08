#!/usr/bin/env bash
# MEDIUM (introspection) setup: point the amazee.ai provider at a KNOWN custom LLM gateway
# endpoint (host) and turn moderation on, so an agent can read these back off the live site.
# Restored by the matching -cleanup script. No amazee.ai API call is made.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ai_provider_amazeeio.settings")
    ->set("host", "https://eval-gateway.amazee.test/v1")
    ->set("moderation", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ai_provider_amazeeio host + moderation set to known values"
