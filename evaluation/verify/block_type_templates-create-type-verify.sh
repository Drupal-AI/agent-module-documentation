#!/usr/bin/env bash
# Execution VERIFY: PASS when the btt_task block content type exists AND block_type_templates emits
# the per-type suggestion block__block_content_btt_task for a block of that type. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block_content\Entity\BlockContent;
  $exists = (bool) \Drupal::entityTypeManager()->getStorage("block_content_type")->load("btt_task");
  $sugg = ["block__block_content"];
  if ($exists) {
    $bc = BlockContent::create(["type"=>"btt_task","info"=>"btt probe"]);
    $vars = ["elements"=>["content"=>["#block_content"=>$bc,"#view_mode"=>"full"]],"base_plugin_id"=>"block_content"];
    block_type_templates_theme_suggestions_block_alter($sugg, $vars);
  }
  $ok = $exists && in_array("block__block_content_btt_task", $sugg, TRUE);
  print (($ok ? "PASS" : "FAIL")) . " exists=" . var_export($exists, TRUE) . " suggestions=" . implode("|", $sugg) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
