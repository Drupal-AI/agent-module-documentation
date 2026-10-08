#!/usr/bin/env bash
# Shared CLEANUP: delete index cfsapi_index, field field_cfsapi_desc, content type cfsapi_eval.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\search_api\Entity\Index;
  if ($i = Index::load("cfsapi_index")) { try { $i->delete(); } catch (\Throwable $e) {} }
  if ($fc = FieldConfig::loadByName("node","cfsapi_eval","field_cfsapi_desc")) { try { $fc->delete(); } catch (\Throwable $e) {} }
  if ($fs = FieldStorageConfig::loadByName("node","field_cfsapi_desc")) { try { $fs->delete(); } catch (\Throwable $e) {} }
  if ($nt = NodeType::load("cfsapi_eval")) { try { $nt->delete(); } catch (\Throwable $e) {} }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cfsapi_index, field_cfsapi_desc, cfsapi_eval removed"
