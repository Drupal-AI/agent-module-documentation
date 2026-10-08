#!/usr/bin/env bash
# Execution VERIFY for "customise the media_directories_file_link template".
# PASS when on filter.format.mfl_tpl_format the media_directories_file_link filter is enabled
# with icon = FALSE and a template that uses the @name and @size tokens, AND processing a real
# <drupal-media-file-link> renders the media label followed by its human-readable file size
# inside the <span class="media-file-link"> wrapper, with no data-file-type attribute.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;

  $format = FilterFormat::load("mfl_tpl_format");
  if (!$format) { print "FAIL format=missing\n"; return; }
  $coll = $format->filters();
  $fl = $coll->has("media_directories_file_link") ? $coll->get("media_directories_file_link") : NULL;
  $on = $fl && $fl->status;

  $template = $on ? (string) ($fl->settings["template"] ?? "") : "";
  $icon = $on ? ($fl->settings["icon"] ?? NULL) : NULL;
  $tokens_ok = str_contains($template, "@name") && str_contains($template, "@size");
  $icon_ok = ($icon === FALSE || $icon === 0);

  $renders = FALSE;
  $processed = "";
  $media = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MFL template media"]);
  if ($on && $media) {
    $item = reset($media);
    $file = $item->get("field_media_document")->entity;
    $size = $file ? (string) \Drupal\Core\StringTranslation\ByteSizeMarkup::create((int) $file->getSize()) : "";
    $html = "<p><drupal-media-file-link data-entity-uuid=\"" . $item->uuid() . "\">Datasheet</drupal-media-file-link></p>";
    $processed = (string) $fl->process($html, "en")->getProcessedText();
    $renders = str_contains($processed, "class=\"media-file-link\"")
      && str_contains($processed, "MFL template media")
      && $size !== "" && str_contains($processed, $size)
      && !str_contains($processed, "data-file-type");
  }

  $ok = $on && $tokens_ok && $icon_ok && $renders;
  print ($ok ? "PASS" : "FAIL")
    . " enabled=" . var_export($on, TRUE)
    . " template=" . json_encode($template)
    . " icon=" . var_export($icon, TRUE)
    . " renders_name_and_size=" . var_export($renders, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
