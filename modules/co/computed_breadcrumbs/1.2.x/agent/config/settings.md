<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object, route & permission

## The one setting

`Form\SettingsForm` (form id `computed_breadcrumbs_settings_form`, extends `ConfigFormBase`)
exposes a single checkbox:

| Field | Config key | Type | Default | Meaning |
|---|---|---|---|---|
| *Use relative urls.* | `use_relative_urls` | boolean | `FALSE` | When on, breadcrumb URIs are built **relative** (`setAbsolute(FALSE)`); when off (default) they are **absolute**. |

The form edits config object **`computed_breadcrumbs.settings`** (`getEditableConfigNames()`),
reads the current value into `#default_value`, and writes it back in `submitForm()` with
`->set('use_relative_urls', …)->save()`.

## Config object

- Object: **`computed_breadcrumbs.settings`**
- Install default (`config/install/computed_breadcrumbs.settings.yml`): `use_relative_urls: false`
- Schema (`config/schema/computed_breadcrumbs.schema.yml`): `config_object` with the single
  `use_relative_urls` boolean mapping.

Set it from the CLI without the form:

```bash
drush cset computed_breadcrumbs.settings use_relative_urls true -y
drush cr
```

The value is read at field-compute time in `ComputedBreadcrumbsItemList::computeValue()`; changing
it affects breadcrumbs computed after the change (clear caches / re-read to see it).

## Route & menu

- Route **`computed_breadcrumbs.settings`** → path
  **`/admin/config/user-interface/computed-breadcrumbs`**, `_form` =
  `\Drupal\computed_breadcrumbs\Form\SettingsForm`, title *Computed Breadcrumbs settings*.
- Menu link `computed_breadcrumbs.settings` (`computed_breadcrumbs.links.menu.yml`) under
  `system.admin_config_ui` (*Configuration → User interface*).

## Permission

`computed_breadcrumbs.permissions.yml` defines one permission:

- **`administer computed breadcrumbs`** — *"Allow users to access module configuration form."*
  It is the `_permission` requirement on the settings route. It gates only the settings form; it
  does **not** affect who can read the `breadcrumbs` field.

## What it does not provide

No Drush commands, no submodules, no additional config objects, no plugin managers/derivers. The
module's entire surface is: the base field + field type (see
[../api/computed-field.md](../api/computed-field.md)), the event subscriber
`computed_breadcrumbs.event_listener`, this settings form/config object, and the one permission.
