# The jQuery UI filter — enabling it and the authoring markup

Plugin: `Drupal\jquery_ui_filter\Plugin\Filter\jQueryUiFilter`
(`@Filter id = "jquery_ui_filter"`, title *"jQuery UI accordion and tabs widgets"*,
type `TYPE_TRANSFORM_IRREVERSIBLE`). It is a core Filter plugin — enable it on the text format(s)
whose fields should support the widgets. Nothing renders as a widget unless the field's text format
has this filter turned on.

## Enable on a text format

UI: *Configuration → Content authoring → Text formats and editors* (`/admin/config/content/formats`),
edit a format, check **jQuery UI accordion and tabs widgets**, save. Ordering matters: the module's
README requires this filter to run **after** *Correct faulty and chopped off HTML* (`filter_htmlcorrector`).
If the format uses *Limit allowed HTML tags* (`filter_html`), the `<div>` element and the
`data-ui-*` attributes it emits must be allowed there, or they will be stripped.

Enable via PHP (also settable with `drush php:eval`):

```php
$format = \Drupal\filter\Entity\FilterFormat::load('full_html');
$format->setFilterConfig('jquery_ui_filter', ['status' => TRUE]);
$format->save();
```

The plugin has no per-format settings of its own — `settingsForm()` only prints a link to the global
settings form (see [settings.md](settings.md)).

## Authoring markup (what editors write)

Wrap heading-structured HTML in a token pair. Each `<h3>` (or the configured `headerTag`) becomes a
panel/tab; the content after it, up to the next header, is that panel's body.

```html
<p>[accordion collapsed]</p>
  <h3>Section I</h3>
  <p>…</p>
  <h3>Section II</h3>
  <p>…</p>
<p>[/accordion]</p>
```

- `[accordion]` … `[/accordion]` → jQuery UI accordion. `[accordion collapsed]` starts fully closed
  (JS expands `collapsed` into jQuery UI's `collapsible: true` + `active: false`).
- `[tabs]` … `[/tabs]` → jQuery UI tabs.
- Options are written as HTML-style attributes on the opening token:
  `[tabs headerTag="h2" scrollTo="false"]`.

### Options

Any [jQuery UI accordion](https://api.jqueryui.com/accordion/) or
[tabs](https://api.jqueryui.com/tabs/) option is accepted; these are the module's own extras
(defaults come from `jquery_ui_filter.settings`, overridable per token):

| Option | Default | Meaning |
|---|---|---|
| `headerTag` | `h3` | Heading tag that delimits panels/tabs. |
| `mediaType` | `screen` | `screen`, `all`, or `print`. `screen` shows the widget only in the browser and falls back to plain markup when printed; `all` keeps the widget when printing. |
| `scrollTo` | `true` | On load, scroll to the widget bookmarked by the URL fragment. |
| `scrollToDuration` | `500` | Scroll animation speed (ms). |
| `scrollToOffset` | `auto` | Pixels from the top to stop at; `auto` uses the body's top margin+padding. |
| `collapsed` | — | Accordion only: start closed (all panels collapsed). |

JSON values are supported and are `JSON.parse`d client-side (single quotes may wrap the JSON so it
survives the double-quoted attribute). Example — sliding tabs:

```html
[tabs show='{"effect": "slideDown", "duration": 1000}' hide='{"effect": "slideUp", "duration": 1000}']
```

Invalid JSON is logged to the browser console and left as a string.

## How the filter transforms the markup (`process()`)

For each widget name (`accordion`, `tabs`) present in the text:

1. Unwraps `<p>`/`<div>` tags surrounding a token
   (`preg_replace('#<(p|div)[^>]*>\s*(\[/?<name>[^]]*\])\s*</\1>#', '\2', …)`).
2. Rewrites each opening `[<name> …]` into an opening `<div data-ui-role="<name>" data-ui-…>` using
   `Drupal\Core\Template\Attribute`. Options are read by
   `parseOptions()`, which decodes entities, converts camelCase → hyphen-delimited (`scrollTo` →
   `scroll-to`, HTML5-safe), and parses the string as DOM attributes via `Html::load()`. An empty
   attribute (e.g. `collapsed`) becomes the string `"true"`.
3. Rewrites each `[/<name>]` into `</div>`.

If any widget token was found, it attaches the `jquery_ui_filter/jquery_ui_filter` library and the
whole `jquery_ui_filter.settings` config as `drupalSettings.jquery_ui_filter`, and adds the config
object as a cacheable dependency. The stored text is never mutated — this is a render-time transform.

## Runtime (JS: `js/jquery_ui_filter.js`)

`Drupal.behaviors.jQueryUiFilter` finds `[data-ui-role]` elements (nested `accordion > tabs` first),
reads options back from the `data-ui-*` attributes (hyphen → camelCase; JSON-looking values are
`JSON.parse`d), groups children by the header tag into panels, and calls `.accordion(options)` /
`.tabs(options)`. It also:

- Deep-links: on load and on `hashchange`, activates the accordion panel / tab matching the URL
  fragment and (when `scrollTo`) scrolls to it.
- Honors `mediaType`: for `screen`/`print` it keeps a clone of the original markup and toggles the
  widget vs. source with an injected `@media` `<style>` rule, so print/other media get plain HTML.
- Skips initialization when the wrapper contains no `headerTag` elements.

## `tips()` help text

The filter's `tips()` returns short and long help describing the `[accordion]`/`[tabs]` tokens and
the active `headerTag`; this shows under the text-format's editing area.
