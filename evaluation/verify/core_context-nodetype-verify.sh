#!/usr/bin/env bash
# Execution VERIFY: PASS when the core_context 'context' handler for the Article node type returns
# a context keyed 'cc_ntype' whose value is 'typed'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("node_type")->load("article");
  $handler = \Drupal::entityTypeManager()->getHandler("node_type", "context");
  $contexts = $handler->getContexts($t);
  $c = $contexts["cc_ntype"] ?? NULL;
  $v = $c ? $c->getContextValue() : NULL;
  $ok = ($v === "typed");
  print ($ok ? "PASS" : "FAIL") . " handler=" . get_class($handler) . " cc_ntype_value=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
