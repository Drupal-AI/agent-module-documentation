<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `metatag_ai.generator` service

Class `Drupal\metatag_ai\Plugin\GenerateMetatag` (registered as service `metatag_ai.generator`).
Wraps the AI module's provider manager to turn text into metatag fields. Source:
`src/Plugin/GenerateMetatag.php`.

## `generate(string $text, ?string $langcode = NULL): array|FALSE`

Returns an array `['title' => …, 'description' => …, 'abstract' => …, 'keywords' => …]` or `FALSE` on
any failure (errors are logged and pushed onto `getErrors()`).

Flow:
1. Requires an active chat provider (`hasProvidersForOperationType('chat', TRUE)`), else FALSE.
2. Resolves the provider/model: uses `metatag_ai.content_settings:metatag_ai.provider_model` if set
   (`loadProviderFromSimpleOption` / `getModelNameFromSimpleOption`), else the AI module default chat
   provider.
3. Picks the system prompt for `$langcode` (→ default language → built-in fallback), validates it
   (`validatePrompt`).
4. Builds `ChatInput([new ChatMessage('user', $text)])`, `setSystemPrompt($prompt)`, calls
   `$provider->chat($messages, $model, ['metatag_ai'])`.
5. `extractJsonFromContent()` parses the reply — plain JSON, then ```json fenced blocks, then a
   brace-matching regex. `extractMetatagFields()` normalizes keys case-insensitively and joins a
   keywords array into a comma-separated string.

## `bulkGenerate(EntityInterface $entity): void`

For a node whose type is in `metadata_content_types`: builds text from `title . body.value`, calls
`generate()`, and if successful **saves** the result into the configured metatag field via
`$entity->set($metadata_field_id, serialize($tags))->save()`. (Note: it `serialize()`s the plain
array — the Metatag field's own normalization is bypassed; verify the stored format for your setup.)

## Error inspection

- `hasErrors(): bool` and `getErrors(): string[]` — human-readable messages accumulated during the
  last call (the module's AJAX handler surfaces these to the editor).

## Calling it

```php
$gen = \Drupal::service('metatag_ai.generator');
$tags = $gen->generate("My title. Some body text.", 'en');
if ($tags === FALSE) {
  foreach ($gen->getErrors() as $msg) { \Drupal::logger('x')->error($msg); }
}
```

The UI path (button → `metatag_ai_generate_submit_form` in `metatag_ai.module`) instead AJAX-injects
the returned values into the open node form's basic metatag inputs rather than saving.
