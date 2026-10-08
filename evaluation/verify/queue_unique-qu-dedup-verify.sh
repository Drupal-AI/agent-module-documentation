#!/usr/bin/env bash
# Execution VERIFY: PASS when the qu_dup unique queue holds EXACTLY 1 item — proving the
# same payload inserted (twice) was deduplicated by the unique backend.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $n = 0;
  if (\Drupal::database()->schema()->tableExists("queue_unique")) {
    $n = (int) \Drupal::database()->select("queue_unique","t")->condition("name","qu_dup")->countQuery()->execute()->fetchField();
  }
  $ok = ($n === 1);
  print ($ok ? "PASS" : "FAIL") . " queue_unique_rows(qu_dup)=$n\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
