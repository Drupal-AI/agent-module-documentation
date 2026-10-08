#!/usr/bin/env bash
# HARD (execution) live-state verification for unlimited_number.
# Contract: the agent configures the Article integer field `field_un_cardinality` so its
# edit-form widget is the module's "Unlimited or Number" widget (type `unlimited_number`)
# and "unlimited" is stored as the integer -1 (widget setting value_unlimited = -1).
# Three independent checks:
#   type  — the entity_form_display component for the field uses type `unlimited_number`
#   val   — that component's value_unlimited setting is exactly -1
#   fn    — a freshly built Article node edit form actually renders the widget's radios
#           (proving the widget is live, not just stored config)
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $c = $fd->getComponent("field_un_cardinality");
  $type = is_array($c) && ($c["type"] ?? "") === "unlimited_number";
  $val = is_array($c) && (int) ($c["settings"]["value_unlimited"] ?? 999) === -1;
  $node = \Drupal\node\Entity\Node::create(["type" => "article"]);
  $form = \Drupal::service("entity.form_builder")->getForm($node);
  $html = (string) \Drupal::service("renderer")->renderInIsolation($form);
  // The widget renders <input type="radio"> controls that belong to THIS field
  // (their data-drupal-selector references field_un_cardinality); a plain number widget
  // would not. Match a radio input tied to the field specifically, not any radio on the form.
  $fn = (bool) preg_match("#<input[^>]*field-un-cardinality[^>]*type=.radio.#i", $html)
      || (bool) preg_match("#<input[^>]*type=.radio.[^>]*field-un-cardinality#i", $html);
  $ok = $type && $val && $fn;
  print ($ok ? "PASS" : "FAIL") . " type=" . ($type?1:0) . " val=" . ($val?1:0) . " fn=" . ($fn?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
