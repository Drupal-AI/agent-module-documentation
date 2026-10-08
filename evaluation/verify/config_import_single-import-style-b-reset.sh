#!/usr/bin/env bash
# Execution RESET: ensure image style cis_hard_b is ABSENT and write its single-config file. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("cis_hard_b")) { $s->delete(); }
' >/dev/null 2>&1
cat > /tmp/image.style.cis_hard_b.yml <<'YML'
uuid: 7a2e3d4b-bbbb-4ccc-8ddd-222222222222
langcode: en
status: true
dependencies: {  }
name: cis_hard_b
label: 'CIS Hard Bravo'
effects: {  }
YML
drush cr >/dev/null 2>&1
echo "reset: image style cis_hard_b absent; /tmp/image.style.cis_hard_b.yml written"
