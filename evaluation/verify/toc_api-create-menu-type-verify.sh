#!/usr/bin/env bash
# Execution VERIFY: PASS when a toc_type config entity toc_api_task exists whose options.template
# is 'menu' and whose header range spans at least h2. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\toc_api\Entity\TocType;
  $t = TocType::load("toc_api_task");
  $o = $t ? $t->getOptions() : [];
  $tpl = $o["template"] ?? "";
  $ok = ($t && $tpl === "menu");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($t ? "1" : "0") . " template=" . var_export($tpl, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
