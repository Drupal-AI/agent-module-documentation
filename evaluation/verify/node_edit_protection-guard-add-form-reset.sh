#!/usr/bin/env bash
# Execution RESET: ensure node_edit_protection is enabled but content type nep_neta is ABSENT
# so verify FAILS (no form to protect) until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install node_edit_protection -y >/dev/null 2>&1 || true
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($nt = NodeType::load("nep_neta")) { $nt->delete(); }
' >/dev/null 2>&1
echo "reset: nep_neta absent, node_edit_protection enabled"
