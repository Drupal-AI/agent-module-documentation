# Configure — canonical-URL rewrite

Config object: **`acquia_contenthub_metatag.settings`** (schema in
`config/schema/acquia_contenthub_metatag.schema.yml`). There is **no dedicated settings form**;
set the flag with Drush or `settings.php`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `ach_metatag_node_url_do_not_transform` | boolean | `FALSE` | When `TRUE`, opt out of transforming `[node:url]` in the metatag `canonical_url` during export. |

Opt out of the rewrite:
```
drush cset acquia_contenthub_metatag.settings ach_metatag_node_url_do_not_transform 1
```
Or in `settings.php`:
```php
$config['acquia_contenthub_metatag.settings']['ach_metatag_node_url_do_not_transform'] = TRUE;
```

## What happens at runtime

On export, the base module dispatches `SERIALIZE_CONTENT_ENTITY_FIELD` per field. The subscriber
`acquia_contenthub.metatags.serializer` (`EntityMetatagsSerializer::onSerializeContentField()`,
priority 110):

1. Returns immediately unless the field is of type `metatag`.
2. Returns if `ach_metatag_node_url_do_not_transform` is `TRUE`.
3. Runs the base `FallbackFieldSerializer` to build the CDF field data.
4. Decodes the stored metatag value (`metatag_data_decode()` when available, otherwise
   `unserialize($v, ['allowed_classes' => []])`), merges defaults via
   `MetatagManager::tagsFromEntityWithDefaults()`, and replaces `[node:url]` in `canonical_url`
   with `$entity->toUrl()->setAbsolute()->toString()` (the publisher's absolute URL).
5. Re-serializes the value back into the field data and calls `stopPropagation()`.

Net effect: subscribers receive a concrete publisher URL in the metatag `canonical_url` rather
than an unresolved token. The `.module` file also updates the canonical-URL field's help text on
the metatag defaults form and metatag field widgets to explain this behavior and how to opt out.

> Note: the code has a `@todo` to support Metatag 2.x; the decode path assumes the Metatag 1.x
> serialized value format.
