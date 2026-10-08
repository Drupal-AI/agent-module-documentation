<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FZ152 — Consent — configuration & data model

## Config

`fz152_consent.settings` (route `fz152_consent.settings`, form `FZ152ConsentSettingsForm`,
permission `administer fz152_consent`) at `/admin/config/system/fz152/consent-settings`:

- `source` (text) — newline-separated list of **form field names** whose submitted `#value`s are
  saved into the consent record's `source` field. Default: `name`, `surname`, `email`, `phone`,
  `mail`. Both regular form elements (`$form[$name]['#value']`) and webform elements
  (`$form['elements'][$name]['#value']`) are read.

## Capture flow (`fz152_consent.module`)

1. `hook_form_alter` computes the tracked-form pattern from `fz152.service::getForms()` (and
   `fz152_contact.service::getForms()` if that module is on) and, on a match, appends
   `_fz152_consent_custom_form_submit` to `$form['actions']['submit']['#submit']`.
2. On submit the handler reads `\Drupal::service('request_stack')` client IP, `$form['#form_id']`,
   splits `source` on newlines, collects each present field value, `implode(',', …)`.
3. If the joined source is non-empty it calls `FZ152ConsentService::createConsent($ip, $form_id,
   $source)`; otherwise it logs a warning and stores nothing.

## Entity `fz152_consent`

`ContentEntityType` (`src/Entity/FZ152Consent.php`), base table `fz152_consent`:

| field | type | notes |
|---|---|---|
| `id` / `uuid` | identifiers | label = `id` |
| `created` | created | timestamp |
| `ip` | string | client IP at submit |
| `form_id` | string | originating form id |
| `source` | string | comma-joined captured field values |

- `admin_permission = "administer fz152_consent"` (restrict access — governs entity operations).
- Routes: `delete-form` `/fz152-consent/{fz152_consent}/delete`, `delete-multiple-form`
  `/admin/content/fz152-consent/delete-multiple` (via `FZ152ConsentHtmlRouteProvider`).
- No add/edit form — records are created only programmatically by the submit handler.

## View

`config/install/views.view.fz152_consents.yml` installs a `fz152_consents` View over the
`fz152_consent` base table for admins to browse the stored consents.

## Service

`FZ152ConsentService` (service `fz152_consent.service`) — sole method
`createConsent(string $ip, string $form_id, string $source): void` (creates + saves the entity).
