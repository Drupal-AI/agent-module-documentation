#!/usr/bin/env bash
# Execution VERIFY: PASS when a metatag_defaults entity webform.mtwf_task exists with a
# non-empty description tag containing 'Acme'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\metatag\Entity\MetatagDefaults;
  $md = MetatagDefaults::load("webform.mtwf_task");
  $tags = $md ? ($md->get("tags") ?? []) : [];
  $desc = $tags["description"] ?? "";
  $ok = ($md && stripos($desc, "Acme") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($md ? "1" : "0") . " description=" . var_export($desc, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
