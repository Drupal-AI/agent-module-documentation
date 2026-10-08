<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# A11y Announce Form Auto-Submit (announce_autosubmit) — agent index

Accessibility helper: when a **Views exposed-filter form auto-submits** (whether via AJAX or a
full page reload), it makes an **ARIA-live announcement** naming the filter that changed and
**restores keyboard focus** to the element that triggered the submit. So screen-reader and
keyboard users are told the results updated and don't lose their place. Version **2.0.3**.
Core requirement `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

## What it actually is (from source)

- **One PHP hook**, `announce_autosubmit_form_views_exposed_form_alter()` in
  `announce_autosubmit.module`. It targets **`views_exposed_form`** only. It attaches the
  `announce_autosubmit/announce_autosubmit` library and pushes, into
  `drupalSettings.announce_autosubmit.forms[<form #id>]`, the form's `#id` (`formElementId`) and a
  `formParameters` list built from `$form['#info']` — each item is `{name, label, defaultValue}`
  (the exposed-filter machine name, its label, and its default value).
- **One JS behavior**, `Drupal.behaviors.AnnounceFormSubmitBehavior` in
  `js/announce_autosubmit.js`. On submit it stores the form id (and the changed filter's label) in
  `window.localStorage`; on `ajaxComplete` and on page reload it compares referrer vs. current URL
  query parameters, and if a filter value changed it calls **`Drupal.announce()`** (core's ARIA-live
  region) and refocuses the field. Uses `core/drupal.announce`, `core/jquery`, `core/once`.
- **No routes, no controllers, no services, no permissions, no config, no config schema, no
  plugins, no entities, no Drush.** The `.info.yml` declares no dependencies (core-only).

## Provides

- Library `announce_autosubmit/announce_autosubmit` (`announce_autosubmit.libraries.yml`):
  `js/announce_autosubmit.js` + deps `core/drupal`, `core/drupal.announce`, `core/jquery`,
  `core/once`.

## Solution docs

- **How the hook + behavior work, what it hooks, how to enable, and its scope/limits** →
  [behavior/announce.md](behavior/announce.md)

## Operate it

- Nothing to configure. `drush en announce_autosubmit -y`, then any View with an **exposed filter
  form set to auto-submit** (Views' "Exposed form → Auto-submit" option) gets the announcement +
  focus behavior automatically. Works with AJAX-enabled and non-AJAX (page-reload) Views.
