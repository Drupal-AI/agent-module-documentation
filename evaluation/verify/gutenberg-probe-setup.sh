#!/usr/bin/env bash
# Introspection SETUP: create a namespaced content type, enable the Gutenberg experience on it,
# and set a distinctive template lock, so an agent can read gutenberg.settings back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("gutenberg_probe")) { NodeType::create(["type" => "gutenberg_probe", "name" => "Gutenberg Probe"])->save(); }
  \Drupal::configFactory()->getEditable("gutenberg.settings")
    ->set("gutenberg_probe_enable_full", TRUE)
    ->set("gutenberg_probe_template_lock", "insert")
    ->save();
' >/dev/null 2>&1
echo "setup: gutenberg enabled on gutenberg_probe (template_lock=insert)"
