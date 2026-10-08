#!/usr/bin/env bash
# Execution RESET: ensure an EBT block type ebt_rhtask exists with exactly one block_content
# entity of that type, so verify FAILS (count != 0) until the agent removes it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block_content\Entity\BlockContent;
  $ts = \Drupal::entityTypeManager()->getStorage("block_content_type");
  if (!$ts->load("ebt_rhtask")) { $ts->create(["id"=>"ebt_rhtask","label"=>"EBT RH Task"])->save(); }
  $bs = \Drupal::entityTypeManager()->getStorage("block_content");
  $ids = \Drupal::entityQuery("block_content")->accessCheck(FALSE)->condition("type","ebt_rhtask")->execute();
  if ($ids) { $bs->delete($bs->loadMultiple($ids)); }
  BlockContent::create(["type"=>"ebt_rhtask","info"=>"EBT RH Task probe block"])->save();
' >/dev/null 2>&1
echo "reset: ebt_rhtask type present with 1 block_content entity"
