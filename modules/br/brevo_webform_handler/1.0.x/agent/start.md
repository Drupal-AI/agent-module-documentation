<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Brevo Webform Handler (brevo_webform_handler) — agent index

A single **Webform handler plugin** that, on submission, creates/updates a contact in a **Brevo**
(ex-Sendinblue) list via the **Brevo Contacts API** (`getbrevo/brevo-php` SDK). Package `Webform`.
Depends on **`webform`** (and Composer dep `getbrevo/brevo-php:^2.0`). Core `^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.1.

- **The handler plugin — settings form, field mapping, the API call, all methods** →
  [plugins/webform-handler.md](plugins/webform-handler.md)

## What it actually is

- One plugin: `BrevoWebformHandler` (`@WebformHandler` id **`brevo_webform_handler`**, label
  *"Brevo Webform Handler"*, category *Transaction*), in
  `src/Plugin/WebformHandler/BrevoWebformHandler.php`, extending `WebformHandlerBase`.
  `cardinality = CARDINALITY_UNLIMITED` (attach many per form), `results = RESULTS_PROCESSED`,
  `submission = SUBMISSION_OPTIONAL`.
- **No** routes, services, permissions, hooks, entities, Drush, config/install or config/schema
  files. All configuration is the handler's own `configuration` array, stored inside the
  **webform** config entity (third-party handler settings).

## Mechanism (from source)

- `defaultConfiguration()`: keys `api_key`, `list_id`, `email`, `name` (all `''`), plus per-attribute
  mapping keys added dynamically.
- `buildConfigurationForm()`: renders the API-key field, an *Update Brevo lists* AJAX submit button
  (`updateConfigSubmit()` → `$form_state->setRebuild()`), a *List* select from `getLists()`, a
  required *Email* element select, and one select per Brevo merge field from `getMergeFields()`.
- `getLists()`: paginates `ContactsApi::getLists(50, offset)` (50 = max page) to build
  `[list id => name]`. `getMergeFields($list_id)`: `ContactsApi::getAttributes()`, keeping
  attributes whose `category == 'normal'` as `[name => name]`.
- `submitForm()`: builds a `CreateContact` — `email` from the mapped element, `listIds = [intval($list_id)]`,
  `updateEnabled = TRUE`, `attributes` from the mapped elements — and calls
  `ContactsApi::createContact()`. `RequestException` is caught and **swallowed** (empty catch), so a
  failed send is silent (no watchdog, no user message).
- All Brevo calls authenticate with `Configuration::getDefaultConfiguration()->setApiKey('api-key', $this->configuration['api_key'])`
  and a plain `new GuzzleHttp\Client()` (SDK default TLS verification).

## Setup (no UI page of its own)

1. `composer require drupal/brevo_webform_handler` (pulls `getbrevo/brevo-php`), enable with
   `drush en brevo_webform_handler`.
2. On a webform: *Settings → Emails / Handlers → Add handler → Brevo Webform Handler*.
3. Paste the Brevo API key, click *Update Brevo lists*, pick the list, map *Email* (+ optional
   attribute fields), save.

See [plugins/webform-handler.md](plugins/webform-handler.md) for every method, config key, and the
exact request shape.
