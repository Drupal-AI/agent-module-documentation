# SpamSpan API

Ways to obfuscate email addresses from code, templates, and other plugins.

## The `spamspan` service

Service id `spamspan` (`Drupal\spamspan\SpamspanService`). One method:

```php
/** @var \Drupal\spamspan\SpamspanService $spamspan */
$spamspan = \Drupal::service('spamspan');
// $settings overrides the filter_spamspan default settings (see configure doc).
$html = $spamspan->spamspan($text, array $settings = []);
```

It builds a `filter_spamspan` plugin instance via the filter plugin manager, merges
`$settings` over the plugin defaults, runs `$text` through it, and returns the processed
HTML string. Verified output for `"Contact me@example.com today"`:

```html
Contact <span class="spamspan"><span class="u">me</span> [at] <span class="d">example.com</span></span> today
```

Note: the service returns markup but does **not** attach the JS library — attach
`spamspan/obfuscate` yourself (`'#attached' => ['library' => ['spamspan/obfuscate']]`) so
the browser reassembles the links.

## Twig filter `|spamspan`

Registered by `SpamspanExtension` (service `spamspan.twig.spamspan_filter`). Use in any
template:

```twig
{{ content_with_emails|spamspan }}
```

It calls the service, runs the result through `Xss::filter(..., SpamspanInterface::ALLOWED_HTML)`,
attaches `spamspan/obfuscate` automatically, and is marked `is_safe: html`.

## Interface, traits, constants

`Drupal\spamspan\SpamspanInterface` declares the low-level obfuscation methods
(implemented via `SpamspanTrait` / `SpamspanDomTrait` on the filter plugin):

- `replaceBareEmailAddresses($text, &$altered = NULL)` — bare addresses (`PATTERN_EMAIL_BARE`).
- `replaceEmailAddressesWithOptions($text, &$altered = NULL)` — `addr[url|text]` form syntax.
- `replaceMailtoLinks($text, &$altered = NULL)` — existing `<a href="mailto:">` links.

Useful constants on the interface: `PATTERN_MAIN`, `PATTERN_EMAIL_BARE`,
`PATTERN_EMAIL_WITH_OPTIONS`, `PATTERN_MAILTO`, and `ALLOWED_HTML` (the tag allowlist used
by the Twig filter). `SpamspanSettingsFormTrait` provides the shared `settingsForm()` used
by both the filter plugin and the `email_spamspan` formatter.

## Reusing the plugins

- Filter plugin id: `filter_spamspan` (`Drupal\spamspan\Plugin\Filter\FilterSpamspan`).
- Field formatter id: `email_spamspan` (`...Plugin\Field\FieldFormatter\EmailSpamspanFormatter`)
  for `email` field types; `defaultSettings()` pulls the filter plugin's default settings.

## Libraries (attach when rendering obfuscated markup)

| Library | Contents | When |
|---|---|---|
| `spamspan/obfuscate` | `js/spamspan.js` (deps: `core/drupal`, `core/jquery`) | always, to rebuild links client-side |
| `spamspan/atsign` | `css/spamspan.atsign.css` | only when `spamspan_use_graphic` is on |

## Theme hook

`spamspan_at_sign` (template `spamspan-at-sign.html.twig`) renders the graphic "@"
replacement; variables `path` (defaults to the module's `image.gif`) and `settings`.
