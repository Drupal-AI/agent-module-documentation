#!/usr/bin/env bash
# Live-state verification for the "length rule on Article body" execution task.
# PASS (exit 0) iff a field_validation_rule_set config entity exists for node/article that
# contains a rule with plugin id `length_constraint_rule` bound to field_name `body` with a
# min and/or max set. Prints PASS/FAIL with detail. No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok = FALSE; $detail = "";
  foreach (\Drupal::entityTypeManager()->getStorage("field_validation_rule_set")->loadMultiple() as $s) {
    if ($s->get("entity_type") !== "node" || $s->get("bundle") !== "article") { continue; }
    foreach (($s->get("field_validation_rules") ?: []) as $r) {
      if (($r["id"] ?? "") === "length_constraint_rule"
          && ($r["field_name"] ?? "") === "body"
          && (($r["data"]["min"] ?? "") !== "" || ($r["data"]["max"] ?? "") !== "")) {
        $ok = TRUE; $detail = $s->id() . " min=" . ($r["data"]["min"] ?? "") . " max=" . ($r["data"]["max"] ?? "");
      }
    }
  }
  print ($ok ? "PASS " . $detail : "FAIL no length_constraint_rule on node/article body") . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
