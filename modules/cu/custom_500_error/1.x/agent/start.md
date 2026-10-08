<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom 500 Error (custom_500_error) — agent index

Replaces Drupal's default **HTTP 500 (Internal Server Error)** page body with administrator-authored
markup. Mechanism: an event subscriber (`ExceptionSubscriber`, extending core
`HttpExceptionSubscriberBase`) registers an `on500()` handler at a very low priority (`4`); when an
uncaught exception produces a 500 for an `html` request, it reads the string stored under the
`custom_error_markup` key of config `custom_500_error.customerrorconfig` and returns it as the body
of a new `Response(..., 500)`. A single admin settings form (`text_format` field) writes that config
key. There is no theming, token replacement, or per-path logic — the stored string is the whole
response body.

- Depends on: nothing (core only). No composer.json; `dependencies:` is empty.
- Core: `^8.8 || ^9.0 || ^10 || ^11`. Package: `Improvement`. Type: module.
- Settings page: yes — `configure: custom_500_error.custom_error_config_form` at
  `/admin/config/custom_500_error/customerrorconfig` (permission `access administration pages`).
- No own permissions, no drush commands, no plugin types, **no config schema** (no `config/schema/`).
- One event subscriber service; one config object with one key; one admin menu link; `hook_help`.
- Note: the install config (`config/install/custom_500_error.customerrorconfig.yml`) ships only the
  literal `custom_500_error:` (a null top-level key) — it does **not** seed `custom_error_markup`, so
  until the form is saved `on500()` emits an empty-body 500 response.

## What you'd do → where

- **Set/change the custom 500 body, and understand the config key + render mechanism** →
  [configure/settings.md](configure/settings.md)

## Key facts (real machine names)

- Route: `custom_500_error.custom_error_config_form` — path
  `/admin/config/custom_500_error/customerrorconfig`, `_form:
  \Drupal\custom_500_error\Form\CustomErrorConfigForm`, `_permission: 'access administration pages'`,
  `options._admin_route: TRUE`.
- Form: `CustomErrorConfigForm` (extends `ConfigFormBase`), form id `custom_error_config_form`,
  editable config `custom_500_error.customerrorconfig`, single element `custom_error_markup`
  (`#type: text_format`). `submitForm()` stores only `$form_state->getValue('custom_error_markup')['value']`.
- Service: `custom_500_error.exception_subscribtr` (sic) →
  `Drupal\custom_500_error\EventSubscriber\ExceptionSubscriber`, arg `@config.manager`, tag
  `event_subscriber`. Handles format `html`, priority `4`, method `on500()`.
- Config object: `custom_500_error.customerrorconfig`, key `custom_error_markup` (string).
- Menu link: `custom_500_error.custom_error_config_form` under `system.admin_config_system`, weight 99.
- Hook: `custom_500_error_help` (help.page.custom_500_error).
