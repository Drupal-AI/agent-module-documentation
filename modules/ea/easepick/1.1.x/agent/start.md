<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easepick (easepick) — agent index

Thin, code-driven integration of the [easepick](https://easepick.com/) JavaScript date/range picker into Drupal forms. Version 1.1.0 (version dir `1.1.x`). Core `^9.4 || ^10 || ^11`. Package `Custom`. License GPL-2.0-or-later.

## What it provides
- **Asset libraries** (`easepick.libraries.yml`): `easepick.bundle`, `easepick.core`, `easepick.datetime`, and one per easepick plugin — `easepick.amp-plugin`, `easepick.kbd-plugin`, `easepick.lock-plugin`, `easepick.range-plugin`, `easepick.preset-plugin`, `easepick.time-plugin`. All JS/CSS are `type: external` from `cdn.jsdelivr.net` (`@easepick/*@1.2.1`). Plus `drupal.easepick`, a local initializer (`assets/js/easepick.js`) depending on `core/drupal` + `core/once`.
- **`hook_form_alter()`** — `easepick_form_alter()` in `easepick.module`: when a form has `$form['easepick']['#value'] === TRUE`, it attaches `easepick/easepick.core` and `easepick/drupal.easepick`. (Attaching `easepick.bundle` is commented out; see drupal.org issue 3411027 — it breaks Olivero.)
- **Demo route** `easepick.easepick_example` → `/easepick/example` (`easepick.routing.yml`), `_form: Drupal\easepick\Form\ExampleForm`, `_permission: 'access content'`.
- **Demo form** `Drupal\easepick\Form\ExampleForm` (`src/Form/ExampleForm.php`), form id `easepick_example`.

## What it does NOT provide
No config/settings, no config schema, no permissions, no services, no plugins, no Drush, no Composer requirements, no field widget or FAPI element type, no module dependencies.

## How to use
Set `$form['easepick'] = ['#value' => TRUE, '#type' => 'value']` on your form; the initializer binds easepick to the element with HTML id `edit-checkin`. Target other fields by shipping your own initializer JS and attaching the relevant library.

## Solution docs
- [Integration & libraries](api/integration.md) — form flag, hook_form_alter, library list, CDN sourcing, demo route/form, and how to target other fields/plugins.
