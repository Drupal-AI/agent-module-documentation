<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install & operate augmentor_nlpcloud

## Requirements

- Drupal core `^10.2 || ^11 || ^12`.
- Module dependency: `augmentor` (`augmentor:augmentor` in `augmentor_nlpcloud.info.yml`).
- Composer deps (`composer.json` `require`): `nlpcloud/nlpcloud-client:^1.0` (the PHP SDK, namespace `NLPCloud\NLPCloud`)
  and `drupal/augmentor:^1.0`.
- An NLP Cloud account and API token (https://nlpcloud.com). Requests go to the fixed `https://api.nlpcloud.io/v1/`
  base URL defined in the SDK (`NLPCloud::BASE_URL`); it is not configurable.

Install with Composer so the SDK is pulled in:
`composer require drupal/augmentor_nlpcloud` then `drush en augmentor_nlpcloud`.

## API key storage

The key is not stored by this module. `NPLCloudBase::getClient()` calls `getKeyValue()` (inherited from
`Drupal\augmentor\AugmentorBase`), which resolves a **Key** entity via `key.repository` and returns its value. So:
create a Key entity holding the NLP Cloud token (env or file provider recommended) and select it on the augmentor's
configuration form (the "key" field comes from the base). The token is sent only as an `Authorization: Token <token>`
HTTP header by the SDK — never placed in a URL.

## This module provides no routes, permissions, or config schema

`augmentor_nlpcloud` has no `*.routing.yml`, `*.permissions.yml`, `config/install`, or `config/schema`. Administration
happens entirely through the **Augmentor** module: augmentors are config entities created and edited at Augmentor's
admin list (webservices » augmentors), gated by Augmentor's `administer augmentors` permission (grant to trusted roles
only — full create/edit access). The only code besides plugins is `src/Hook/AugmentorNlpcloudHooks.php`
(`#[Hook('help')]` implementing `hook_help` for `help.page.augmentor_nlpcloud`), wired via
`augmentor_nlpcloud.services.yml` and the legacy shim in `augmentor_nlpcloud.module`.

## How an augmentor runs

Each plugin extends `NPLCloudBase` and implements `execute(string $text): array`:

1. Reads its configured `language`, `model`, and task options from `$this->configuration`.
2. `getClient($model, $gpu, $language)` lazily builds one `NLPCloud\NLPCloud` client (memoized in `$this->client`),
   passing the Key value as the token. `$gpu` is a per-plugin constant `NLP_CLOUD_GPU`; the SDK appends `/gpu/` and the
   language segment to the request URL.
3. Calls the matching SDK method (e.g. `summarization()`, `classification()`, `generation()`, `translation()`).
4. Returns `['default' => <result>]` on success, or on any `\Throwable` logs to the `augmentor` logger channel and
   returns `['_errors' => <generic message>]`. The generic message tells the operator to "check the logs"; the raw
   exception (an NLP Cloud HTTP status + response `detail`) is what gets logged.

## Configuration form fields (from `buildConfigurationForm`)

- `NPLCloudBase`: **Language** (textfield) — the input language, translated to English before processing.
- Most plugins add a **Model** select (task-specific model lists) and store it on submit.
- Classification adds **Entity type** + **Bundle** (AJAX-reloaded), **Threshold** (0–1), **Max labels** (1–10), and a
  **No result** message; it classifies text against the labels of the selected bundle's published entities.
- Summarization adds a **Size** select (small/large). Text generation adds **Max Length**, **Context** (a prompt
  template with a `{input}` placeholder). Translation adds **Source** and **Target** language selects (NLLB codes).
