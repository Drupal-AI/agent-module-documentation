#!/usr/bin/env bash
# Execution VERIFY for "enable AI translation for image media".
# PASS when on the live site:
#   * media_directories_ai.settings:ai_translation_types contains 'image',
#   * translation_prompt is a non-empty custom prompt (not the service DEFAULT_PROMPT),
#   * ai_translatable_fields['image'] includes 'name',
#   * and the flag actually reaches the front end: after the browser module publishes
#     drupalSettings and media_directories_ai alters it, mediaTypeTranslationSettings.image
#     .enableAiTranslations is TRUE.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $config = \Drupal::config("media_directories_ai.settings");
  $types = array_values((array) ($config->get("ai_translation_types") ?: []));
  $types_ok = in_array("image", $types, TRUE);

  $prompt = (string) ($config->get("translation_prompt") ?? "");
  $default = \Drupal\media_directories_ai\Service\AiTranslationService::DEFAULT_PROMPT;
  $prompt_ok = $prompt !== "" && $prompt !== $default;

  $fields = (array) ($config->get("ai_translatable_fields") ?: []);
  $image_fields = array_values((array) ($fields["image"] ?? []));
  $fields_ok = in_array("name", $image_fields, TRUE);

  $attachments = [];
  \Drupal::service("Drupal\media_directories_browser\Hook\MediaDirectoriesBrowserHooks")->pageAttachments($attachments);
  \Drupal\media_directories_ai\Hook\MediaDirectoriesAiHooks::pageAttachmentsAlter($attachments);
  $settings = $attachments["#attached"]["drupalSettings"]["mediaDirectoriesBrowser"] ?? [];
  $flag = $settings["mediaTypeTranslationSettings"]["image"]["enableAiTranslations"] ?? NULL;
  $flag_ok = ($flag === TRUE);

  $ok = $types_ok && $prompt_ok && $fields_ok && $flag_ok;
  print ($ok ? "PASS" : "FAIL")
    . " ai_translation_types=" . json_encode($types)
    . " custom_prompt=" . var_export($prompt_ok, TRUE)
    . " image_translatable=" . json_encode($image_fields)
    . " frontend_flag=" . var_export($flag, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
