#!/usr/bin/env bash
# Execution VERIFY for "enable CKEditor5 Media Resize on the ckeditor_media_resize_task
# text format". PASS when, on the live site:
#   * filter_resize_media is enabled on filter.format.ckeditor_media_resize_task,
#   * its weight is LOWER than media_embed's (so it runs first),
#   * filter_html is still enabled (required by the module),
#   * the editor's toolbar contains drupalMedia,
#   * settings.plugins.ckeditor_media_resize_mediaResize.apply_image_styles === TRUE.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  use Drupal\filter\Entity\FilterFormat;

  $id = "ckeditor_media_resize_task";
  $format = FilterFormat::load($id);
  $editor = Editor::load($id);

  $resize = $embed = $html = NULL;
  if ($format) {
    $coll = $format->filters();
    $resize = $coll->has("filter_resize_media") ? $coll->get("filter_resize_media") : NULL;
    $embed = $coll->has("media_embed") ? $coll->get("media_embed") : NULL;
    $html = $coll->has("filter_html") ? $coll->get("filter_html") : NULL;
  }

  $resize_on = $resize && $resize->status;
  $embed_on = $embed && $embed->status;
  $html_on = $html && $html->status;
  $order_ok = $resize_on && $embed_on && ((int) $resize->weight < (int) $embed->weight);

  $settings = $editor ? $editor->getSettings() : [];
  $toolbar_ok = in_array("drupalMedia", $settings["toolbar"]["items"] ?? [], TRUE);
  $plugin = $settings["plugins"]["ckeditor_media_resize_mediaResize"] ?? NULL;
  $plugin_ok = is_array($plugin) && ($plugin["apply_image_styles"] ?? NULL) === TRUE;

  $ok = $resize_on && $html_on && $order_ok && $toolbar_ok && $plugin_ok;
  print ($ok ? "PASS" : "FAIL")
    . " resize=" . var_export($resize_on, TRUE)
    . " filter_html=" . var_export($html_on, TRUE)
    . " order(resize<embed)=" . var_export($order_ok, TRUE)
    . " weights=" . ($resize ? (int) $resize->weight : "-") . "/" . ($embed ? (int) $embed->weight : "-")
    . " drupalMedia=" . var_export($toolbar_ok, TRUE)
    . " apply_image_styles=" . var_export($plugin["apply_image_styles"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
