<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AiMetatagService & the AJAX callback

## The button (`ai_metatag_generator.module`)

`ai_metatag_generator_field_widget_single_element_form_alter(&$element, $form_state, $context)`
fires for every widget. It acts only when the field name equals config `metatag_field` and the
form entity is a **node**, is **not new**, its type is in `content_types`, and the current user has
`use ai metatag generator`. Then it adds:

```php
$element['generate_button'] = [
  '#type' => 'button',
  '#value' => t('Generate Metatags with AI'),
  '#weight' => -100,
  '#ajax' => ['callback' => '\Drupal\ai_metatag_generator\AiMetatagUtility::generateMetatags'],
];
```

## AJAX callback (`AiMetatagUtility::generateMetatags()`)

Static callback returning an `AjaxResponse`. Loads the node from
`$form_state->getFormObject()->getEntity()`, resolves the configured `metatag_field` (default
`field_meta_tags`) and per-language success/error messages, then calls
`ai_metatag_generator.ai_service`'s `generateMetatags($node)`. On success it pushes each returned
value into the Metatag basic subfields via
`InvokeCommand('[name="<field>[0][basic][description|keywords|abstract]"]', 'val', [value])` and
opens a success dialog (`OpenDialogCommand` on `#ai-metatag-success-dialog`); otherwise an error
dialog. Everything is wrapped in try/catch with logging to the `ai_metatag_generator` channel.
The values are set on the form client-side only — the editor still saves the node to persist them.

## `Services\AiMetatagService`

Service id `ai_metatag_generator.ai_service`; args `@config.factory`, `@ai.provider`,
`@entity_type.manager`, `@logger.factory`, `@renderer`, `@language_manager`.

- `generateMetatags(NodeInterface $node): ?array` — `getNodeContent()` then `callAiService()`
  then `parseAiResponse()`; returns `['description', 'keywords', 'abstract']` or NULL.
- `getNodeContent()` — renders the node with the view builder in the configured `display_mode`
  (`renderer->renderInIsolation()`), prepends `Title: …`, optionally `strip_tags()`, removes
  blacklisted words (`cleanContent()`, word-boundary `preg_replace`), collapses whitespace.
- `callAiService()` — resolves provider/model (`provider_model` simple option, else default
  `chat`), builds `new ChatInput([new ChatMessage('user', $content)])`, sets the resolved
  per-language prompt (+ required JSON shape) as the **system prompt**, calls `provider->chat()`,
  returns `getNormalized()->getText()`.
- `parseAiResponse()` — strips markdown fences, `json_decode`, requires non-empty `description`,
  `abstract`, `keywords`; returns them trimmed or NULL on any failure.
- `updateNodeMetatags(NodeInterface $node, array $metatags): bool` — programmatic helper that
  merges values into the node's `field_meta_tags` (serialized Metatag value) and saves. Note it
  **hard-codes `field_meta_tags`**, independent of the `metatag_field` config used elsewhere; it
  is not called by the AJAX flow.
- `getDefaultPrompt(string $languageName): string` — the fallback prompt (≤160-char
  description/abstract, ≤10 keywords, in the given language).

## Integration notes

- All AI access is via the drupal/ai provider abstraction; API key/TLS belong to that provider.
- Generation is synchronous inside the AJAX request; failures degrade to the error dialog.
- Unit tests exist under `tests/src/Unit/` for the service, config form, and utility.
