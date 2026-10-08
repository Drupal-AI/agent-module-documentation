# AI Translate — Drush commands

Class `\Drupal\ai_translate\Drush\AiTranslateCommands`. Both call the same translator/extractor
services as the UI (they run with CLI/root trust).

## `ai:translate-entity`

Translate one or more content entities and save the target-language translation.

```
drush ai:translate-entity <entityType> <entityIds> <langFrom> <langTo>
# e.g.
drush ai:translate-entity node 16,18,20 en fr
```

- `entityIds` is comma-separated. Entities already having the target translation are skipped.
- Extracts translatable fields, translates each column, `html_entity_decode()`s the result, then
  `addTranslation()` + save.

## `ai:translate-text`

Translate a raw string and print the result (no entity involved).

```
drush ai:translate-text "<text>" <langFrom> <langTo>
```

Note the argument order is text, then source, then target language code (the callback signature is
`translate(string $text, string $langFrom, string $langTo)`).
