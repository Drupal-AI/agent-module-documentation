#!/usr/bin/env bash
# Execution VERIFY: PASS when a bibcite_contributor_role 'bibcite_reviewer' labelled 'Reviewer'
# exists. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\bibcite_entity\Entity\ContributorRole;
  $r = ContributorRole::load("bibcite_reviewer");
  $ok = $r && ($r->label() === "Reviewer");
  print ($ok ? "PASS" : "FAIL") . " label=" . var_export($r ? $r->label() : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
