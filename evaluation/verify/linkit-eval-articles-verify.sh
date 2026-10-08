#!/usr/bin/env bash
# Live-state verification for the "Linkit profile matcher restricted to the Article bundle" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if the linkit_profile config entity `eval_articles` exists AND at least one of its
# matchers has a bundle restriction (settings.bundles) that includes "article". Linkit stores
# the restriction at matchers.<uuid>.settings.bundles as an array of bundle machine names.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $p = \Drupal::entityTypeManager()->getStorage("linkit_profile")->load("eval_articles");
  $exists = (bool) $p;
  $restricted = FALSE;
  if ($exists) {
    foreach (($p->get("matchers") ?: []) as $m) {
      $bundles = $m["settings"]["bundles"] ?? [];
      if (is_array($bundles) && in_array("article", array_values($bundles), TRUE)) { $restricted = TRUE; }
    }
  }
  print (($exists && $restricted) ? "PASS" : "FAIL")
    . " exists=" . ($exists?1:0) . " article_restricted=" . ($restricted?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
