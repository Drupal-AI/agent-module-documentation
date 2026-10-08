<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `htmlspecialchars_decode` Twig filter

The module registers exactly one filter. Use it in any Twig template:

```twig
{{ value|htmlspecialchars_decode }}
```

It runs PHP's `htmlspecialchars_decode()` on the value cast to a string, converting entity
sequences back to their characters — `&amp;` → `&`, `&lt;` → `<`, `&gt;` → `>`,
`&quot;` → `"`, `&#039;`/`&apos;` → `'`.

## Typical use

A value has been entity-encoded upstream (a migration, a token, an external feed, an API
payload) and shows the literal entities on the page. Decode it in the template:

```twig
{# title arrives as "Ben &amp; Jerry&#039;s" #}
<h2>{{ node.title.value|htmlspecialchars_decode }}</h2>
```

## Behavior and escaping

The filter is declared with **no `is_safe` flag** (verified at runtime: `getSafe()` and
`getPreservesSafety()` both return an empty array). It therefore returns an ordinary string,
not markup Twig treats as pre-sanitized. In Drupal's auto-escaped Twig environment the decoded
string is escaped again on print exactly like any other variable — so the decode is a
transformation of the string's value, and Twig owns the final output encoding. If the intended
result is raw markup, that requires the standard Twig `|raw` filter (or another explicitly
safe context), which is a separate, deliberate choice on the developer's part and unrelated to
this module.

Practical consequence: `{{ value|htmlspecialchars_decode }}` is most useful when the decoded
string is consumed by something other than direct auto-escaped printing — for example fed into
another filter, sliced/split, compared, or emitted into a context the developer has chosen to
mark safe.

## Why the module exists

Under Drupal 8, `value|convert_encoding('UTF-8', 'HTML-ENTITIES')` decoded entities because
Twig used `mbstring`. Drupal 9 moved Twig's `convert_encoding` to `iconv`, which rejects the
`HTML-ENTITIES` charset and errors. This filter is the one-step replacement across Drupal 9–11.

## Rolling your own instead

The module is trivially small; the same effect is a few lines in any module's own Twig
extension:

```php
namespace Drupal\my_module;

use Twig\Extension\AbstractExtension;
use Twig\TwigFilter;

class MyTwig extends AbstractExtension {
  public function getFilters() {
    return [
      new TwigFilter('htmlspecialchars_decode', fn($text) => htmlspecialchars_decode((string) $text)),
    ];
  }
}
```

Tag the class `twig.extension` in your `*.services.yml`. Installing this module saves writing
that. (Adding `'is_safe' => ['html']` to the `TwigFilter` options would make Twig skip
re-escaping the result — this module deliberately does not, leaving output encoding to Twig.)
