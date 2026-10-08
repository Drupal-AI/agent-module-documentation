<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — `layout_builder_instant_preview.settings`

The module ships **one** config object and **no settings form / route** (there is no
`*.routing.yml`, no menu link, `configure` is null). Set the value with `drush cset` or via a
config-import.

## Schema

`config/schema/layout_builder_instant_preview.schema.yml`:

```yaml
layout_builder_instant_preview.settings:
  type: config_object
  label: 'Layout Builder Instant Preview settings'
  mapping:
    show_enable_preview_checkbox:
      type: boolean
      label: 'Show the "Automatic preview" checkbox on block and section forms'
```

| Key | Type | Default (effective) | Meaning |
|---|---|---|---|
| `show_enable_preview_checkbox` | boolean | unset → treated as TRUE | Controls the `#access` of the **Automatic preview** checkbox added to the update-block and configure-section forms. |

There is **no `config/install/`** file, so the key is unset until you set it. Both forms read it
as `$this->config('layout_builder_instant_preview.settings')->get('show_enable_preview_checkbox')`
and compute `'#access' => $show_checkbox === NULL || $show_checkbox` — so **NULL (unset) and TRUE
both show** the checkbox; only an explicit **FALSE** hides it.

## Set it

```bash
# Hide the "Automatic preview" checkbox site-wide:
drush cset layout_builder_instant_preview.settings show_enable_preview_checkbox 0 -y

# Show it again (or just delete the key):
drush cset layout_builder_instant_preview.settings show_enable_preview_checkbox 1 -y
```

## What hiding the checkbox does (and does not) do

- It removes the per-form **Automatic preview** toggle from the UI (`#access = FALSE`).
- It does **not** remove the **Preview** or **Cancel** buttons — those are always added on a
  non-`block_content` block form / an existing-section form (see
  [../architecture/route-override.md](../architecture/route-override.md)).
- The JS still reads `.toggle-instant-preview` and its `localStorage` value; with the checkbox
  hidden, the per-user auto-submit toggle is not user-adjustable from that form.
