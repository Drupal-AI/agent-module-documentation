#!/usr/bin/env bash
# Execution RESET: ensure image style cis_hard_a is ABSENT and write the single-config file the agent
# must import with `drush cis`. verify FAILS until it is imported. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("cis_hard_a")) { $s->delete(); }
' >/dev/null 2>&1
cat > /tmp/image.style.cis_hard_a.yml <<'YML'
uuid: 6f1d2c3a-aaaa-4bbb-8ccc-111111111111
langcode: en
status: true
dependencies: {  }
name: cis_hard_a
label: 'CIS Hard Alpha'
effects: {  }
YML
drush cr >/dev/null 2>&1
echo "reset: image style cis_hard_a absent; /tmp/image.style.cis_hard_a.yml written"
