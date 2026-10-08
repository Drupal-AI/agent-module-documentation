<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The two Twig filters

Both are provided by the `RemoveHtmlComments` Twig extension (service
`twig_remove_html_comments.remove_html_comments`). No configuration is needed — enabling the
module registers them globally in Twig.

| Filter | Returns | Method |
|---|---|---|
| `remove_html_comments` | render array `['#markup' => <cleaned>]` | `removeHtmlCommentsAsRenderArray()` |
| `remove_html_comments_as_string` | plain `string` | `removeHtmlCommentsFromString()` |

## Usage in a template

```twig
{# Print cleaned output as markup (render array). #}
{{ content.field_my_field|render|remove_html_comments }}

{# Get the cleaned value as a string (e.g. to reuse in another expression). #}
{% set clean = content.field_my_field|render|remove_html_comments_as_string %}
{{ clean|raw }}
```

Pipe through `|render` first when the source is a render array (field, block, etc.) so the
filter receives a string.

## Exact behaviour

Both methods run the input through one regex:

```php
preg_replace('/<!--(.|\s)*?-->\s*|\r|\n/', '', $string);
```

That means the filter removes:

- HTML comments `<!-- ... -->`, **including multi-line** comments (the `\s` in the group), and
  any run of whitespace immediately following a comment (`-->\s*`);
- **every** carriage return (`\r`) and newline (`\n`) in the string — not only those near a
  comment. So the output is also collapsed onto a single line. Keep this side effect in mind if
  whitespace/newlines are significant.

Edge cases:

- `NULL` input → `remove_html_comments_as_string` returns `''`;
  `remove_html_comments` returns `['#markup' => '']`.
- Input with no comments is returned unchanged except that its newlines are stripped.

## Calling it from PHP (not usually needed)

```php
$svc = \Drupal::service('twig_remove_html_comments.remove_html_comments');
$clean = $svc->removeHtmlCommentsFromString('<p>Hi</p><!-- note -->'); // '<p>Hi</p>'
$build = $svc->removeHtmlCommentsAsRenderArray($markup);               // ['#markup' => ...]
```
