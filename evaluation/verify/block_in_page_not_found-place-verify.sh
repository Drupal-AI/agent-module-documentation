#!/usr/bin/env bash
# Execution VERIFY: PASS when a block 'bipnf_task' exists whose visibility uses the
# page_not_found_request condition with page_not_found truthy (i.e. shown only on 404s).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("bipnf_task");
  $vis = $b ? $b->get("visibility") : [];
  $cond = $vis["page_not_found_request"] ?? NULL;
  $val = $cond["page_not_found"] ?? NULL;
  $ok = ($cond !== NULL && !empty($val));
  print ($ok ? "PASS" : "FAIL") . " cond=" . ($cond !== NULL ? "set" : "none") . " page_not_found=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
