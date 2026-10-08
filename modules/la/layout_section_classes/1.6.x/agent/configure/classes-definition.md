<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Declaring selectable classes on a layout

You "configure" this module by editing a **layout definition** in any module's or theme's
`*.layouts.yml`. Add a `classes:` key to a layout that uses the default plugin class. The module
detects it and upgrades the layout to `ClassyLayout`, which renders the pickers.

## Minimal example

```yaml
my_layout:
  label: 'My section'
  category: 'My layouts'
  template: templates/my-layout
  default_region: content
  classes:
    style:                       # a class GROUP key (becomes a select on each section)
      label: 'Style'
      options:                   # REQUIRED: value => human label
        'bg-primary': 'Primary background'
        'bg-muted': 'Muted background'
      multiple: false            # true = multi-select (array of classes)
      required: false            # true = force a choice
      default: 'bg-primary'      # default value (or array if multiple)
      description: 'Section background style.'
  regions:
    content:
      label: Content
```

- Each key under `classes:` is one **group** → one `<select>` on the section config form.
- `options` is **required** (the form throws if it's missing/not an array). The option *key* is
  the actual CSS class string that gets applied; the *value* is the label shown to editors.
- An option key may contain **multiple space-separated classes**
  (e.g. `'section--top-l section--bottom-l': 'Standard'`) — all are applied.
- `multiple: true` makes it a multi-select and stores/apply an array of classes.
- If not `required` (or required with no default), an `- Select -` empty option is added.

## Region classes — add classes to specific regions

Under a group, `region_classes` maps a chosen class to extra classes on named regions:

```yaml
    style:
      options:
        'bg-wave': 'Wave background'
      region_classes:
        'bg-wave':               # when this class is chosen...
          content: 'has-wave'    # ...add 'has-wave' to the 'content' region
```

## Attributes — add HTML attributes to the section

`attributes` maps a chosen class to arbitrary attributes on the **section** wrapper:

```yaml
    style:
      options:
        'bg-wave': 'Wave background'
      attributes:
        'bg-wave':
          data-some-attribute: foo   # section gets data-some-attribute="foo"
```

## Using a custom layout class

If your layout needs its own plugin class, extend `ClassyLayout` yourself and set
`class: '\Drupal\your_module\YourClassyLayout'` in the layout definition (the auto-swap only
replaces layouts still using core `LayoutDefault`).

After editing `*.layouts.yml`, rebuild caches (`drush cr`) so the new definition/plugin class is
picked up.
