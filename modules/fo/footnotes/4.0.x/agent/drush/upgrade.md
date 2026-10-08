# Drush: `footnotes:upgrade-3-to-4`

Footnotes 4.x changed the in-content markup from the 3.x style. This command rewrites existing
formatted-text content to the 4.x markup. Registered via `drush.services.yml` →
`\Drupal\footnotes\Upgrade\FootnotesUpgradeDrushCommand` (uses the batch manager
`footnotes.batch_manager`).

## Usage

```bash
drush footnotes:upgrade-3-to-4 <entity_type> [--use-data-text=<bool>]
```

- `<entity_type>` — the entity type whose formatted-text fields to scan, e.g. `node`,
  `paragraph`, `taxonomy_term`, `block`. The command loads that type's storage, walks every
  bundle, and processes fields of type `text`, `text_long`, `text_with_summary`.
- `--use-data-text` (default **TRUE**) — write the reference content inside a `data-text`
  attribute the way CKEditor 5 does. Set `--use-data-text=false` if you author plain HTML
  without CKEditor 5. (Accepts `false`/`FALSE`/`0`.)

Examples:

```bash
drush footnotes:upgrade-3-to-4 node
drush footnotes:upgrade-3-to-4 paragraph --use-data-text=false
```

Run it once per entity type that holds footnote content. It processes in a batch, so it is safe
on large data sets. Back up first — it rewrites field values in place.

## Customizing the migration

Each upgraded footnote's render array can be altered before it is written, via
`hook_footnotes_upgrade_3x4x_build_alter(array &$build, array $context)` — see
[../hooks/upgrade-alter.md](../hooks/upgrade-alter.md).
