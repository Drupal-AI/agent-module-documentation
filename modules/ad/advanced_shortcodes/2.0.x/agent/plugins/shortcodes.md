<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The advanced shortcodes (plugins, attributes, templates)

## Install & enable

```bash
composer require drupal/advanced_shortcodes
drush en advanced_shortcodes -y   # pulls in drupal/shortcode
drush cr
```

The only dependency is the contrib **`shortcode`** module (`info.yml`:
`dependencies: [shortcode:shortcode]`), which supplies the `shortcode` filter plugin, the
`ShortcodeBase` plugin base, and the `plugin.manager.shortcode` / `shortcode` services. Advanced
Shortcodes adds no routes, permissions, services, config objects or config schema of its own.

## Turn the shortcodes on for a text format

Shortcodes only expand where the Shortcode **filter** is enabled:

1. Configuration → Content authoring → **Text formats and editors** → edit a format (e.g. *Full HTML*).
2. Enable the **"Shortcodes"** filter (plugin id `shortcode`, `Drupal\shortcode\Plugin\Filter\Shortcode`).
3. In that filter's settings, tick the individual advanced shortcodes to allow (each is grouped
   under provider *advanced_shortcodes*). Only ticked shortcodes are processed for that format.
4. Save and `drush cr`.

Per-shortcode syntax reminders appear in the format's filter tips (each plugin's `tips()`).

## How a shortcode is processed

Each plugin extends `Drupal\shortcode\Plugin\ShortcodeBase` and implements
`process($attributes, $text, $langcode)`, where `$attributes` is the parsed tag attribute list and
`$text` is the inner body (between `[tag]` and `[/tag]`). The method builds a `#theme` render array
and returns `ShortcodeBase::render()`, i.e. `renderer->renderInIsolation($elements)` (rendered in
isolation so shortcode cache metadata does not bubble to the host entity). The theme hooks are
registered in `advanced_shortcodes_theme()` (in `advanced_shortcodes.module`) and each maps to a
`templates/shortcode-*.html.twig` template. Tags may be nested — the `ShortcodeService::process()`
loop parses `[...]` chunks recursively.

## The nine plugins

### `alerts` — `AlertsShortcode.php` → `shortcode-alerts.html.twig`
`[alerts type="info" class="..."]message[/alerts]`. Passes `#type => $attributes['type']` and the
body as `#message`. Renders `<div ...><div class="alert alert-{type}">message</div></div>`. `type`
accepts a bootstrap contextual name (`success`/`info`/`warning`/`danger`); the tips also document
numeric aliases 1-success / 2-info / 3-warning / 4-danger. (Note: `type` has no default, so omitting
it emits `alert-` and a PHP notice.)

### `column` — `ColumnShortcode.php` → `shortcode-column.html.twig`
`[column cols="6" xs="12" sm="6" md="6" lg="6" begin="1" end="1" class="..."]body[/column]`.
Uses `getAttributes()` to whitelist `class,cols,begin,end,xs,sm,md,lg`. When `cols` is numeric it
fills `sm/md/lg` from `cols` and `xs` from `12`, then builds `col-{size}-{n}` classes via
`addClass()`. `begin` emits an opening `<div class="row">`; `end` emits a closing `</div>` around the
column, so a run of columns can share one row.

### `row` — `RowShortcode.php` → `shortcode-row.html.twig`
`[row class="..."]columns[/row]`. Forces `class = 'row'` (any supplied class is overwritten) and
wraps the body in `<div class="row">...</div>`.

### `accordions` — `AccordionsShortcode.php` → `shortcode-accordions.html.twig`
`[accordions class="..."]...[/accordions]`. Container for `[accordion]` items. Adds
`accordion accordion-tab` classes and a `uniqid()` id, wrapping the body in a `<div>`.

### `accordion` — `AccordionShortcode.php` → `shortcode-accordion.html.twig`
`[accordion title="..." icon="fa fa-star" class="..."]panel body[/accordion]`. Builds an `icon`
markup fragment from the `icon` attribute, adds `accordion-item advanced-shortcodes-accordion`
classes, generates a `uniqid()` id, and renders a checkbox-toggled panel (`<input type="checkbox">`
+ `<label>` + content div). Meant to sit inside `[accordions]`. The bundled
`js/accordion-a11y.js` adds keyboard support.

### `icon` — `IconShortcode.php` → `shortcode-icon.html.twig`
`[icon class="fa fa-star"]label[/icon]`. Renders `<i {attributes}>label</i>` — an inline icon
element carrying the supplied `class`.

### `jumbotron` — `JumbotronShortcode.php` → `shortcode-jumbotron.html.twig`
`[jumbotron title="Welcome" class="..."]text[/jumbotron]`. Renders a `.jumbotron` block with an
`<h1>` title and `<p>` text. (`title` has no default — omit it and a PHP notice is raised.)

### `progress` — `ProgressShortcode.php` → `shortcode-progress.html.twig`
`[progress percent="50" class="..."][/progress]`. `percent` defaults to `0`; renders a Bootstrap
`.progress` bar whose width and ARIA values come from `percent`.

### `hr` — `HrShortcode.php` → `shortcode-hr.html.twig`
`[hr class="..."][/hr]`. Renders `<div ...><hr class="mt-0 mb-0"></div>`.

## Styling & assets

`advanced_shortcodes.libraries.yml` defines `bootstrap` (`css/fix.css`, `css/pure_css.css`) and
`accordion-a11y` (`js/accordion-a11y.js`). `advanced_shortcodes_page_attachments()` attaches both on
every page whose active theme is **not** the configured admin theme (`system.theme` `admin`), so the
shortcode CSS/JS load on the front end only. If your theme already ships Bootstrap you may not need
the bundled CSS.

## Notes

- Shortcodes only render inside fields whose text format has the Shortcode filter enabled **and** the
  specific shortcode ticked; elsewhere the literal `[tag]` text is left untouched.
- `alerts`, `jumbotron` read `$attributes['type']` / `$attributes['title']` without a default, so a
  tag missing that attribute raises a PHP notice (harmless but log-noisy).
- No configuration is stored by this module; there is nothing to export beyond the host text-format
  config (`filter.format.*`).
