#!/usr/bin/env bash
# Execution CLEANUP: delete any remaining tmt_del terms and the vocabulary itself. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $existing = $storage->loadByProperties(["vid" => "tmt_del"]);
  if ($existing) { $storage->delete($existing); }
  if ($v = Vocabulary::load("tmt_del")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vocabulary tmt_del removed"
