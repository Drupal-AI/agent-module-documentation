# Configure automatic labels for a bundle

Settings are stored per bundle in config `auto_entitylabel.settings.<entity_type>.<bundle>`.
Reach the form via the **Automatic label** tab on a bundle's edit page (link template
`auto-label`), e.g. `/admin/structure/types/manage/article/auto-label`. Form:
`Drupal\auto_entitylabel\Form\AutoEntityLabelForm`.

## Fields (config keys)
- `status` (int) — generation mode:
  - `0` DISABLED — no automatic label.
  - `1` ENABLED — generate the label and hide the label field on the form.
  - `2` OPTIONAL — label field stays, but auto-generate when left empty.
  - `3` PREFILLED — prefill the label field with the pattern (limited token support; e.g.
    `[node:nid]` is not yet available).
- `pattern` (string) — the label pattern, using tokens, e.g. `[node:author]-[node:created]`.
  Leave blank to use the default generated label. Install Token module for a token browser.
- `escape` (bool) — remove all special characters from the result.
- `preserve_titles` (bool) — keep titles of already-created content (only with ENABLED).
- `new_content_behavior` (int) — `0` BEFORE_SAVE (faster, no id tokens) or `1` AFTER_SAVE
  (all tokens supported, content saved twice).
- `save` (bool) + `chunk` (int) — trigger a batch re-save of all existing entities of this
  bundle, processing `chunk` entities per batch step (see `src/Batch/ResaveBatch.php`).

## Example config YAML
```yaml
# auto_entitylabel.settings.node.article.yml
status: 1
pattern: '[node:field_first] [node:field_last]'
escape: true
preserve_titles: false
new_content_behavior: 0
```

Labels are produced by `Drupal\auto_entitylabel\AutoEntityLabelManager::generateLabel()`,
invoked from the module's `hook_form_alter`/entity save handling; you normally never call it
directly.
