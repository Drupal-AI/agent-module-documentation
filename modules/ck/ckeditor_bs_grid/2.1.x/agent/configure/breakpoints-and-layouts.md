<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site-wide breakpoints and layouts (`ckeditor_bs_grid.settings`)

One config object, shipped in `config/install`, edited at
**`/admin/config/content/ckeditor_bs_grid`** (route `ckeditor_bs_grid.settings`, permission
`administer ckeditor_bs_grid`, menu link "CKEditor BS Grid" under *Configuration › Content
authoring*).

## Shape

```yaml
ckeditor_bs_grid.settings:
  breakpoints:
    xs:
      label: 'Default (Extra Small)'
      prefix: none                # xs has no Bootstrap infix -> col-6
      columns:
        1:
          layouts:
            option_0: { label: 'Equal Width', settings: { col-1: equal } }
            option_1: { label: Auto,          settings: { col-1: auto } }
            option_2: { label: 'Full Width',  settings: { col-1: '12' } }
        2:
          layouts:
            option_0: { label: 'Equal Width', settings: { col-1: equal, col-2: equal } }
            option_2: { label: '25% / 75%',   settings: { col-1: '3', col-2: '9' } }
            …
        …up to 12
    sm:  { label: Small,             prefix: sm,  columns: … }
    md:  { label: Medium,            prefix: md,  columns: … }
    lg:  { label: Large,             prefix: lg,  columns: … }
    xl:  { label: 'Extra Large',      prefix: xl,  columns: … }
    xxl: { label: 'Extra Extra Large', prefix: xxl, columns: … }
```

- Six breakpoints, each with `columns` keyed **1–12**; each column count has a `layouts` map of
  `option_N` entries.
- A layout's `settings` map is `col-<n>` → a Bootstrap width token: a number `1`–`12`, or the
  special values `equal` (plain `col`) and `auto` (`col-auto`).
- `prefix` is what goes between `col` and the width (`none` for `xs`), e.g. prefix `md` +
  width `6` → `col-md-6`.
- The dialog builds each breakpoint's radio options from
  `breakpoints[<bp>].columns[<num_cols>].layouts`, keyed by `implode('_', $layout['settings'])`,
  and appends a `none` ("None (advanced)") option at the bottom. Per column count the admin form
  also stores `default_layout` (`none` or `order`, i.e. "By Sort Order").

Schema (`config/schema/ckeditor_bs_grid.schema.yml`) types `breakpoints` as a sequence of
mappings with `label`, `prefix` and a free-form `columns` sequence.

## Reading and editing it

```bash
drush cget ckeditor_bs_grid.settings breakpoints.md.label
drush cget ckeditor_bs_grid.settings breakpoints.md.columns.2.layouts
```

```php
$config = \Drupal::configFactory()->getEditable('ckeditor_bs_grid.settings');
$bp = $config->get('breakpoints');
$bp['md']['label'] = 'Tablet';
// add a 20/80 split for 2 columns at md
$bp['md']['columns'][2]['layouts']['option_7'] = [
  'label' => '20% / 80%',
  'settings' => ['col-1' => '2', 'col-2' => '10'],
];
$config->set('breakpoints', $bp)->save();
```

The settings form itself is `Drupal\ckeditor_bs_grid\Form\Settings` (`getEditableConfigNames()`
= `['ckeditor_bs_grid.settings']`, form id `ckeditor_bs_grid.settings`). It renders one
collapsible details element per breakpoint, with the `prefix` field disabled (prefixes are fixed
Bootstrap infixes) and a draggable table of layout options per column count.

## Relationship to the per-format settings

`ckeditor_bs_grid.settings` defines **what layouts exist**; the per-format
`available_breakpoints` / `available_columns` (see
[enable-in-text-format.md](enable-in-text-format.md)) define **which of them an editor may pick**
in a given text format. The plugin's configuration form builds its "Allowed Breakpoints"
checkboxes straight from this config object's labels.
