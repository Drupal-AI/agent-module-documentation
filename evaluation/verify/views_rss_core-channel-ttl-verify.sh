#!/usr/bin/env bash
# Execution VERIFY for "build View vrss_c_ttl with an Advanced RSS feed display (style
# rss_fields) and set the channel <ttl> element to 45". PASS when some display has
# style.type == rss_fields and style.options.channel.core.views_rss_core.ttl == "45".
# Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("vrss_c_ttl");
  $ok = FALSE;
  $style = $ttl = NULL;
  if ($view) {
    $data = $view->toArray();
    foreach ($data["display"] ?? [] as $display) {
      $opts = $display["display_options"] ?? [];
      $style_type = $opts["style"]["type"] ?? NULL;
      if ($style_type === "rss_fields") {
        $style = $style_type;
        $ttl = $opts["style"]["options"]["channel"]["core"]["views_rss_core"]["ttl"] ?? NULL;
        if ((string) $ttl === "45") {
          $ok = TRUE;
        }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " style=" . var_export($style, TRUE) . " ttl=" . var_export($ttl, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
