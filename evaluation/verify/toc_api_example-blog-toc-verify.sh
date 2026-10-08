#!/usr/bin/env bash
# Execution VERIFY: PASS when an Article titled 'TOC Api Example Blog' exists whose stored body
# has enough headers that toc_api_example would render a TOC. Applies the module's own decision:
# parse the body with the 'default' toc_type and check TocInterface::isVisible().
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\toc_api\Entity\TocType;
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "TOC Api Example Blog"]);
  $node = $nodes ? reset($nodes) : NULL;
  if (!$node) { print "FAIL no-node\n"; return; }
  if (!in_array($node->getType(), ["article", "page"], TRUE)) { print "FAIL wrong-type=" . $node->getType() . "\n"; return; }
  $body = $node->get("body");
  if ($body->isEmpty()) { print "FAIL empty-body\n"; return; }
  $html = (string) $body->value;
  $options = ($t = TocType::load("default")) ? $t->getOptions() : [];
  $toc = \Drupal::service("toc_api.manager")->create("verify_blog", $html, $options);
  $ok = $toc->isVisible();
  print ($ok ? "PASS" : "FAIL") . " node=" . $node->id() . " headers=" . $toc->getHeaderCount() . " visible=" . ($ok ? "1" : "0") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
