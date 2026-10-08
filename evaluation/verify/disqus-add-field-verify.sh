#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has a field field_disqus_task of type disqus_comment.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_disqus_task");
  $type = $fc ? $fc->getType() : "none";
  print (($type === "disqus_comment") ? "PASS" : "FAIL") . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
