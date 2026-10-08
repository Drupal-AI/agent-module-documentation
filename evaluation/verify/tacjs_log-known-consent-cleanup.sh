#!/usr/bin/env bash
# Introspection CLEANUP: remove the probe consent row(s). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("tacjslog")->condition("services_allowed","tacjs_probe_consent")->execute();' >/dev/null 2>&1
echo "cleanup: tacjslog probe rows removed"
