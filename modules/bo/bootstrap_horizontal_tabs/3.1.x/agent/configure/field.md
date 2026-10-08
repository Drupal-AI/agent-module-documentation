# Configure the Horizontal Tabs field

## The Field API triad

| Plugin | ID | Notes |
|---|---|---|
| Field type | `bootstrap_horizontal_tabs` | Multi-value; each delta is one tab. `default_widget`/`default_formatter` both `bootstrap_horizontal_tabs`. |
| Widget | `bootstrap_horizontal_tabs` | **Tab Label** (`textfield`, maxlength 255) + **Tab Body** (`text_format`). |
| Formatter | `bootstrap_horizontal_tabs` | Renders Bootstrap tab/pill markup. |

Add it like any field: *Manage fields → Add field → Horizontal Tabs*, set cardinality (usually
Unlimited so editors add as many tabs as needed), then set the widget on *Manage form display* and the
formatter on *Manage display*.

### Field type storage (`schema()`)

- `header` — `varchar(512)`
- `body_value` — `text`
- `body_format` — `varchar(512)`

`isEmpty()` is true only when both header and body are empty. Constraints: a `ComplexData` NotBlank
requires `header` when the body has a value; the widget additionally errors on **duplicate headers**
(`massageFormValues()` compares trimmed headers across deltas).

## Formatter settings (`defaultSettings()`)

| Setting | Values | Default | Effect |
|---|---|---|---|
| `tab_display` | `tabs`, `pills` | `tabs` | `nav-tabs` vs `nav-pills`; `tabs` also attaches the `deep-linking` library. |
| `tab_orientation` | `horizontal`, `vertical` | `horizontal` | `vertical` adds `flex-column nav-stacked`. |

Schema for `tab_display`: `field.formatter.settings.bootstrap_horizontal_tabs` (`tab_orientation` is in
`defaultSettings()` and the settings form). Configure under the field's row on *Manage display*.

Behavior notes:
- A field with **one** item renders as plain content (no nav, no tab wrappers) — `$has_multiple` false.
- The first tab gets `active` (+ `show`/`in` classes as appropriate) and `aria-selected="true"`.
- Each tab id is `Html::getUniqueId()` of the transliterated header, so headers drive anchor ids.

## Site-wide Bootstrap version setting

Config object `bootstrap_horizontal_tabs.settings`, key `version` (schema
`bootstrap_horizontal_tabs.settings` → `version` string; default `"5"` from `config/install`).

- Admin form: `BaseConfigurationForm` at `/admin/config/content/bootstrap-horizontal-tabs`
  (route `bootstrap_horizontal_tabs.configuration`, permission `administer site configuration`).
  Options: Bootstrap 3 / 4 / 5. **Saving flushes all caches** (`drupal_flush_all_caches()`).
- The formatter reads it to pick the toggle attribute: `data-bs-toggle` for v5, else `data-toggle`,
  and to decide `show`/`active` class placement (v3 differs from v4/5).

Set it with Drush:

```bash
ddev drush config:set bootstrap_horizontal_tabs.settings version 4 -y && ddev drush cr
```

## Requirements

The module emits Bootstrap **markup only**. Bootstrap CSS and the tab JavaScript must come from the
active theme (e.g. a Bootstrap 5 theme). Match the `version` setting to the theme's Bootstrap major.
