#!/usr/bin/env bash
# Live-state verification for the "regex rule on Article title" execution task.
# PASS (exit 0) iff a field_validation_rule_set config entity exists for node/article that
# contains a rule with plugin id `regex_constraint_rule` bound to field_name `title` and a
# non-empty regex pattern. Prints PASS/FAIL with detail. No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok = FALSE; $detail = "";
  foreach (\Drupal::entityTypeManager()->getStorage("field_validation_rule_set")->loadMultiple() as $s) {
    if ($s->get("entity_type") !== "node" || $s->get("bundle") !== "article") { continue; }
    foreach (($s->get("field_validation_rules") ?: []) as $r) {
      if (($r["id"] ?? "") === "regex_constraint_rule"
          && ($r["field_name"] ?? "") === "title"
          && !empty($r["data"]["pattern"] ?? "")) {
        $ok = TRUE; $detail = $s->id() . " pattern=" . $r["data"]["pattern"];
      }
    }
  }
  print ($ok ? "PASS " . $detail : "FAIL no regex_constraint_rule on node/article title") . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
