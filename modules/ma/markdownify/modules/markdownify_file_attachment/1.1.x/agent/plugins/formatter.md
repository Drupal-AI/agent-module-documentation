# The `md_file_attachment_file_embed` field formatter

`MdFileAttachmentFieldFormatter` (`@FieldFormatter id = "md_file_attachment_file_embed"`,
`field_types = {"file"}`) extends core `FileFormatterBase`. It is **not** meant to be selected
manually in *Manage display*; the submodule applies it automatically during Markdown
rendering.

## How it is applied

`markdownify_file_attachment_markdownify_entity_build_alter()` implements the parent's
`hook_markdownify_entity_build_alter()`. For each `file`-type field on the entity being
Markdownified it re-renders the field with:

```php
$display_options = [
  'type' => 'md_file_attachment_file_embed',
  'settings' => [
    'allowed_extensions' => $config->get('allowed_extensions'),
    'max_size' => min(Bytes::toNumber($config->get('max_file_embed_size')), Environment::getUploadMaxSize()),
  ],
];
$build[$field_name] = $entity->get($field_name)->view($display_options);
```

So the effective size cap is `min(max_file_embed_size, PHP upload max)`.

## What it outputs (`viewElements`)

Per referenced file:

- extension ∈ `allowed_extensions` **and** `filesize ≤ max_size` →
  `Attached file <name> with <ext> extension available at <url> follows:<br><contents>`
  where `<contents>` is `file_get_contents(realpath(uri))`.
- otherwise → `Attached file <name> with <ext> extension available at <url>` (link only, no body).

`defaultSettings()` on the formatter itself is `allowed_extensions: [yml, txt]`, `max_size:
1024`, but in practice the settings passed from the config (above) are what apply.

## Formatter's own dependencies

Injects `file_url_generator`, `renderer`, `logger.channel.markdownify`, `file_system`.
