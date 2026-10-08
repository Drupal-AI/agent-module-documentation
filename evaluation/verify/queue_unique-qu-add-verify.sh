#!/usr/bin/env bash
# Execution VERIFY: PASS when the qu_task unique queue (queue_unique table) holds >=1 item,
# i.e. the agent used the queue_unique backend (not the core 'queue' table).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $schema = \Drupal::database()->schema();
  $n = 0;
  if ($schema->tableExists("queue_unique")) {
    $n = (int) \Drupal::database()->select("queue_unique","t")->condition("name","qu_task")->countQuery()->execute()->fetchField();
  }
  $ok = $n >= 1;
  print ($ok ? "PASS" : "FAIL") . " queue_unique_rows(qu_task)=$n\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
