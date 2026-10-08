#!/usr/bin/env bash
# Execution VERIFY: PASS when block bipnf_hide exists with the page_not_found_request condition
# where page_not_found is truthy AND negate is truthy (shown everywhere EXCEPT 404).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("bipnf_hide");
  $c = $b ? ($b->get("visibility")["page_not_found_request"] ?? NULL) : NULL;
  $pnf = $c["page_not_found"] ?? NULL;
  $neg = $c["negate"] ?? NULL;
  $ok = ($c !== NULL && !empty($pnf) && !empty($neg));
  print ($ok ? "PASS" : "FAIL") . " page_not_found=" . var_export($pnf, TRUE) . " negate=" . var_export($neg, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
