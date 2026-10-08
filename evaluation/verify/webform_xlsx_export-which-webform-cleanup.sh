#!/usr/bin/env bash
# Introspection CLEANUP: delete both webforms created by the setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  foreach (["wfx_pair_a", "wfx_pair_b"] as $id) {
    if ($w = Webform::load($id)) { $w->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: wfx_pair_a and wfx_pair_b deleted"
