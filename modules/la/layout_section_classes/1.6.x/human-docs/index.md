# Layout Section Classes — manual setup guide

**Layout Section Classes** (`layout_section_classes`) lets a layout declare a
menu of selectable CSS classes so that, in Layout Builder, every section of that
layout gains dropdowns for choosing a class. The chosen class is applied to the
rendered section wrapper. In practice, a themer defines the allowed options once
in YAML — "Background: Primary / Muted", "Spacing: Large / Small" — and site
builders then pick from friendly labels per section, with no free-text class
fields and no risk of typos.

The mechanism is deliberately tiny. The module watches for any layout whose
definition (in a `*.layouts.yml` file) still uses core's default layout class
**and** declares a `classes:` key; it upgrades just those layouts so they render
the class pickers. Layouts without a `classes:` key are left completely untouched.
Each group under `classes:` becomes one dropdown, built from a list of
option-key → label pairs where the key is the actual CSS class applied. A group
can go further and also add classes to specific regions or set HTML attributes
(such as `data-*`) on the section.

This is a **developer/themer-facing** module: there is no admin UI, no settings
form, no permissions, no Drush command, and no configuration of its own — the
selected values live inside Layout Builder's own section configuration. You
"configure" it by editing YAML.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — the full `classes:` YAML schema,
`region_classes`, `attributes`, and where selections are stored — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Declare the classes on a layout by adding a `classes:` key to its definition in a
module's or theme's `*.layouts.yml`. For example:

```yaml
my_layout:
  label: 'My section'
  category: 'My layouts'
  template: templates/my-layout
  default_region: content
  classes:
    style:                       # one class GROUP → one dropdown per section
      label: 'Style'
      options:                   # REQUIRED: css-class => human label
        'bg-primary': 'Primary background'
        'bg-muted': 'Muted background'
      multiple: false            # true = a multi-select
      required: false            # true = force a choice
      default: 'bg-primary'
      description: 'Section background style.'
  regions:
    content:
      label: Content
```

Then rebuild caches (`drush cr`) so Drupal picks up the changed definition. Now,
when you add or edit a section of this layout in Layout Builder, you'll see a
**Style** dropdown; whatever the editor chooses becomes a CSS class on that
section's wrapper.

A few things worth knowing:

- **`options` is required** for each group. The option *key* is the literal class
  string applied (it may contain several space-separated classes); the *value* is
  the label editors see.
- `multiple: true` turns the group into a multi-select and applies an array of
  classes.
- A group can add `region_classes` (extra classes on named regions when a given
  option is chosen) and `attributes` (arbitrary HTML attributes like `data-*` on
  the section).
- If your layout needs its own PHP class, extend the module's `ClassyLayout`
  yourself — the automatic upgrade only touches layouts still using core's default
  class.
