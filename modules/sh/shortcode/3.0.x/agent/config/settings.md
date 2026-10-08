<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling shortcodes on a text format

## Install & enable

```bash
composer require drupal/shortcode
drush en shortcode -y
# optional: bundled starter tags and/or the reference plugin
drush en shortcode_basic_tags -y
drush en shortcode_example -y
```

Only dependency is core **`filter`**. No external libraries, no Composer requirements beyond core.
The base module has **no permissions, no routes, no configure form of its own** (`configure: null`).

## Turn it on per text format

Shortcode is a **filter**, configured on each text format at
**`admin/config/content/formats`** → edit a format → *Enabled filters*:

1. Enable **Shortcodes** (`shortcode`). Without this the `[tag]` syntax is inert.
2. On a **WYSIWYG** format (CKEditor etc.) also enable **Shortcodes - HTML corrector**
   (`shortcode_corrector`) and order it **before** *Shortcodes* in *Filter processing order*.
   The corrector removes stray `<p>`/`<br>` the editor wraps around brackets; skip it on
   plain-text formats.
3. If `shortcode_basic_tags` (or any tag-providing module) is installed, the *Shortcodes* filter
   settings expose a **checkbox per tag** to enable/disable each tag on this format.

Consider filter **ordering** relative to core's *Limit allowed HTML tags* / *Convert line breaks*:
the Shortcodes filter emits markup, so its position in the pipeline affects what downstream
filters see. Shortcodes is a `TYPE_TRANSFORM_IRREVERSIBLE` filter.

## The filter settings form (`Shortcode::settingsForm()`)

`src/Plugin/Filter/Shortcode.php` builds the per-format form:

- Calls `ShortcodeService::loadShortcodePlugins()` and **groups tags by provider module**, adding
  an `<h4 class="shortcodeSectionHeader">Shortcodes provided by @provider</h4>` per group.
- Sorts each group by the plugin `weight` (descending) and renders one **checkbox** per tag,
  titled *"Enable %name shortcode"*, `#default_value` = existing setting or `TRUE`.
- `ShortcodeCorrector::settingsForm()` is empty — the corrector has no options.

## Stored configuration & schema

There is **no config object** owned by the module; settings live inside each text format's filter
configuration (`filter.format.<id>.filters.shortcode.settings`). The schema is
`config/schema/shortcode.schema.yml`:

```yaml
filter_settings.shortcode:
  type: sequence
  sequence:
    type: boolean
```

i.e. a map of `<plugin_id> => TRUE|FALSE` — the set of tags enabled on that format. Example
(exported filter format fragment):

```yaml
filters:
  shortcode:
    id: shortcode
    status: true
    weight: 10
    settings:
      quote: true
      img: true
      button: false
```

`ShortcodeService::getShortcodePlugins($filter)` reads this settings map to decide which tags are
active for the format; a tag absent or `false` is not expanded.

## Migration note

`src/Hook/ShortcodeHooks.php` (`hook_migration_plugins_alter`) rewrites the D7→D8+ `d7_filter_format`
migration so a Drupal 7 `shortcode_text_corrector` filter maps to the current `shortcode_corrector`
plugin id.
