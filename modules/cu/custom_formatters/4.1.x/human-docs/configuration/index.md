# Configuration

## Open the formatters screen

1. Log in as a **fully trusted administrator** with the **Administer Custom
   Formatters** (`administer custom formatters`) permission. Remember this
   permission allows running code on the server — see the
   [overview](../index.md#where-it-lives-in-the-admin-menu).
2. Go to **Structure → Formatters**, or navigate directly to
   `/admin/structure/formatters`.

This lists every formatter you've created. Click **Add formatter** to make a new
one.

## Create a formatter

When you add a formatter you'll set:

- **Label** — the human‑friendly name shown as the formatter option on *Manage
  display*.
- **Machine name** — the internal id.
- **Field types** — which field types the formatter applies to. This limits where
  it shows up: a formatter for `string` fields only appears on text fields, and so
  on.
- **Engine (type)** — how the formatter produces its output (see below).
- **Code / configuration (the `data`)** — the snippet or settings the engine runs.

## Choose an engine

| Engine | What you write | Notes |
|--------|----------------|-------|
| **PHP** | A bare PHP snippet (no `<?php` tags) | It is executed at render time and receives the field `$items`, `$langcode`, `$settings`, and `$raw_settings`. Return markup or a render array, or echo output. Runs arbitrary code — trusted admins only. |
| **Twig** | A Twig template string | Rendered through Drupal's Twig service; your template gets `items`, `langcode`, `entity`, `settings`, and `raw_settings`. A Twig template is compiled and run, so this too is arbitrary code. |
| **HTML+Token** | HTML containing `[tokens]` | The tokens are replaced with field/entity values. Needs the Token module (and Field Tokens for field‑level tokens). |
| **Formatter Preset** | A selection of an existing formatter plus locked settings | Wraps a core/contrib formatter as a reusable preset — no code involved. |

If you installed CodeMirror Editor, the code field gets syntax highlighting and
autocomplete appropriate to the engine.

Save the formatter, then go to a field's **Manage display** tab and pick your new
formatter from the *Format* dropdown, just like any built‑in one.

## Add per‑instance settings (optional)

A formatter can expose its own settings fields, so whoever selects it on a field
can pass in values (a CSS class, a yes/no toggle, etc.):

1. On the formatters list, open your formatter's **Manage fields** tab and add
   fields to it, just as you would to a content type.
2. When the formatter is chosen on a *Manage display* screen, those fields appear
   inline for the editor to fill in.
3. Their values reach your engine keyed by field machine name:
   - **PHP** — `$settings['field_name']` (rendered) and
     `$raw_settings['field_name']` (unformatted).
   - **Twig** — `{{ settings.field_name }}` and `{{ raw_settings.field_name }}`.
   - **HTML+Token** — `[formatter_setting:field_name]` and
     `[formatter_setting:field_name:raw]`.

The module ships a few example formatters (Twig, HTML+Token, PHP, and preset)
which install when their dependencies are present — a useful reference to copy
from.

## Deploying formatters

Each formatter is stored as a configuration entity (config name
`custom_formatters.formatter.<id>`), so it exports and imports with your
configuration and deploys across environments like any other config.

> **A reminder on trust.** Importing configuration that contains a PHP or Twig
> formatter is the same as importing code — only accept formatter config from
> sources you trust, and keep the *Administer Custom Formatters* permission limited
> to site administrators.
