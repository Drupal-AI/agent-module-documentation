<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `real_content` test and filter

Provided by `Drupal\twig_real_content\TwigRealContentTwigExtension` (service
`twig_real_content.twig_extension`, tag `twig.extension`). Same logic exposed two ways:

- **Test:** `... is real_content` → boolean.
- **Filter:** `...|real_content` → the meaningful string (or `''`).

## The render-first requirement (important)

Both callables expect the value to be **already rendered** — a string or an object
implementing `MarkupInterface`. If you pass a raw render array (as `page.sidebar` is inside
`page.html.twig`), the module:

- returns empty / FALSE **only** if the array is empty (`Element::isEmpty()`), otherwise
- throws `Drupal\twig_real_content\Exceptions\TwigRealContentException`
  ("expects rendered strings as value … Did you forget to |render / capture the twig variable before?").

So render first:

```twig
{# CORRECT: render the region, then test it #}
{% if page.sidebar_first|render is real_content %}
  <aside class="sidebar">{{ page.sidebar_first }}</aside>
{% endif %}
```

`NULL` is treated as `''` (empty, no exception).

## What counts as "content"

The value is run through `strip_tags($value, $allowedTags)` then trimmed. Text always counts.
Tags are removed **except** this allowlist of self-meaningful/embed tags, which keep a value
non-empty even with no text:

```
<drupal-render-placeholder> <embed> <hr> <iframe> <img> <input>
<link> <object> <script> <source> <style> <svg> <video>
```

Consequences:

- `<div class="region"> \n </div>` → filter returns `''`, test returns **FALSE** (div stripped, only whitespace left).
- `<div><img src="hero.jpg"></div>` → test returns **TRUE** (img is allowlisted).
- `<p>Hello</p>` → filter returns `Hello`, test returns **TRUE** (p stripped, text remains).
- A region rendered as a `<drupal-render-placeholder>` (lazy builder) counts as **TRUE**.

## Filter vs test

```twig
{# Toggle a CSS class based on real content #}
<body class="{{ page.sidebar_first|render is real_content ? 'has-sidebar' : 'no-sidebar' }}">

{# Output only the meaningful remainder #}
{{ my_markup|real_content }}
```

## Capturing markup to test

Works on any captured markup, not just regions:

```twig
{% set teaser %}{{ content.field_summary }}{% endset %}
{% if teaser is real_content %}<div class="teaser">{{ teaser }}</div>{% endif %}
```

## Invoking from PHP (rare)

The extension has no constructor dependencies, so it can be exercised directly, e.g. in tests
or `drush php:eval`:

```php
$ext = new \Drupal\twig_real_content\TwigRealContentTwigExtension();
$filter = $ext->getFilters()[0]->getCallable();   // |real_content
$test   = $ext->getTests()[0]->getCallable();     // is real_content
$test('<div> </div>');                             // false
$test('<div><img src="a"></div>');                 // true
$filter('<p>Hi</p>');                              // 'Hi'
```
