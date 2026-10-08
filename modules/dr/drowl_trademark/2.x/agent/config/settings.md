<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config object, route & permission

## Install & enable

```bash
composer require drupal/drowl_trademark
drush en drowl_trademark -y
```

No module dependencies, no external PHP/JS libraries. (This is a dev branch — no `version:` in
`drowl_trademark.info.yml`.)

## Route, permission, menu

- Route `drowl_trademark.settings_form` → path **`/admin/config/user-interface/drowl_trademark`**,
  `_form: \Drupal\drowl_trademark\Form\DrowlTrademarkSettingsForm`
  (`drowl_trademark.routing.yml`).
- Requirement: `_permission: 'administer drowl trademark'`
  (defined in `drowl_trademark.permissions.yml`; title "Administer DROWL Trademark").
- `info.yml` sets `configure: drowl_trademark.settings_form`, so the Extend page shows a
  **Configure** link.
- Menu link `drowl_trademark.settings_form` (`drowl_trademark.links.menu.yml`) placed under
  `system.admin_config_ui` (Configuration → User interface), title "DROWL trademark".

## The settings form

`DrowlTrademarkSettingsForm` extends `ConfigFormBase` (so it is CSRF-protected and uses the core
config-form save flow). `getEditableConfigNames()` / `getFormId()` return
`drowl_trademark.settings` / `drowl_trademark_settings_form`. `buildForm()` renders **two required
`textfield`s**, `submitForm()` writes both values back to the config object and saves.

## Config object `drowl_trademark.settings`

Schema type `config_object` (`config/schema/drowl_trademark.schema.yml`); both keys are `type:
string`. Install defaults in `config/install/drowl_trademark.settings.yml`.

| Key | Form field | Default | Meaning |
|---|---|---|---|
| `drowl_trademark_replacements` | "Append ® to these words" | `''` | **Comma-separated** list of words to mark. This is the "defined texts". Empty by default, so nothing happens until an admin sets it. |
| `drowl_trademark_filter` | "Filter by jQuery filters (exclusion)" | `.no-drowl-trademark,.no-drowl-trademark *,a[itemprop=email] *,a[href^='mailto:'] *,.spamspan *` | jQuery selector of elements to **skip**. Default excludes opted-out containers, email links, and spamspan output. |

Example config export:

```yaml
# drowl_trademark.settings
drowl_trademark_replacements: 'Acme, Widgetify, ExampleBrand'
drowl_trademark_filter: ".no-drowl-trademark,.no-drowl-trademark *,a[itemprop=email] *,a[href^='mailto:'] *,.spamspan *"
```

## Notes

- Both fields are `#required: TRUE`; the filter field ships with a working default, so in practice
  you only add words. Clearing the words list disables the feature (the library never attaches).
- The word list is parsed server-side with `Drupal\Component\Utility\Tags::explode()` and joined
  with `|` before being handed to the JS — see [../api/rendering.md](../api/rendering.md).
