# Configuration

Layout Options is configured mainly through **YAML files** rather than an admin
form. The setup has three parts: describe your options in a `*.layout_options.yml`
file, make your layouts use the LayoutOptions plugin (directly or via the UI
submodule), and then configure the options on each layout section.

## 1. Write a `[provider].layout_options.yml` file

Any module or theme can provide a `{provider}.layout_options.yml` file in its root
(for example `mytheme.layout_options.yml`). Definitions merge across all providers.
The file has two sections.

### `layout_option_definitions` — the available options

Each entry declares one control: its title, default value, which **option plugin**
renders it, and whether it applies to the whole layout, its regions, or both.

```yaml
layout_option_definitions:
  layout_id:
    title: 'Id attribute'
    description: 'The CSS identifier for this layout item.'
    default: ''
    plugin: layout_options_id            # renders an id field
    layout: true
    regions: true
  layout_bg_color:
    title: 'Background color'
    plugin: layout_options_class_select  # a select of CSS classes
    options:
      bg-info: 'Info'
      bg-primary: 'Primary'
    layout: true
    regions: true
  layout_design_classes:
    title: 'Layout classes'
    plugin: layout_options_class_checkboxes
    options:
      layout--no-spacing: 'No padding/margin'
      layout--full-width-img: 'Full width image'
    layout: true
    regions: true
```

The built‑in option plugins are:

- **`layout_options_id`** — an id attribute field.
- **`layout_options_class_select`** — pick one CSS class from a list.
- **`layout_options_class_radios`** — the same as radios.
- **`layout_options_class_checkboxes`** — toggle several CSS classes on/off.
- **`layout_options_class_string`** — a free‑text custom‑classes field.

Common definition keys: `title`, `description`, `default`, `plugin`, `layout`
(bool), `regions` (bool), `options` (for select/radios/checkboxes), `multi`,
`inline`, `weight`, and `allowed_regions` (to restrict an option to certain
regions).

### `layout_options` — the rules (which options show where)

```yaml
layout_options:
  global:                       # shown on every LayoutOptions layout
    layout_id: {}
    layout_bg_color: {}
  my_layout_2col:               # only this layout id
    layout_bg_color:
      regions: false            # override: only the layout, not its regions
    layout_design_classes:
      title: 'Header classes'   # override the title just here
```

- A **`global`** section applies an option to every layout that uses the plugin.
- A section keyed by a **layout id** adds or overrides options for that layout only.
- A section keyed by a **field name** applies to layouts managed per field (Entity
  Reference Layout).
- An empty `{}` uses the definition as‑is; a map overrides individual keys (title,
  layout, regions, and so on).

## 2. Make your layouts use the plugin

Options only appear on layouts that use the LayoutOptions plugin class. There are
two ways:

- **For layouts you define yourself**, set
  `class: Drupal\layout_options\Plugin\Layout\LayoutOptions` in your
  `*.layouts.yml`.
- **For existing core or contrib layouts**, enable the **layout_options_ui**
  submodule and use its admin form to switch those layouts over to the plugin — no
  need to redefine them.

## 3. Configure options on a section

Once a layout uses the plugin and has options attached, the options appear as form
fields when an editor adds or configures that section in **Layout Builder** (or a
Display Suite layout). The editor picks the classes/id, and Layout Options
validates the entries as proper CSS identifiers and applies them as classes or
attributes on the layout or region wrapper when the page is built.

## Notes

- The base module has no permissions and no Drush commands; its config schema only
  stores the selected option values along with the layout section configuration.
- Because definitions merge across providers, different themes can supply different
  option sets, and keeping them in version‑controlled YAML keeps your layout styling
  decisions out of the database.

Developers can add a custom control by implementing a `LayoutOption` plugin — see
the [`agent/`](../agent/start.md) plugin docs.
