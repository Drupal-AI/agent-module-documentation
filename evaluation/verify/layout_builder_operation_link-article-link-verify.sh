#!/usr/bin/env bash
# Live-state verification for "make the Layout operation link appear for Article nodes".
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments. Two checks:
#   cfg — node.article.default view display has Layout Builder enabled AND overrides
#         (allow_custom) turned on.
#   fn  — layout_builder_operation_link_entity_operation() actually returns a `layout`
#         link (title "Layout", url .../layout) for a freshly-created Article node,
#         evaluated as an admin who can configure layouts. This exercises the module's
#         real hook, not just the config flags.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $repo = \Drupal::service("entity_display.repository");
  $d = $repo->getViewDisplay("node", "article", "default");
  $tp = $d ? $d->getThirdPartySettings("layout_builder") : [];
  $cfg = (!empty($tp["enabled"]) && !empty($tp["allow_custom"]));

  \Drupal::currentUser()->setAccount(\Drupal\user\Entity\User::load(1));
  $n = \Drupal\node\Entity\Node::create(["type" => "article", "title" => "LBOL verify probe"]);
  $n->save();
  $ops = layout_builder_operation_link_entity_operation($n);
  $fn = isset($ops["layout"])
    && (string) $ops["layout"]["title"] === "Layout"
    && str_contains($ops["layout"]["url"]->toString(), "/layout");
  $n->delete();

  print ($cfg && $fn ? "PASS" : "FAIL") . " cfg=" . ($cfg?1:0) . " fn=" . ($fn?1:0) . "\n";
' 2>/dev/null | grep -E "^(PASS|FAIL) ")

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
