# Permanent conversion — DbReplacer

The module registers **no** Drush command; it exposes a code entry point you call with
`drush ev`. This rewrites the stored field values (not just render output).

## Commands

Simulate first (last arg `TRUE` = simulation, prints intended changes, saves nothing):

```
drush ev "\Drupal\convert_media_tags_to_markup\ConvertMediaTagsToMarkup\DbReplacer::instance()->replaceAll('node', 'page', TRUE);"
```

Then run for real (last arg `FALSE` = live, saves entities):

```
drush ev "\Drupal\convert_media_tags_to_markup\ConvertMediaTagsToMarkup\DbReplacer::instance()->replaceAll('node', 'page', FALSE);"
```

`replaceAll(string $type, string $bundle, bool $simulate = TRUE, string $log = 'print_r')`.

## What it does

- `getAllEntities($type, $bundle)` loads every entity of that type/bundle
  (`loadByProperties(['type' => $bundle])`).
- For each, `Entity::process()` iterates all fields; for field items that have both `value` and
  `format` (i.e. formatted long-text), it runs the value through the same
  `App::instance()->filterText()`.
- Simulate mode prints the would-be new value; live mode assigns it and `$entity->save()`.
- Any per-entity error is logged; if any error occurred it prints a message and `exit(1)`.

## Safety checklist (from README)

- **Back up the database first.**
- Enable *Create new revision* on the bundle so you can revert per node.
- Always run the `TRUE` (simulate) pass and review before the `FALSE` pass.
