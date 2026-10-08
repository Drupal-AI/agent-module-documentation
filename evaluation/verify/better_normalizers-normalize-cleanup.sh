#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
rm -f /tmp/bnrm-eval/file-out.json
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["filename" => "bnrm-eval-spec.txt"]) as $f) { $f->delete(); }
' >/dev/null 2>&1
echo "cleanup: bnrm-eval-spec.txt + output removed"
