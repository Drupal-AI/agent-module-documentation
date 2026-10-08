#!/usr/bin/env bash
# Introspection CLEANUP: delete the eca_cm_mod model. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$e=\Drupal::entityTypeManager()->getStorage("eca")->load("eca_cm_mod"); if($e){$e->delete();}' >/dev/null 2>&1
echo "cleanup: eca_cm_mod deleted"
