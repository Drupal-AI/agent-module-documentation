#!/usr/bin/env bash
# Introspection SETUP: create a Key entity azure_api_known (authentication) representing the Azure AI
# provider's API key, so an agent can discover which key holds the Azure credential. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\key\Entity\Key;
  if (!Key::load("azure_api_known")) {
    Key::create([
      "id" => "azure_api_known", "label" => "Azure AI API Key (known)",
      "key_type" => "authentication",
      "key_provider" => "config",
      "key_provider_settings" => ["key_value" => "PLACEHOLDER-AZURE-KEY"],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Key entity azure_api_known created (authentication)"
