#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'field_defaults_hard2' node's field_fd_over was OVERWRITTEN
# to the default NEW_DEFAULT (agent used Field Defaults with overwrite enabled). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title","field_defaults_hard2")->execute();
  $id = reset($ids);
  $val = ($id && ($n=Node::load($id))) ? $n->get("field_fd_over")->value : NULL;
  $ok = ($val === "NEW_DEFAULT");
  print ($ok?"PASS":"FAIL")." field_fd_over=".var_export($val,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
