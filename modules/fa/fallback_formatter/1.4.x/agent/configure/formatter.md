# Configure the Fallback formatter

There is no global config. You configure it per field on **Manage display**
(`admin/structure/.../display`).

## Selecting it

Pick **"Fallback"** as the field's formatter. It only appears for field types that already expose two or
more formatters (enforced by `fallback_formatter_field_formatter_info_alter`), since chaining one formatter
is pointless.

## Settings form

Open the formatter's settings (cog). You get three linked parts:

1. **Enabled formatters** — a checkbox per candidate formatter (all of the field type's formatters except
   `fallback` itself and any whose `isApplicable()` returns FALSE).
2. **Formatter processing weight** — a tabledrag table ordering the enabled formatters (lower weight runs
   first). Attaches library `fallback_formatter/admin`.
3. **Per-formatter settings** — each enabled formatter's own settings form, embedded in a fieldset.

## Stored settings

Config schema `field.formatter.settings.fallback`:

```yaml
settings:
  formatters:            # sequence, in weight order
    <formatter_id>:
      status: true       # enabled
      weight: 0
      formatter: <formatter_id>
      settings: { … }    # that formatter's own settings (schema field.formatter.settings.<formatter_id>)
```

## Render behaviour (what to expect)

`FallbackFormatter::viewElements()`:

1. `prepareFormatters()` merges defaults, filters to enabled, intersects with the field type's allowed
   formatters, and sorts by weight.
2. For each formatter in order it runs `prepareView()` + `viewElements()`.
3. Only **still-unrendered deltas** (`array_diff_key` against already-produced output) and only *visible*
   children (`Element::getVisibleChildren`) are taken from each formatter's result.
4. As soon as every field item (delta) has output, it stops; results are `ksort`ed by delta.

So the "first formatter that returns output wins" decision is made **per field item**, not for the whole
field — different deltas can end up rendered by different formatters.

## Example: set via Drush (illustrative)

```php
// drush php:eval — link field: try 'link' formatter, fall back to 'string'.
$d = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$d->setComponent('field_url', [
  'type' => 'fallback',
  'region' => 'content',
  'settings' => ['formatters' => [
    'link'   => ['status' => 1, 'weight' => 0, 'formatter' => 'link',   'settings' => []],
    'string' => ['status' => 1, 'weight' => 1, 'formatter' => 'string', 'settings' => []],
  ]],
])->save();
```

## Notes / limits

- `fallback` is excluded from its own candidate list (no infinite recursion).
- `fallback_formatter_entity_embed_display_plugins_alter` removes any `*:fallback` Entity Embed display
  plugin, so Fallback cannot be used as an embed display.
- `settingsSummary()` lists each configured formatter (and flags unknown/invalid ones).
