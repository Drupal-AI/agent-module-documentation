# AI Translate — Drush commands

Class `\Drupal\ai_translate\Drush\AiTranslateCommands`. Both call the shared
`ai_translate.translation_orchestrator` / `ai_translate.text_translator` services. They run with CLI
trust and, unlike the web route, do not perform a per-entity access check.

## `ai:translate-entity`

Translate one or more content entities and save the target-language translation.

```
drush ai:translate-entity <entityType> <entityIds> <langFrom> <langTo>
# e.g.
drush ai:translate-entity node 16,18,20 en fr
```

- `entityIds` is comma-separated. Entities that already have the target translation are skipped
  (`EntityTranslationResult::translationExists()`).
- Internally calls `EntityTranslationOrchestrator::translateEntity()`: extracts translatable fields,
  translates each column, `html_entity_decode()`s the result, then `addTranslation()` + save. Per-field
  failures are reported as a warning; the message reports success/failure.

## `ai:translate-text`

Translate a raw string and return the result (no entity involved).

```
drush ai:translate-text "<text>" <langFrom> <langTo>
```

Argument order is text, then source, then target language code (callback signature is
`translate(string $text, string $langFrom, string $langTo)`). On a provider error it logs and prints an
error via the messenger.
