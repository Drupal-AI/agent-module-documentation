#!/usr/bin/env bash
# Live-state verification for "make the Layout operation link appear for Basic page nodes".
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments. Three checks:
#   cfg  — node.page.default view display has Layout Builder enabled AND overrides on.
#   fn   — the module's hook returns a `layout` link (title "Layout", url .../layout)
#          for a fresh Basic page node, evaluated as an admin who can configure layouts.
#   neg  — a fresh Article node (whose bundle has NO overrides after reset) gets NO
#          `layout` link, proving the link is scoped to the configured bundle.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $repo = \Drupal::service("entity_display.repository");
  $d = $repo->getViewDisplay("node", "page", "default");
  $tp = $d ? $d->getThirdPartySettings("layout_builder") : [];
  $cfg = (!empty($tp["enabled"]) && !empty($tp["allow_custom"]));

  \Drupal::currentUser()->setAccount(\Drupal\user\Entity\User::load(1));
  $p = \Drupal\node\Entity\Node::create(["type" => "page", "title" => "LBOL page probe"]);
  $p->save();
  $ops = layout_builder_operation_link_entity_operation($p);
  $fn = isset($ops["layout"])
    && (string) $ops["layout"]["title"] === "Layout"
    && str_contains($ops["layout"]["url"]->toString(), "/layout");
  $p->delete();

  $a = \Drupal\node\Entity\Node::create(["type" => "article", "title" => "LBOL neg probe"]);
  $a->save();
  $neg = !isset(layout_builder_operation_link_entity_operation($a)["layout"]);
  $a->delete();

  print ($cfg && $fn && $neg ? "PASS" : "FAIL") . " cfg=" . ($cfg?1:0) . " fn=" . ($fn?1:0) . " neg=" . ($neg?1:0) . "\n";
' 2>/dev/null | grep -E "^(PASS|FAIL) ")

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
