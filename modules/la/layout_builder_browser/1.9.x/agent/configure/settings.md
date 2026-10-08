<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings — `layout_builder_browser.settings`

Simple config object, form at `/admin/config/content/layout-builder-browser/settings`
(route `layout_builder_browser.admin_settings`, form id `layout_builder_browser_settings_form`).

## Keys

| Key | Type | Ships as | Meaning |
|---|---|---|---|
| `enabled_section_storages` | sequence of strings | `['overrides']` | Section storage **plugin ids** the browser takes over. Only `defaults` and `overrides` are offered by the form. |
| `use_modal` | boolean | *unset* (treated as FALSE) | Render the browser in a centred modal dialog instead of the off-canvas tray. |
| `auto_added_reusable_block_content_bundles` | sequence of strings | *unset* (treated as `[]`) | `block_content` bundle machine names whose **reusable** blocks are appended as an auto-generated "Reusable *Label*" category. |

Schema: `config/schema/layout_builder_browser.schema.yml`. `enabled_section_storages` has
`orderby: value`, so exported order is normalised.

## What each key actually does

**`enabled_section_storages`** is the on/off switch. `BrowserController::browse()` compares
`$section_storage->getPluginId()` against this list; if the id is missing it instantiates core's
`ChooseBlockController` and returns its build unchanged. So with the shipped default only
*per-entity layout overrides* use the curated browser — the "Manage layout" default-layout screen
still shows core's full list until you add `defaults`.

**`use_modal`** is read by two hooks in `layout_builder_browser.module`:
`hook_link_alter()` rewrites the block links' `data-dialog-type` to `dialog` with
`{width: "80%", height: "auto", target: "layout-builder-modal", autoResize: true, modal: true}`
and drops `data-dialog-renderer`; `hook_form_alter()` removes the `#ajax` handler from the submit
button of `layout_builder_add_block` / `layout_builder_update_block`. It also attaches the
`layout_builder_browser/modal` library.

**`auto_added_reusable_block_content_bundles`** loads every `block_content` entity of the named
bundle with `reusable = TRUE`, skips blocks with no translation in the current language, and only
lists ones **not already** registered as a `layout_builder_browser_block` (compared on `block_id`,
i.e. `block_content:<uuid>`).

## Read / write with drush

```bash
drush cget layout_builder_browser.settings
drush cget layout_builder_browser.settings enabled_section_storages

# turn the browser on for the default-layout screen too, and use a modal
drush cset layout_builder_browser.settings enabled_section_storages.1 defaults -y
drush cset layout_builder_browser.settings use_modal 1 -y
```

Replacing the whole sequence is easier in PHP (`cset` cannot delete list items):

```php
\Drupal::configFactory()->getEditable('layout_builder_browser.settings')
  ->set('enabled_section_storages', ['defaults', 'overrides'])
  ->set('use_modal', TRUE)
  ->set('auto_added_reusable_block_content_bundles', ['basic'])
  ->save();
```

Note the form saves through `array_filter()`, so unchecked checkboxes are stored as an absent
value rather than `0`/`''`.
