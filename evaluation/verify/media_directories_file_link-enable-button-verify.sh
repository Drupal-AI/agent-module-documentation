#!/usr/bin/env bash
# Execution VERIFY for "add the Insert file link button to mfl_task_format".
# PASS when on the live site:
#   * filter media_directories_file_link is enabled on filter.format.mfl_task_format,
#   * the editor's toolbar contains the mediaFileLinkButton item,
#   * and the filter really renders: processing a <drupal-media-file-link> for the
#     "MFL task media" item yields a <span class="media-file-link"> wrapper containing an
#     <a href> to the media's file.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  use Drupal\filter\Entity\FilterFormat;

  $format = FilterFormat::load("mfl_task_format");
  $editor = Editor::load("mfl_task_format");
  if (!$format || !$editor) { print "FAIL format_or_editor=missing\n"; return; }

  $coll = $format->filters();
  $fl = $coll->has("media_directories_file_link") ? $coll->get("media_directories_file_link") : NULL;
  $on = $fl && $fl->status;

  $items = $editor->getSettings()["toolbar"]["items"] ?? [];
  $toolbar_ok = in_array("mediaFileLinkButton", $items, TRUE);

  $renders = FALSE;
  $media = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MFL task media"]);
  if ($on && $media) {
    $uuid = reset($media)->uuid();
    $html = "<p><drupal-media-file-link data-entity-uuid=\"" . $uuid . "\">Handbook</drupal-media-file-link></p>";
    $processed = (string) $fl->process($html, "en")->getProcessedText();
    $renders = str_contains($processed, "class=\"media-file-link\"")
      && str_contains($processed, "<a ")
      && str_contains($processed, "handbook.txt")
      && !str_contains($processed, "<drupal-media-file-link");
  }

  $ok = $on && $toolbar_ok && $renders;
  print ($ok ? "PASS" : "FAIL")
    . " filter_enabled=" . var_export($on, TRUE)
    . " toolbar=" . json_encode(array_values($items))
    . " renders_link=" . var_export($renders, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
