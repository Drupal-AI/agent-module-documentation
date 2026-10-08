# Configuration

Entity Prepopulate has no central settings page. You configure it on each field
you want to prefill, using the **Entity Prepopulate** fieldset that the module
adds to the field's settings form.

## Open a field's settings

1. Go to **Structure → Content types → [type] → Manage fields**.
2. Click **Edit** on the field you want to prefill (this also works for a base
   field override).
3. Scroll to the **Entity Prepopulate** fieldset.

## The two settings

- **Value** — a text area holding the default value, which may contain tokens. For
  a simple field just type the value or token you want. For fields with several
  properties, use YAML keys (see the examples below). If the **Token** module is
  enabled, a token browser link appears here so you can pick tokens.
- **Also on update** — a checkbox. Leave it **off** (the default) to apply the
  value only when a *new* entity is created. Tick it to reapply the value on every
  edit as well — useful for a canonical value you always want enforced.

Save the field. If you leave both **Value** and **Also on update** empty, the
module removes its settings from the field entirely.

## How and when the value is applied

The value is set on the entity when its add/edit form is prepared, but only when
both of these hold:

- **Every token in the value resolves.** The module runs token replacement twice
  and only applies the result if both passes match — so if any token cannot be
  filled in, the field is left alone.
- **The resulting value passes validation.** After setting the value, the entity
  is validated; if the field's constraints are violated, the previous value is
  restored and a notice is logged.

Because there is no per-entity token context passed in, use global or context-free
tokens such as `current-date`, `current-user`, and site tokens.

## YAML value examples

- **A simple text/title field** (a scalar value or token):

  ```
  The current date is [current-date:custom:Y-m-d]
  ```

- **A text field with a format** — use YAML keys to set both properties:

  ```yaml
  value: "Hello [current-user:display-name]"
  format: basic_html
  ```

- **Multi-property fields** (geofield, link, address) — use the property keys that
  the field type expects, one per line, in the same YAML style.

## Deploying prepopulate settings

Because the settings are stored on the field configuration
(`field.field.<entity>.<bundle>.<field>` under `third_party_settings.epp`), they
travel with a normal configuration export, so you can move prepopulation rules
between environments like any other config.
