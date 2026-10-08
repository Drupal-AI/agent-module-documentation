<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_toc_filter_alter()

The only hook the module invites (`toc_filter.api.php`). It fires inside
`TocFilter::process()` just before the content is handed to TOC API, after the TOC type options and
the token's inline options have been merged.

```php
/**
 * Alter the options used to build a table of contents.
 *
 * @param array &$options
 *   The merged options (TOC type options + [toc] inline options). Set to FALSE to block the TOC.
 * @param string &$content
 *   The content about to be converted to a table of contents.
 */
function hook_toc_filter_alter(array &$options, &$content) {
  // Don't build a TOC unless there are at least five <h2> tags.
  if (substr_count($content, '<h2') < 5) {
    $options = FALSE;
  }
}
```

## Behaviour

- Invoked as `\Drupal::moduleHandler()->alter('toc_filter', $text, $options)` — note the module
  passes `$text` and `$options` positionally, so in your implementation the **first** parameter is
  the options array and the **second** is the content.
- **Setting `$options = FALSE` cancels the TOC**: `process()` returns the text with the `[toc]`
  token removed and no table of contents rendered.
- Otherwise, mutate `$options` to change the TOC type's behaviour (e.g. header levels, title,
  classes) for this particular render.

## Typical uses

- Suppress the TOC on short content (as above).
- Force a `title` or a specific set of header levels site-wide.
- Switch TOC type dynamically based on the content or current route.
- Add custom options consumed by a custom TOC type.
