<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Colorizer Classes (colorizer_classes) — agent index

A tiny theming helper that turns a stored value (typically a color) into a CSS **class name** in
Twig markup, via a single Twig filter `colorizer`. Built to pair with modules like **Color Field**
so an editor picks a color visually while the front end outputs a predictable class (e.g. `#FFFFFF`
→ `color-white`) that theme CSS targets. Package `Other`. Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Installed **1.0.1** (version dir `1.0.x`). No module or library dependencies.

## What it provides (from source)

- **Twig filter `colorizer`** (`src/ColorizerClassesTwigExtension.php`, registered as the
  `twig.extension`-tagged service `colorizer_classes.twig_extension` in
  `colorizer_classes.services.yml`). Applied as `{{ value|colorizer }}`. Behavior: only acts on a
  string input and when `color_mapping` config is non-null; it first strips **all spaces and
  newlines** from the input, then splits the mapping on `PHP_EOL`, splits each line on `|`, and does
  a **case-insensitive** compare of the input against the left side (`KEY`). On a match it returns
  the right side (`VALUE`, the class). With **no match it returns the original input unchanged**.
- **Settings form** `Drupal\colorizer_classes\Form\SettingsForm` (a `ConfigFormBase`) at route
  `colorizer_classes.settings` → `/admin/config/media/colorizer_classes`, guarded by core permission
  **`administer site configuration`**. One field: a `color_mapping` textarea holding `KEY|VALUE`
  lines (one per line), default `#000000|color-black` / `#FFFFFF|color-white`. Linked in the admin
  menu under *Configuration › Media* (`colorizer_classes.links.menu.yml`, parent
  `system.admin_config_media`). Note the `.info.yml` `configure:` key points here.
- **Config**: single config object `colorizer_classes.settings` with one `text` key `color_mapping`
  (`config/schema/colorizer_classes.schema.yml`).

## What it does NOT have

No custom permissions (reuses core `administer site configuration`), no Drush commands, no plugin
types, no controllers/REST routes beyond the settings form, no install/update hooks, no `.module`
file, no libraries/CSS/JS, no templates. It writes nothing to the filesystem; the mapping lives only
in config. The whole module is the two PHP classes above.

## Usage

```twig
<div class="{{ '#FFFFFF'|colorizer }}"> {# → class="color-white" #}
```

Typically fed a value from a color field on the content so the rendered element carries the mapped
class. You supply the CSS rules for those class names in your theme. Output lands in a normal Twig
context, so class values are auto-escaped at render like any `{{ }}` print.
