<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site-wide settings (`tabpanelwidget.settings`)

## Route, permission, menu

- Route **`tabpanelwidget.settings_form`** → `/admin/config/content/tabpanelwidget`
  (`tabpanelwidget.routing.yml`), form `Drupal\tabpanelwidget\Form\SettingsForm`.
- Permission **`administer tabpanelwidget configuration`** (`tabpanelwidget.permissions.yml`,
  `restrict access: true`).
- Menu link `tabpanelwidget.settings_form` under `system.admin_config_content`
  (*Configuration → Content authoring*), title "TabPanelWidget".

These are the **default** options used by new TabPanelWidget displays; the Views style plugin and
the Quick Tabs renderer each override them per instance.

## Config object & schema

Object **`tabpanelwidget.settings`** (`config/install/tabpanelwidget.settings.yml`, schema
`config/schema/tabpanelwidget.schema.yml`, type `config_object`):

| Key | Type | Install default | Meaning |
|---|---|---|---|
| `elements` | string | `h2` | Header element for tabs/accordion headers (`h2`–`h5`). |
| `behavior` | string | `responsive` | `responsive` / `tabpanel` (always tabs) / `accordion` (always accordion). |
| `polyfill` | boolean | `true` | Serve the ResizeObserver polyfill site-wide (IE10/11 + older browsers). |
| `tab_style` | string | `standard` | `standard` / `fancy` / `pills` / `bar`. |
| `tab_options.centered` | boolean | `false` | Center tabs instead of left-aligning. |
| `tab_options.rounded` | boolean | `false` | Rounded corners (not applied to `bar` style). |
| `accordion_options.disconnected` | boolean | `false` | Space + round the accordion headers. |
| `accordion_options.icons_at_the_end` | boolean | `false` | Expand/collapse icons at header end. |
| `accordion_options.chevrons_east_south` | boolean | `false` | Chevrons point East/South, not South/North. |
| `accordion_options.plus_minus` | boolean | `false` | Replace chevrons with +/−. |
| `accordion_options.animate` | boolean | `false` | Animate icon state changes. |

## Form behavior (`SettingsForm`)

- `getEditableConfigNames()` → `['tabpanelwidget.settings']`; `getFormId()` → `tabpanelwidget_settings`.
- Three groups: **Main settings** (`elements`, `behavior`, `polyfill`), **Tab settings**
  (`tab_style`, `tab_options` checkboxes), **Accordion settings** (`accordion_options` checkboxes).
- The Tab-settings and Accordion-settings fieldsets use `#states` to show/hide based on the
  `behavior` select (tab settings hidden when behavior is `accordion`; accordion settings hidden
  when behavior is `tabpanel`).
- `submitForm()` writes `elements`, `behavior`, `polyfill`; and — only when behavior is **not**
  `accordion` — `tab_style`, `tab_options`, `accordion_options` (otherwise `tab_style` is reset to
  `standard` and the option arrays to `[]`).

## Drush / config example

```bash
drush cset tabpanelwidget.settings behavior tabpanel -y
drush cset tabpanelwidget.settings tab_style pills -y
drush cset tabpanelwidget.settings tab_options.centered true -y
drush cr
```

```yaml
# tabpanelwidget.settings
elements: h3
behavior: responsive
polyfill: false
tab_style: pills
tab_options:
  centered: true
  rounded: true
accordion_options:
  disconnected: true
  icons_at_the_end: false
  chevrons_east_south: false
  plus_minus: false
  animate: true
```
