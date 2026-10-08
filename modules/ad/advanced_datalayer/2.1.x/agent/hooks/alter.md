# Alter hooks

Advanced Datalayer ships no `.api.php`, but invokes these alters (via
`ModuleHandler::alter()` / plugin-manager `alterInfo`). Implement them in `mymodule.module`.

## `hook_advanced_datalayer_alter(&$datalayer_tags, $context)`

Fired inside `advanced_datalayer_get_tags_from_route()` after the applicable tags for the
current route are gathered, before they are attached. Adjust, add, or remove tag values.

```php
function mymodule_advanced_datalayer_alter(array &$datalayer_tags, array $context) {
  // Add or override a computed value for this request.
  $datalayer_tags['environment'] = 'production';
}
```

## `hook_advanced_datalayer_attachments_alter(&$datalayer_tags)`

Fired in `advanced_datalayer_page_attachments()` on the resolved tag array, immediately before
it is JSON-encoded into the `dataLayer_tags` head script. Last chance to post-process.

```php
function mymodule_advanced_datalayer_attachments_alter(array &$datalayer_tags) {
  unset($datalayer_tags['debug_only']);
}
```

## Plugin-definition alters

The plugin managers register these alters for changing plugin *definitions* (not runtime
values):

- `hook_advanced_datalayer_tags_alter(&$definitions)` — alter discovered
  `@AdvancedDatalayerTag` definitions (manager alterInfo `advanced_datalayer_tags`).
- The group manager exposes the analogous alter for `@AdvancedDatalayerGroup` definitions.

Use these to change a tag's `weight`, `group`, `global`, etc., or to remove a tag provided by
another module.
