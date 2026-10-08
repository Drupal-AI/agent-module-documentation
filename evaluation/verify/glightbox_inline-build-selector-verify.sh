#!/usr/bin/env bash
# Execution VERIFY: PASS when an Article titled 'GLB Inline Panel' exists whose body contains a link with
# class glightbox-inline and an href pointing at an on-page selector (starts with #). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ns = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"GLB Inline Panel"]);
  if (!$ns) { print "FAIL node-missing"; return; }
  $n = reset($ns);
  $body = $n->hasField("body") ? (string) $n->get("body")->value : "";
  $hasClass = (strpos($body, "glightbox-inline") !== FALSE);
  $hasAnchor = (bool) preg_match("/href=[\"\x27]#[^\"\x27]+/", $body);
  $ok = $hasClass && $hasAnchor;
  print ($ok ? "PASS" : "FAIL") . " class=" . ($hasClass?"yes":"no") . " selectorHref=" . ($hasAnchor?"yes":"no");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
