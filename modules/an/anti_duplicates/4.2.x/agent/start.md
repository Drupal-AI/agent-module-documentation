<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anti-Duplicates (anti_duplicates) — agent index

Author-facing duplicate-content warning for node forms. On every node add/edit form it attaches a
debounced-keyup AJAX callback to the **title** field that queries existing nodes of the same type and
lists possible duplicates (up to 5 links + a total count). Can optionally block form submission until
the author clicks "Not a duplicate". Version **4.2.0**, core `^9 || ^10 || ^11`.

- **Dependency:** core `node` only. No composer requirements. JS lib depends on `core/jquery`.
- **Permission:** `administer anti_duplicates` (restrict access) — gates the settings form only.
- **Route:** `anti_duplicates.admin_page` → `admin/config/anti-duplicates` (`_form: AntiDuplicatesAdminForm`).
- **Config object:** `anti_duplicates.settings` (schema in `config/schema/anti_duplicates.schema.yml`).
- **Hook:** `anti_duplicates_form_node_form_alter()` in `anti_duplicates.module` — attaches the AJAX +
  results markup + `anti_duplicates/anti_duplicates` library.
- **AJAX callback:** `Drupal\anti_duplicates\Form\AntiDuplicatesFormAlter::duplicatesSearch()` (a static
  form `#ajax` callback, not a route) — builds an `AjaxResponse` of the duplicate listing.
- **Settings form:** `Drupal\anti_duplicates\Form\AntiDuplicatesAdminForm` (extends `ConfigFormBase`).
- No entities, no services, no plugins, no Drush commands, no submodules.

Solution docs:
- [Configuration & settings](config/settings.md) — the `anti_duplicates.settings` keys, search types, placement.
- [Duplicate-search behavior](api/duplicate-search.md) — the form alter + AJAX callback and its query logic.
