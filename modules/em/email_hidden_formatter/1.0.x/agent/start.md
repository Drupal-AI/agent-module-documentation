<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email Hidden Formatter (email_hidden_formatter) — agent index

A field formatter for core **email** fields that renders a **link** instead of the address; a
click fires an **AJAX** request that re-renders the field in place, revealing the email on demand.
Purpose: keep the address out of the initial HTML so casual scrapers do not see it. Package
`Custom`. Depends only on core **`field`**. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1.

- **The formatter, its one setting, the reveal route/controller, and how to enable it** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `EmailHiddenFormatter` (id **`email_hidden`**, label *"Email Hidden"*), in
  `src/Plugin/Field/FieldFormatter/EmailHiddenFormatter.php`, extending core `FormatterBase`.
  `field_types = { "email" }` — core email fields only.
- One route + controller for the reveal step: `email_hidden_formatter.email_hidden`
  (`email_hidden_formatter.routing.yml`) → `EmailHiddenController::process()`
  (`src/Controller/EmailHiddenController.php`).
- Config schema for the formatter setting: `config/schema/email_hidden_formatter.schema.yml`.
- No field type, no widget, **no permissions of its own**, no Drush, no services, no
  `.install`, no hooks (`email_hidden_formatter.module` is an empty stub), no JS/CSS shipped.

## Mechanism (from source)

- `viewElements()` builds, per delta, a `#type => link` render element whose `#title` is the
  configured link text and whose `#url` is `Url::fromRoute('email_hidden_formatter.email_hidden', …)`
  carrying `entity_type`, `entity_id`, `field_name` and the resolved `label` visibility; the link
  gets `class => ['use-ajax']`. The address itself is **not** placed in the initial markup.
- On click, `EmailHiddenController::process()` loads the entity, verifies the field exists and is
  non-empty, calls `$field->view(['label' => $label])`, and returns an `AjaxResponse` with a
  `ReplaceCommand` that swaps `.field--name-<field-name>` with the rendered (revealed) field.

## Setting (formatter)

- `title` (default `"Show email"`) — the link text, editable in the formatter settings form
  (`settingsForm()`), summarized by `settingsSummary()`. Schema key `title` (string).

Details, the route definition, and operating notes are in
[fields/formatter.md](fields/formatter.md).
