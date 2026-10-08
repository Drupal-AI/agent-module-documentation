# DFP — tokens & hooks

## Tokens (`dfp.tokens.inc`)

Token type `dfp_tag` (`needs-data => 'dfp_tag'`), with two tokens:

- `[dfp_tag:slot]` — the tag's ad slot name (`$tag->getSlot()`).
- `[dfp_tag:network_id]` — the global `dfp.settings` network ID (adds the config as a cacheable
  dependency).

Ad unit patterns and targeting values are run through the token system, so core tokens like
`[current-page:url:args:value:0]` also work inside `adunit_pattern` / `adtest_adunit_pattern`. The
`dfp.token` service (`Drupal\dfp\Token`, args `@token`, `@current_route_match`, `@current_user`)
performs the replacement during rendering.

## Alter hooks (`dfp.api.php`)

Implement these in `MODULE.module` to adjust targeting and tags. All are `&$param` by reference.

- `hook_dfp_target_alter(&$targeting)` — alter a single tag's targeting key/value pair.
- `hook_dfp_global_targeting_alter(&$targeting)` — alter the global targeting key/value pairs (called
  in `DfpHtmlResponseAttachmentsProcessor::getHeadBottom()` before formatting). Example use: append
  URL arguments as targeting.
- `hook_dfp_short_tag_keyvals_alter(&$key_values)` — alter the key/values used when building a
  no-JavaScript "short tag".
- `hook_dfp_tag_alter(&$tag)` — alter a `dfp_tag` object just after it is loaded for block rendering,
  e.g.:

```php
function mymodule_dfp_tag_alter(&$tag) {
  $tag->set('targeting', array_merge($tag->targeting(), [
    ['target' => 'my_target', 'value' => 'my_value'],
  ]));
}
```

There is no plugin type and no Drush integration; ad tags are plain config entities you create through
the admin UI or by importing `dfp.tag.*` config.
