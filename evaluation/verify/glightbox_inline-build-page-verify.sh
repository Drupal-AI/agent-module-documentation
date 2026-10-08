#!/usr/bin/env bash
# Execution VERIFY: PASS when an Article titled 'GLB Inline Page' exists whose body contains a link with
# class glightbox-inline whose href is a path/URL (starts with / or http). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ns = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"GLB Inline Page"]);
  if (!$ns) { print "FAIL node-missing"; return; }
  $n = reset($ns);
  $body = $n->hasField("body") ? (string) $n->get("body")->value : "";
  $hasClass = (strpos($body, "glightbox-inline") !== FALSE);
  $hasUrl = (bool) preg_match("/href=[\"\x27](\/|https?:)[^\"\x27]+/", $body);
  $ok = $hasClass && $hasUrl;
  print ($ok ? "PASS" : "FAIL") . " class=" . ($hasClass?"yes":"no") . " urlHref=" . ($hasUrl?"yes":"no");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
