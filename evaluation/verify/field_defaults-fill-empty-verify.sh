#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'field_defaults_hard1' Article node's field_fd_task now
# equals its configured default TASK_DEFAULT (agent applied Field Defaults). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title","field_defaults_hard1")->execute();
  $id = reset($ids);
  $val = ($id && ($n=Node::load($id))) ? $n->get("field_fd_task")->value : NULL;
  $ok = ($val === "TASK_DEFAULT");
  print ($ok?"PASS":"FAIL")." field_fd_task=".var_export($val,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
