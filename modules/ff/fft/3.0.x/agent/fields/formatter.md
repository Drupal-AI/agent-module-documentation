<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Formatter Template" field formatter (`fft_formatter`)

## Install & enable

```bash
composer require drupal/fft
drush en fft -y
```

No external dependencies. Then set the template directory at `/admin/config/content/fft` (see
[../config/settings.md](../config/settings.md)) — the shipped default `sites/all/formatter` does
not exist on Drupal 8+.

## Which fields it applies to

The plugin is `FFTFormatter` (`src/Plugin/Field/FieldFormatter/FFTFormatter.php`), id
**`fft_formatter`**, label *"Formatter Template"*. Its `@FieldFormatter` annotation lists only
`text`, `text_long`, `text_with_summary`, **but** `fft_field_formatter_info_alter()` in
`fft.module` overwrites `$info['fft_formatter']['field_types']` with **every field type on the
site** (`fft_get_field_types()`), so the formatter is offered on any field.

Select it per view-display: *Structure → (bundle) → Manage display* → set a field's format to
**Formatter Template** → click the gear.

## Formatter settings (`defaultSettings()`)

| Key | Default | Meaning |
|---|---|---|
| `template` | `''` | The chosen template file, relative to the storage dir (e.g. `fft-inline-tags.html.twig`). Options come from `fft_get_templates('fft')`. |
| `image_style_1` | `''` | (Image fields only) an image style whose derivative URL/dimensions are exposed to the template as `path_1`/`width_1`/`height_1`. |
| `image_style_2` | `''` | (Image fields only) second image style → `path_2`/`width_2`/`height_2`. |
| `settings` | `''` | "Settings Extras" textarea, one `key = value` per line (array syntax `key[] = v` / `key[name] = v` supported), parsed by `drupal_parse_info_format()`. |
| `reset` | `1` | When `'1'`, `view()` unsets `#theme` so Drupal's default field wrapper markup is removed and the template controls all output. |
| `isNew` | `1` | Internal flag used by the settings-form JS to decide whether to preload the template's default `{# Settings: … #}` into the textarea. |

`settingsSummary()` shows *"Formatter Template: <name>"* on the Manage-display summary line. The
settings form attaches library `fft/backend` (`js/fft.js`) and passes each template's default
settings in `drupalSettings.fft`; selecting a template in the dropdown copies its defaults into the
Settings Extras field.

## How templates are discovered

`fft_get_templates($start_with = 'fft')` in `fft.module`:

1. reads `fft_storage_dir()` (config `fft.settings:fft_storage_dir`); if it does not exist, logs
   *"Template directory @dir does not exist"* and returns empty;
2. scans it with `file_system->scanDirectory($dir, '/^.*\.html\.twig$/')`;
3. keeps only files whose contents match `/{#.?Template Name:(.*?)#}/s` **and** whose path starts
   with `$start_with` (`fft` here; `views` for the vff submodule);
4. records the human name from the header, and an optional `{# Settings: … #}` block as the
   template's default settings.

A file that lacks the header, or whose name does not start with the prefix, is ignored — so
appearing in the directory is not enough; the template must be authored with the header and then
selected on a formatter.

## What the template receives

`fft_field_formatter_render($entity, $field_type, $items, $settings)` builds `data` by field type:

- **image**: for each item an array with `uri`, `path` (absolute URL), `width`, `height`, `alt`,
  plus `path_1/width_1/height_1` and `path_2/width_2/height_2` when `image_style_1/2` are set
  (derivatives built via `ImageStyle::load()->createDerivative()` / `transformDimensions()`).
- **text / text_long / text_with_summary**: `{ text: <processed>, summary: <summary_processed> }`.
- **entity_reference / entity_reference_revisions**: the referenced entities themselves
  (`getEntitiesToView()` is used in `viewElements()`, so entity access is honored).
- **file**: currently produces no data (empty `data` → nothing rendered).
- **any other type**: `$item->getValue()` per item.

The template is rendered with variables `data`, `entity`, and `settings` (the parsed Settings
Extras). Output is placed in an `#type => inline_template` element with template `{{ content|raw }}`
and any `#attached` js/css.

## Settings Extras: assets and path tokens

Keys named `js` or `css` in the Settings Extras are treated as asset lists and attached to the
render array. String values are run through **`fft_realpath()`**, which expands tokens:

- `{fft}` → the directory of the current template file;
- `{theme}` → the active theme's path;
- `{module-<name>}` → that module's path; `{theme-<name>}` → that theme's path.

Example Settings Extras:

```
css[] = {fft}/slider.css
js[] = {module-fft}/js/init.js
delimiter = >>
```

`{{ settings.delimiter }}` is then available in the template.

## The `fft.preprocess` event

`fft_render()` dispatches a `PreProcess` event (`src/Event/PreProcess.php`, constant
`fft.preprocess`) before rendering. Subscribers receive `$event->variables` **by reference**
(mutable) and can read `$event->getTemplate()` (the basename). Use it to inject or alter variables
for all FFT renders.

## Example template

```twig
{# Template Name: Inline Tags #}
{# Settings:
delimiter = |
#}
{% set values = [] %}
{% for item in data %}
  {% set term = link(item.name.value, 'internal:/taxonomy/term/' ~ item.tid.value)|render %}
  {% set values = values|merge([term]) %}
{% endfor %}
<div>{{ values | join(' ' ~ settings.delimiter ~ ' ') | raw }}</div>
```

Place it in the storage directory as `fft-inline-tags.html.twig`, rebuild cache, then select
*Inline Tags* on a reference field's formatter.

## Gotchas

- Rendering goes through the legacy procedural `twig_render_template()` and `global $theme_engine`;
  these are undefined outside a themed web request, so FFT rendering throws in CLI contexts.
- `fft_render()` returns `""` when the resolved template file does not exist (`is_file()` guard) —
  a mistyped template name renders empty, no error.
- After adding a template or changing settings, rebuild the cache for the option list to refresh.
- No config schema exists for the formatter settings, so strict config-schema tooling may flag the
  view-display config; it still saves and works.
