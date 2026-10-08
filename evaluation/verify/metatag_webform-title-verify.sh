#!/usr/bin/env bash
# Execution VERIFY: PASS when metatag_defaults webform.mtwf_title exists, is enabled, and its
# title tag is non-empty. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\metatag\Entity\MetatagDefaults;
  $md = MetatagDefaults::load("webform.mtwf_title");
  $tags = $md ? ($md->get("tags") ?? []) : [];
  $title = $tags["title"] ?? "";
  $ok = ($md && $md->status() && trim($title) !== "");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($md ? "1" : "0") . " status=" . ($md ? var_export($md->status(), TRUE) : "n/a") . " title=" . var_export($title, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
