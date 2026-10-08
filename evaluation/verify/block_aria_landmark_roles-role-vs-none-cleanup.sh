#!/usr/bin/env bash
# Introspection CLEANUP: delete both blocks placed by the matching setup. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  foreach (["barl_eval_on", "barl_eval_off"] as $id) {
    if ($b = Block::load($id)) { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: barl_eval_on and barl_eval_off removed"
exit 0
