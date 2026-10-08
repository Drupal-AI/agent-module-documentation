# Skpr Key — manual setup guide

**Skpr Key** (`skpr_key`) adds a new key provider to the
[Key](https://www.drupal.org/project/key) module that reads its secrets from
[Skpr](https://skpr.io) — the hosting platform's configuration store — using the
`skpr/php-config` library. In other words, it lets a Drupal Key entity source its
value from Skpr's secret store rather than from Drupal's own configuration.

That is a security-positive way to handle credentials: your API keys and secrets
stay in the platform's secret store and are exposed to Drupal only through the Key
abstraction, so they never end up in exported configuration or committed to
version control. The module itself is a credential *source* — it has no
access-control role and no content of its own. It depends on the Key module and
runs on Drupal 9, 10, and 11. This is a beta release (2.0.0-beta2), and the
project carries official security-advisory coverage.

The module works by giving you a provider to choose when you create a Key entity;
there is no separate global settings form to fill in. As with any secret store,
make sure the Skpr secrets themselves are managed with least privilege.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, the provider is available wherever the Key module lets you create a
key:

1. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and
   choose **Add key**.
2. Give the key a name and, for the **Key provider**, select the **Skpr**
   provider.
3. Configure the provider with the Skpr config key that holds the secret you want
   to expose.

The Key entity then reads its value from Skpr whenever another module (an API
integration, for example) asks for that key.
