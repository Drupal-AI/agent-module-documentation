#!/usr/bin/env bash
# Introspection setup: install a KNOWN ECK entity type + bundle so a medium eval can ask
# the agent to read the live config back. Creates entity type `eval_book` (label
# "Eval Book") with base fields Title + Created + Status ENABLED and Author + Changed
# DISABLED, standalone URL on, plus a bundle `hardcover` (label "Hardcover").
# Saving the type installs its DB tables via ECK's entity-definition update. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\eck\Entity\EckEntityType::load("eval_book")) {
    \Drupal\eck\Entity\EckEntityType::create([
      "id" => "eval_book",
      "label" => "Eval Book",
      "description" => "Known ECK type for introspection eval",
      "title" => TRUE,
      "created" => TRUE,
      "status" => TRUE,
      "uid" => FALSE,
      "changed" => FALSE,
      "standalone_url" => TRUE,
    ])->save();
  }
  if (!\Drupal::config("eck.eck_type.eval_book.hardcover")->get("type")) {
    \Drupal::entityTypeManager()->getStorage("eval_book_type")->create([
      "type" => "hardcover",
      "name" => "Hardcover",
      "description" => "Hardcover edition",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ECK type eval_book (title+created+status) with bundle hardcover installed"
