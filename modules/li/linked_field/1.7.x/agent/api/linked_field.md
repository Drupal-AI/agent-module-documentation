# Linked Field — render behavior, service & theming

Linked Field ships **no plugin types and no `.api.php`**. Its work happens in module hooks
plus one service. There is nothing to implement to use it — but this is how it links markup,
which matters for theming.

## How the link is applied on render

`linked_field_entity_display_build_alter()` (`hook_entity_display_build_alter()`) runs for
every rendered entity display:

1. For each field in the build, read its `linked_field` third-party settings via
   `LinkedFieldManager::getFieldDisplaySettings($display, $field_name)`. Skip if not linked or no destination.
2. Resolve the href:
   - **Type `field`** → read the destination field's first item (`getDestination()` → `getFieldValue()`); for `link` fields uses `uri`, otherwise `value`. Link-field `options.attributes` are merged in (`getFieldItemAttributes()`).
   - **Type `custom`** → run the string through **token replacement** (`replaceToken()`), and if the result is an `<a …>` it extracts the `href`.
3. Build an absolute URL with `buildDestinationUrl()`: bare paths get an `internal:/` prefix, then `Url::fromUri(...)->setAbsolute()->toString()`. Invalid → the field is left unlinked.
4. Apply advanced attributes (token-replaced, XSS-escaped; `class`/`rel` merged & de-duplicated).
5. Determine link text: the token-replaced **Text** setting if set (filtered with `Xss::filterAdmin`), otherwise the field's own rendered output.
6. Replace the field item render array with an `#type => inline_template` whose markup is `linkHtml($rendered, $attributes)`.

`hook_field_formatter_settings_summary_alter()` adds a "Linked Field" summary (destination +
attributes + text) under the formatter on Manage display.

## Service: `linked_field.manager`

Class `Drupal\linked_field\LinkedFieldManager` implements `LinkedFieldManagerInterface`.
Constructor args: `@config.factory`, `@path.validator`, `@token`, `@entity_field.manager`,
`@entity_type.manager`. Useful public methods:

| Method | Purpose |
|---|---|
| `getFieldTypeBlacklist()` | Field types that can't be linked → `['link']`. |
| `getAttributes()` | The configured attribute definitions from `linked_field.config`. |
| `getDestinationFields($entity_type_id, $bundle_id)` | Fields eligible as a **Field** destination (`link`, `string`, `list_float`, `list_string`; label field excluded). |
| `getFieldDisplaySettings($display, $field_name)` | Read a component's `linked_field` third-party settings. |
| `getDestination($type, $value, $context)` | Resolve the raw destination for `field`/`custom`. |
| `getFieldItemAttributes($value, $delta, $context)` | Pull `options.attributes` from a link-field item. |
| `buildDestinationUrl($destination)` | Normalize + build an absolute URL string (or `FALSE`). |
| `getFieldValue($field_items)` | First item's `uri` (link) or `value`. |
| `replaceToken($text, $data, $options)` | Wrapper over the core `token` service. |
| `linkHtml($html, $attributes)` / `linkNode(...)` | Recursively wrap text and `img`/`picture` nodes of an HTML fragment in `<a>` (skips existing `a`/`picture`). |

`getDisplaySettings(EntityInterface, $view_mode, $field_name)` exists but is **deprecated**
(removed in 2.0.0) — use `getFieldDisplaySettings()`.

Example:

```php
$manager = \Drupal::service('linked_field.manager');
$settings = $manager->getFieldDisplaySettings($display, 'field_image');
$url = $manager->buildDestinationUrl('/node/1'); // absolute URL string or FALSE
```

## Theming notes

- Output is a wrapped `<a>` produced by `linkHtml()`, not a separate theme hook/template — there are no Twig templates to override. Style via the `class` attribute or the `linked-field.css` the module ships.
- `linkHtml()` runs markup through `Xss::filterAdmin()`; only inline-safe content survives.
- Image/`picture` fields become fully clickable (the media node is moved inside the new `<a>`); text nodes are individually wrapped.
