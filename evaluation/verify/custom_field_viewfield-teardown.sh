#!/usr/bin/env bash
# Shared CLEANUP (custom_field_viewfield): delete field_cf_vf and the cf_vf_eval content type.
# Only touches this submodule's own namespaced artifacts. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","cf_vf_eval","field_cf_vf")) { try { $fc->delete(); } catch (\Throwable $e) {} }
  if ($fs = FieldStorageConfig::loadByName("node","field_cf_vf")) { try { $fs->delete(); } catch (\Throwable $e) {} }
  if ($nt = NodeType::load("cf_vf_eval")) { try { $nt->delete(); } catch (\Throwable $e) {} }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_cf_vf + cf_vf_eval removed"
