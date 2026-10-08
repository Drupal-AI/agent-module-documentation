# Color Scheme Field — manual setup guide

**Color Scheme Field** (`color_scheme_field`) provides a **field type for storing a
color scheme** — that is, it lets editors choose from a set of named color schemes
defined by your theme and store the choice on an entity. It is useful for
per-entity theming or branding, where a piece of content should be presented using
one of a handful of predefined palettes.

Unlike a free-form color picker, this field constrains editors to the schemes your
theme declares, which keeps content on-brand. Because of that, there is an important
**setup prerequisite**: before enabling the module you must add a list of color
scheme options to your **default theme's `.info.yml`** file. For example:

```yaml
color_scheme:
  scheme-one: Scheme one
  scheme-two: Scheme two
```

Once those options exist and the module is enabled, a new **"Color Scheme"** field
type becomes available that you can add to any entity. The stored value is color-scheme
data and the module has no content or access role of its own; as always, if a scheme is
turned into inline styles, emit it as a sanitized style value. It supports Drupal 10
and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — declare your schemes, install with
   Composer, and enable it.

There is **no configuration page** — the schemes come from your theme and the field
is added through the Field UI, described in "How to use it" below.

## How to use it

1. **First**, in your default theme's `.info.yml`, declare the available schemes
   under a `color_scheme:` key (see the example above), then clear caches.
2. Add a **Color Scheme** field to a content type (or other bundle) under **Structure
   → … → Manage fields**.
3. When editing content, the editor picks one of the theme-defined schemes.
4. Use the stored scheme in your theme/templates to apply the corresponding palette.
