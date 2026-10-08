#!/usr/bin/env bash
# Execution RESET: create a namespaced content type with the Gutenberg experience DISABLED, so
# verify fails until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("gutenberg_task")) { NodeType::create(["type" => "gutenberg_task", "name" => "Gutenberg Task"])->save(); }
  \Drupal::configFactory()->getEditable("gutenberg.settings")->set("gutenberg_task_enable_full", FALSE)->save();
' >/dev/null 2>&1
echo "reset: content type gutenberg_task present, Gutenberg disabled"
