<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lazy Views — agent index

JS-only helper that loads any View via core's `views/ajax` endpoint on demand (on an event or on page
load), driven entirely by `data-lv-*` attributes on a placeholder element. No config UI (`configure`
null), no permissions, no services/plugins/Drush, no config schema. Depends on core `views`.

- **How to mark up an element to lazy-load a View: every `data-lv-*` attribute, the placeholder/target
  mechanics, execute-on-load vs trigger** → [theming/markup.md](theming/markup.md)

Key facts:
- `lazy_views_page_attachments()` attaches the `lazy_views/ajax` library on **every** page.
- `js/ajax.js` (`Drupal.behaviors.lazyViewsAjax`) processes every element with `data-lv-id`.
- It builds a `Drupal.ajax()` call to `drupalSettings.path.baseUrl + 'views/ajax'` — the View still
  renders server-side with its own access; this only defers the request.
