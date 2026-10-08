# Hooks (`markdownify.api.php`)

Four alter hooks let a module tune the conversion pipeline. They fire in this order per
request: **supported_entities → entity_build → entity_html → entity_markdown**.

## `hook_markdownify_supported_entities_alter(array &$supported_entities)`

Add/remove entity types or change their bundle/language rules. Keyed by entity type id; each
value is `['bundles' => ['default' => bool, 'selected' => string[]], 'languages' => ['default'
=> bool, 'selected' => string[]]]` (same include/exclude semantics as the config —
`default: false` = only `selected`).

```php
function mymod_markdownify_supported_entities_alter(array &$supported_entities): void {
  $supported_entities['media'] = [
    'bundles' => ['default' => FALSE, 'selected' => ['document']],
    'languages' => ['default' => TRUE, 'selected' => []],
  ];
}
```

> Replaces the **deprecated** `hook_markdownify_supported_entity_types_alter(array &$types)`
> (removed in 2.0.0), which only altered a flat list of entity type ids.

## `hook_markdownify_entity_build_alter(array &$build, array $context, ?BubbleableMetadata $metadata)`

Modify the entity **render array** before it is rendered to HTML. `$context` = `entity`,
`view_mode`, `langcode`. (This is what `markdownify_file_attachment` uses to swap in its file
formatter.)

## `hook_markdownify_entity_html_alter(string &$html, array $context, ?BubbleableMetadata $metadata)`

Modify the **rendered HTML** before it is converted to Markdown. `$context` = `entity`,
`view_mode`, `langcode`.

## `hook_markdownify_entity_markdown_alter(string &$markdown, array $context)`

Post-process the **final Markdown** (e.g. prepend YAML front matter / a title). `$context`
holds the original `html`.

```php
function mymod_markdownify_entity_markdown_alter(string &$markdown, array $context): void {
  $markdown = "---\ngenerator: markdownify\n---\n\n" . $markdown;
}
```

There is also the plugin-manager alter `hook_html_to_markdown_converter_info_alter()` for
converter plugin definitions (see [plugins/converters.md](../plugins/converters.md)).
