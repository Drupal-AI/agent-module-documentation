#!/usr/bin/env bash
# Execution VERIFY: PASS when the core_context 'context' handler for the node.article.default
# display returns a context keyed 'cc_task' whose value is 'built'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $handler = \Drupal::entityTypeManager()->getHandler("entity_view_display", "context");
  $contexts = $handler->getContexts($d);
  $c = $contexts["cc_task"] ?? NULL;
  $v = $c ? $c->getContextValue() : NULL;
  $ok = ($v === "built");
  print ($ok ? "PASS" : "FAIL") . " cc_task_value=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
