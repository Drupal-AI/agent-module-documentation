# Block Style Plugins — manual setup guide

**Block Style Plugins** (`block_style_plugins`) is an API module for developers and
themers. It lets a module or theme add **style configuration to the block
placement form** — extra fields whose values become CSS classes on the block (and,
optionally, a custom Twig template suggestion). The result: site builders and
editors can style individual block placements from the normal block form, without
touching CSS or templates for every variation.

You define styles with a small `BlockStyle` plugin. There are two ways to create
one: as a declarative YAML file (`MYMODULE.blockstyle.yml` or
`MYTHEME.blockstyle.yml`) — the easy path, and the one that works in themes where
annotations aren't scanned — or as a PHP class for advanced, stateful behaviour.
Each plugin can add a text field, a dropdown of preset variants, checkboxes for
utility classes, and so on, and can limit itself to specific blocks with
`include` / `exclude` lists (by block plugin id, a derivative wildcard, or a block
content bundle).

Values are saved as **block third-party settings**, so they export cleanly with
the block through configuration management, and are applied to the block wrapper's
`class` attribute at render time. The module itself has no admin UI, no settings
page, no permissions, and no Drush commands — it's purely the plumbing that other
modules and themes build styles on top of.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is **no admin page**. Once a module or theme defines block styles, the extra
fields appear inside a **Block Styles** fieldset on the normal block placement/
configuration form (at **Structure → Block layout**, or on the Layout Builder block
form). Styling is done per block instance right there.

## How to use it

Enable the module, then define at least one `BlockStyle` plugin — otherwise nothing
visible changes. The quickest way is a YAML file in a module or theme:

```yaml
# in mytheme.blockstyle.yml
sample_block_style:
  label: 'Sample Block Style'
  form:
    field_name:
      '#type': textfield
      '#title': 'Add a custom css class'
      '#default_value': 'my-class'
  template: block__my_custom_template   # optional theme suggestion
  include:                              # optional: limit to certain blocks
    - basic
```

- Each top-level key is a plugin id; `form:` fields must be flat (no nesting).
- The saved value of each field is appended to the block's `class` attribute at
  render (an unchecked checkbox / integer value is skipped).
- `template:` adds a block theme suggestion.

To target blocks, use `include` (limit to matches) *or* `exclude` (remove matches)
— matched against the block plugin id (e.g. `system_branding_block`), a derivative
wildcard (e.g. `block_content:*`), or a block content bundle machine name. An empty
`include` applies the style to all blocks.

For stateful logic, define a PHP class in a module's `Plugin/BlockStyle/` namespace
extending `BlockStyleBase` and override `buildConfigurationForm()` (themes, which
can't use annotations, point their YAML at a class with a `class:` key). The
sibling [`agent/`](agent/start.md) docs cover the PHP API, the include/exclude
matching, and the render lifecycle in full.
