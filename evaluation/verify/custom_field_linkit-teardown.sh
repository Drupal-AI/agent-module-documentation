#!/usr/bin/env bash
# Shared CLEANUP (custom_field_linkit): remove field_cf_lk + cf_lk_eval. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType; use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","cf_lk_eval","field_cf_lk")) { try { $fc->delete(); } catch (\Throwable $e) {} }
  if ($fs = FieldStorageConfig::loadByName("node","field_cf_lk")) { try { $fs->delete(); } catch (\Throwable $e) {} }
  if ($nt = NodeType::load("cf_lk_eval")) { try { $nt->delete(); } catch (\Throwable $e) {} }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_cf_lk + cf_lk_eval removed"
