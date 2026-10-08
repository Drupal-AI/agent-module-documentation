#!/usr/bin/env bash
# Execution VERIFY for "turn on AI alt text with a house prompt".
# PASS when media_directories_ai.settings on the live site has:
#   * enable_ai_alt_text === TRUE,
#   * a non-empty alt_text_prompt that is NOT the service's DEFAULT_PROMPT,
#   * ai_fillable_fields listing field_media_image:alt for the image bundle.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $config = \Drupal::config("media_directories_ai.settings");
  $enabled = $config->get("enable_ai_alt_text") === TRUE;
  $prompt = (string) ($config->get("alt_text_prompt") ?? "");
  $default = \Drupal\media_directories_ai\Service\AiAltTextService::DEFAULT_PROMPT;
  $prompt_ok = $prompt !== "" && $prompt !== $default;

  $fillable = (array) ($config->get("ai_fillable_fields") ?: []);
  $image_fields = array_values((array) ($fillable["image"] ?? []));
  $fields_ok = in_array("field_media_image:alt", $image_fields, TRUE);

  $ok = $enabled && $prompt_ok && $fields_ok;
  print ($ok ? "PASS" : "FAIL")
    . " enable_ai_alt_text=" . var_export($config->get("enable_ai_alt_text"), TRUE)
    . " custom_prompt=" . var_export($prompt_ok, TRUE)
    . " image_fillable=" . json_encode($image_fields) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
