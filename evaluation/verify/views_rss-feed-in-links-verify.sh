#!/usr/bin/env bash
# Execution VERIFY for "build View vrss_p_links with the Advanced RSS feed style plugin
# (rss_fields) and enable 'Display feed icon in the links attached to the view'
# (feed_settings.feed_in_links)". PASS when some display has style.type == rss_fields
# and style.options.feed_settings.feed_in_links is truthy. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("vrss_p_links");
  $ok = FALSE;
  $style = $feed_in_links = NULL;
  if ($view) {
    $data = $view->toArray();
    foreach ($data["display"] ?? [] as $display) {
      $opts = $display["display_options"] ?? [];
      $style_type = $opts["style"]["type"] ?? NULL;
      if ($style_type === "rss_fields") {
        $style = $style_type;
        $feed_in_links = $opts["style"]["options"]["feed_settings"]["feed_in_links"] ?? NULL;
        if (!empty($feed_in_links)) {
          $ok = TRUE;
        }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " style=" . var_export($style, TRUE) . " feed_in_links=" . var_export($feed_in_links, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
