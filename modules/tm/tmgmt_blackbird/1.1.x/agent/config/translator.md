<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blackbird translator plugin & configuration

## Install / enable

- `ddev drush en tmgmt_blackbird -y` (pulls in `tmgmt` + `tmgmt_file`). Core `^8.8 || ^9 || ^10 || ^11`,
  PHP `7.1+`. No install/update hooks; nothing is created at enable time beyond plugin/schema discovery.

## Create the translator

- Go to `/admin/tmgmt/translators` (the module's `configure` route, `entity.tmgmt_translator.collection`),
  add a translator, and pick provider **Blackbird**. This creates a `tmgmt_translator` config entity with
  `plugin: blackbird`.
- The provider plugin is `BlackbirdTranslator` (`src/Plugin/tmgmt/Translator/BlackbirdTranslator.php`):
  - `@TranslatorPlugin(id = "blackbird", label = "Blackbird", map_remote_languages = FALSE,
    ui = "…\BlackbirdTranslatorUi", logo = "icons/blackbird.svg")`.
  - `checkAvailable()` → always `AvailableResult::yes()`; `checkTranslatable()` → always
    `TranslatableResult::yes()`; `hasCheckoutSettings()` → `FALSE` (no per-job checkout settings form).
  - Implements `MultipleCheckoutInterface` (aliased from the bundled
    `src/Compatibility/MultipleCheckoutInterface.php` when core TMGMT lacks the interface).

## The configuration form (`BlackbirdTranslatorUi`)

`src/BlackbirdTranslatorUi.php` (extends `TranslatorPluginUiBase`), `buildConfigurationForm()` adds:

- **`api_key`** — textfield, `#required`. `#default_value` is the existing setting or, when unset, a
  freshly generated `Crypt::randomBytesBase64()`. Description tells the admin to copy it into
  **Blackbird > Apps > Drupal > Connections**.
- **`regenerate`** — a "Generate new API key" submit button with an AJAX callback
  `ajaxRegenerateApiKey()` that writes a new `Crypt::randomBytesBase64()` value into the
  `edit-settings-api-key` field client-side (via `InvokeCommand … 'val'`) without submitting the form.
  `#limit_validation_errors` is scoped to `[['settings']]`.

`checkoutInfo(JobInterface $job)` renders the job's `reference` value as a **Note** item using
`#plain_text` (so a provider-supplied note is output as escaped text, not markup) under Provider
information; an empty note renders nothing.

## Config object & schema

- Settings live on the `tmgmt_translator` config entity under `settings` for the `blackbird` plugin.
- Schema `config/schema/tmgmt_blackbird.schema.yml`, type `tmgmt.translator.settings.blackbird`:
  - `api_key` — string, "Blackbird API key".
  - `auto_accept` — boolean, "Automatically accept finished translations". (Declared in schema and
    referenced by the README as a way to skip manual acceptance; the plugin/REST code in this version
    does not itself branch on it — acceptance is driven through the `accept` endpoint.)

## Credential handling (accurate)

The API key is the **only** credential and is stored in the translator's Drupal configuration (the
`tmgmt_translator` config entity's `settings.api_key`). It is generated in Drupal (`Crypt::randomBytesBase64`)
and pasted into Blackbird's Drupal-app connection — Blackbird then sends it back on every request as the
`x-api-key` header. The module defines no environment-variable or Key-module integration; the key lives in
config. Treat that config as sensitive and export it accordingly.
