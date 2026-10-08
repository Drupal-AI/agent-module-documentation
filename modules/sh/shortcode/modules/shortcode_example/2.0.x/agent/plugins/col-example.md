<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `col` plugin, walked as a template

`src/Plugin/Shortcode/BootstrapColumnShortcode.php` — the whole module — is deliberately the
simplest complete `@Shortcode` plugin. Read it top to bottom as a copy-paste starting point.

```php
namespace Drupal\shortcode_example\Plugin\Shortcode;

use Drupal\Core\Language\Language;
use Drupal\shortcode\Plugin\ShortcodeBase;

/**
 * @Shortcode(
 *   id = "col",
 *   title = @Translation("Bootstrap column"),
 *   description = @Translation("Builds a div with bootstrap column size classes")
 * )
 */
class BootstrapColumnShortcode extends ShortcodeBase {

  public function process(array $attributes, $text, $langcode = Language::LANGCODE_NOT_SPECIFIED) {
    $attributes = $this->getAttributes([
      'class' => '', 'xs' => '', 'sm' => '', 'md' => '', 'lg' => '',
    ], $attributes);

    $class = $attributes['class'];
    foreach (['xs', 'sm', 'md', 'lg'] as $size) {
      if ($attributes[$size]) {
        $class = $this->addClass($class, 'col-' . $size . '-' . $attributes[$size]);
      }
    }
    return '<div class="' . $class . '">' . $text . '</div>';
  }

  public function tips($long = FALSE) {
    // ... short vs. $long variants, see source.
  }

}
```

## What to notice, line by line

1. **Annotation** — only the required/common fields are set: `id`, `title`, `description`. No
   `token` (so the parsed tag is `[col]`, the lowercased id), no `weight`/`status`/`settings`
   overrides — showing those are genuinely optional.
2. **`process(array $attributes, $text, $langcode)`** is the only method a minimal plugin must
   implement (the interface also requires `tips()`, but `ShortcodeBase::tips()` already returns
   `''` by default — this plugin overrides it only to be a better citizen in the filter tips UI).
3. **`getAttributes($defaults, $attributes)`** — the standard pattern for handling shortcode
   attributes: pass the full set of attribute names your plugin understands with their
   defaults; anything the user typed that isn't in `$defaults` is silently dropped, and
   anything in `$defaults` not typed by the user falls back to its default. This is what every
   `shortcode_basic_tags` plugin does too.
4. **`addClass($classes, $newClass)`** — accumulates CSS classes safely (HTML-escapes, dedupes)
   instead of hand-concatenating strings. Called once per size attribute present.
5. **Return value** — `process()` returns a plain HTML string built by hand. Plugins with more
   complex markup (see `shortcode_basic_tags`) instead return a render array via
   `$this->render($build)` (a `#theme` element rendered in isolation); either is valid — return
   any string.
6. **No `$langcode` use, no injected services, no `settingsForm()` override** — this plugin
   needs none of `ShortcodeBase`'s constructor-injected `renderer`, entity loading, or
   media/image helpers, so it uses none of them. Add a constructor + `create()` (see
   `shortcode_basic_tags`'s `BlockShortcode` for the pattern) only when your plugin needs a
   service.

## Using it

Enable the `shortcode` filter plus the `col` shortcode on a text format (see the parent
module's `enable-filter.md`), then in body text:

```
[col md="6"]Left column[/col][col md="6" class="text-muted"]Right column[/col]
```

renders:

```html
<div class="col-md-6">Left column</div><div class="col-md-6 text-muted">Right column</div>
```

## Extending this pattern for a real plugin

- Need a config-driven default? Add a `defaultConfiguration()` override (see `ShortcodeBase`)
  and a `settingsForm()`.
- Need a service (entity storage, renderer, etc.)? Add a constructor + static `create()` — see
  `shortcode_basic_tags`'s `BlockShortcode::create()` for the exact shape (it injects
  `renderer` and `entity_type.manager`).
- Need themeable, overridable markup? Register a `hook_theme()` element and return
  `$this->render($build)` instead of a hand-built string — see any `shortcode_basic_tags`
  plugin (e.g. `QuoteShortcode`).
