#!/usr/bin/env bash
# CLEANUP: remove field_cfsdc + cfsdc_eval (drops the display + its third-party setting).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","cfsdc_eval","field_cfsdc")) { try { $fc->delete(); } catch (\Throwable $e) {} }
  if ($fs = FieldStorageConfig::loadByName("node","field_cfsdc")) { try { $fs->delete(); } catch (\Throwable $e) {} }
  if ($nt = NodeType::load("cfsdc_eval")) { try { $nt->delete(); } catch (\Throwable $e) {} }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cfsdc_eval + field_cfsdc removed"
