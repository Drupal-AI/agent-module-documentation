<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings — `alpine_js.settings`

## Install / enable

`drush en alpine_js` (or `composer require drupal/alpine_js` first). No dependencies beyond Drupal
core and `ext-json`. Installing writes `config/install/alpine_js.settings.yml`.

## Route, form, menu

- Route `alpine_js.settings_form` → path **`/admin/config/development/alpinejs`**
  (`alpine_js.routing.yml`), `_form: Drupal\alpine_js\Form\SettingsForm`,
  `_title: 'Alpine.js Library settings'`.
- Menu link `alpine_js.settings_form` (`alpine_js.links.menu.yml`) under
  `system.admin_config_development` (Configuration → Development), weight 10.
- Route requirement: **`_permission: 'administer alpinejs configuration'`**. NOTE: the module ships
  **no `*.permissions.yml`**, so this permission is never defined. An undefined permission is
  granted to no role, so the form is effectively unreachable via the menu/route unless the
  permission is provided elsewhere. `info.yml` `configure:` points at this same route.

## Config object `alpine_js.settings`

Booleans only. Schema `config/schema/alpinejs.schema.yml` (`type: config_object`,
`alpinejs.settings` — note the schema key differs from the config name `alpine_js.settings`).
Install defaults (`config/install/alpine_js.settings.yml`):

| Key | Default | Meaning |
|-----|---------|---------|
| `global` | `0` | Load Alpine on every page. Off = load on demand only. |
| `admin` | `0` | Also load on admin routes (can conflict with admin-only libraries). |
| `footer` | `1` | Deliver Alpine + related JS in the footer; off = in the `<head>`. |
| `csp` | `0` | Use the CSP-safe Alpine build (`alpine_js/alpine-csp`) instead of the standard one. |
| `bridge` | `0` | Load the experimental `drupalbridge` plugin (adds the `$dbg()` magic). |
| `plugins.anchor` | `0` | Enable bundled Anchor plugin when Alpine loads. |
| `plugins.collapse` | `0` | Enable bundled Collapse plugin. |
| `plugins.focus` | `0` | Enable bundled Focus plugin. |
| `plugins.intersect` | `0` | Enable bundled Intersect plugin. |
| `plugins.persist` | `0` | Enable bundled Persist plugin. |
| `plugins.resize` | `0` | Enable bundled Resize plugin. |

Schema note: the `csp` key is misspelled **`brigde`** in the schema mapping (a typo — the real
config key written by the form is `bridge`), and the schema labels `brigde` as the bridge option.
This is a cosmetic schema mismatch; the form and service read/write the correct keys.

## The form (`SettingsForm`)

- `ConfigFormBase`; `getFormId()` = `alpinejs_settings`; `getEditableConfigNames()` =
  `['alpine_js.settings']` (static `$configName`).
- `buildForm()` renders checkboxes for `global`, `admin`, `footer`, `csp`, `bridge`, then a
  `plugins` fieldset of checkboxes from `getAvailablePlugins()` (anchor, collapse, focus,
  intersect, persist, resize), each linking to `alpinejs.dev/plugins/@plugin`.
- Overrides `t()` to force translation context `alpine_js`.
- `submitForm()` writes `global/footer/admin/bridge/csp` and rebuilds the `plugins` map from the
  same six keys, then `$config->save()`.

## Update hooks (`alpine_js.install`)

- `alpine_js_update_10001()` — set `csp` = FALSE if unset.
- `alpine_js_update_10002()` — set `plugins` to all-disabled (`anchor…persist`) if unset.
- `alpine_js_update_10003()` — set `global` = TRUE if unset (preserving the old always-load
  default on upgrade; fresh installs default `global: 0`).

## Operating it

- To load Alpine everywhere: enable `global`. To load only where needed: leave `global` off and
  either depend on `alpine_js/alpine_js` from a theme/library or tag a JS file
  `attributes: { alpinejs: true }` (see [../api/asset-ordering.md](../api/asset-ordering.md)).
- Enable only the plugins you use; each adds a bundled `js/vendor/alpinejs-<plugin>.min.js`.
- Export example:

```yaml
# config/sync/alpine_js.settings.yml
global: false
admin: false
footer: true
csp: false
bridge: false
plugins:
  anchor: false
  collapse: false
  focus: true
  intersect: true
  persist: false
  resize: false
```
