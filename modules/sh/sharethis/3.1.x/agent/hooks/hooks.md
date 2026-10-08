# ShareThis — hooks (`sharethis.api.php`)

## `hook_sharethis_render_alter(array &$attributes, array &$data_options, string &$span_text)`

Called by `sharethis.manager->renderSpans()` for each share button, so other modules can rewrite
a button before it is output.

| Param | What it is |
|---|---|
| `$attributes` | the button's attributes: `url`, `title`, `class`, display text, and things like `st_username`. |
| `$data_options` | the full ShareThis configuration array (as from `getOptions()`). |
| `$span_text` | the string shown inside the button `<span>`. |

```php
function mymodule_sharethis_render_alter(array &$attributes, array &$data_options, string &$span_text) {
  // Set the ShareThis username used on the buttons.
  $attributes['st_username'] = 'mysite';
  // Override the twitter handle at render time.
  $data_options['twitter_handle'] = 'mysite_news';
}
```

This is the only hook the module invites. For anything beyond per-button rewriting (different
markup, different services logic) you would decorate the `sharethis.manager` service or override
the `sharethis_block` theme template (`templates/sharethis-block.html.twig`).
