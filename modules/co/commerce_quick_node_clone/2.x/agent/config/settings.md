<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config objects, and legacy migration

## Settings form

- Route `commerce_quick_node_clone.settings` → `/admin/config/content/commerce-quick-node-clone`,
  permission `Administer Quick Node Clone Settings`. Menu link
  `commerce_quick_node_clone.settings` ("Quick Node Clone", under
  `system.admin_config_content`).
- Class `CommerceQuickNodeCloneSettingsForm` (extends `ConfigFormBase`), form id
  `commerce_quick_node_clone_settings_form`, editable config
  `commerce_quick_node_clone.settings`.
- Two fields:
  - `text_to_prepend_to_title` — textfield. Optional prefix added before each cloned product
    title. `submitForm()` stores it `trim()`-ed.
  - `clone_status` — checkbox "Copy publication status from source product". When checked, the
    clone keeps the source's published state; when unchecked, the clone gets the destination
    bundle's **default** status. Stored as a bool.
- On build, each value falls back to the legacy `quick_node_clone.settings` object when the new
  object's value is NULL.

## Config object `commerce_quick_node_clone.settings`

`config/install/commerce_quick_node_clone.settings.yml` ships:

```yaml
text_to_prepend_to_title: ''
clone_status: true
```

Schema (`config/schema/commerce_quick_node_clone.schema.yml`) defines three keys:

- `text_to_prepend_to_title` — string.
- `clone_status` — boolean.
- `exclude` — a nested sequence `exclude.<entity_type>.<bundle>.<index> = <field_name>`. The
  controller only reads the `exclude.paragraph.<bundle>` branch (list of paragraph field names to
  drop from a clone). There is **no UI** for `exclude`; set it via config import/`drush cset` if
  you need to omit specific paragraph fields.

The schema also declares a mirror `quick_node_clone.settings` object of the same shape (the
legacy key, see below).

## Legacy key + post-update migration

The module historically stored settings under `quick_node_clone.settings`. `getConfigSettings()`
and the form both fall back to that key when the new one is unset, so existing sites keep working
before migration runs. Two post-update hooks (`commerce_quick_node_clone.post_update.php`)
populate the new object:

- `commerce_quick_node_clone_post_update_create_settings` — if the new object is empty, copies
  `text_to_prepend_to_title` (default `''`) and `clone_status` (default TRUE) from the legacy
  object.
- `commerce_quick_node_clone_post_update_migrate_config_key_d12` — the same migration, framed as
  D12 forward-compat; only runs when the new object is empty and the legacy object has data. The
  legacy key is slated for removal in v3.0.0.

Run `drush updb` after updating to apply these.
