<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Discord Webform Handler (discord_webform_handler) — agent index

A single **Webform handler plugin** that POSTs each Webform submission to a **Discord incoming
webhook**. Package `Webform`. Depends only on contrib **`webform:webform`**. Core requirement
`^10 || ^11`. License GPL-2.0-or-later. Installed version 1.0.1.

- **The handler, its one setting, how to add it to a webform, and the exact POST it sends** →
  [plugins/discord_webhook.md](plugins/discord_webhook.md)

## What it actually is

- One class: `DiscordWebformHandler` in
  `src/Plugin/WebformHandler/DiscordWebformHandler.php`, extending Webform's
  `WebformHandlerBase`. Plugin annotation `@WebformHandler` id **`discord_webhook`**, label
  *"Discord Webhook"*, category *External*, `cardinality = CARDINALITY_SINGLE`,
  `results = RESULTS_PROCESSED`.
- `discord_webform_handler.module` is an **empty** file (a `@file` doc block only) — no hooks.
- **No** routes, permissions, services, config schema, install file, libraries, sub-modules,
  or Drush commands. `README.txt` is a one-line title.

## Mechanism (from source)

- `defaultConfiguration()` → `['webhook_url' => '']` (plus the base handler defaults).
- `buildConfigurationForm()` exposes one field: `webhook_url` (`#type => 'url'`, title
  *"Discord Webhook URL"*). `submitConfigurationForm()` saves it into
  `$this->configuration['webhook_url']`.
- `submitForm()` runs on each submission: reads `$webform_submission->getData()`, gets
  `\Drupal::httpClient()`, and `POST`s to the configured `webhook_url` with body
  `['json' => ['content' => json_encode($data)]]`. Discord shows that JSON string as a channel
  message.
- Errors are caught and logged to the `webform_discord_webhook` logger channel via
  `Error::logException` / `watchdog_exception` (through `DeprecationHelper::backwardsCompatibleCall`).

## Operating notes

- The webhook URL is **per-webform handler config**, set by whoever can administer that webform's
  handlers — it is not influenced by the form submitter.
- Uses the shared Guzzle client with default options (TLS verification on); no custom Discord
  embed formatting — the whole submission is dumped as JSON into `content`.
- See [plugins/discord_webhook.md](plugins/discord_webhook.md) for a couple of source-level caveats.
