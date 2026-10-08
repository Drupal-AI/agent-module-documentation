# Render tokens — mechanism and machine names

The module adds one token per entity view mode. Everything lives in `token_entity_render.module`
(the module has no other PHP).

## Token naming

`[<entity_type>:render:<view_mode>]` — e.g. `[node:render:teaser]`, `[node:render:full]`,
`[user:render:compact]`, `[taxonomy_term:render:full]`. The literal segment is `render:`; the trailing
segment is the view-mode **machine name** with its `<entity_type>.` prefix removed, so the stored view
mode `node.teaser` is exposed as `[node:render:teaser]`.

## Registration — `hook_token_info_alter()` (`token_entity_render.module:13`)

Loads every `entity_view_mode` config entity (`entity_type.manager` → `getStorage('entity_view_mode')`
→ `loadMultiple()`) and, for each one, adds

```php
$data['tokens'][<target_entity_type>]['render:' . <view_mode_name>] = [
  'name' => <view mode label>,
  'description' => …,
];
```

A token is added **only** when `$data['tokens'][<entity_type>]` already exists — i.e. only for entity
types some other module (core, contrib `token`, …) already exposes as a token group. View modes whose
entity type has no token group are skipped (`:21-22`). (The token `description` text in this release is
authored in Spanish.)

## Substitution — `hook_tokens()` (`token_entity_render.module:45`)

- Returns immediately unless `$data['entity_type']` is set (`:49`) — the hook only acts on
  entity-context token replacements, where the caller of `\Drupal::token()->replace()` supplied
  `$data['entity']` + `$data['entity_type']`.
- Scans the requested tokens for the literal `render:` (via `strpos`, `:57`) and maps each raw token to
  the requested view-mode name (`:61`).
- For each requested view mode it confirms `<entity_type>.<view_mode>` is a real view mode (`:76`),
  derives the view-mode machine name, then renders:

```php
$build = \Drupal::entityTypeManager()
  ->getViewBuilder($view_mode->getTargetType())
  ->view($data['entity'], $mode_machine_name);          // :80
$replacements[$raw_token] = $renderer->renderPlain($build);   // :83
```

The rendered entity is **always** `$data['entity']` — the entity already in the token context. The
token string contributes only the view mode; it can never name a different entity id.

## Calling it from PHP

There is nothing token_entity_render-specific to call; use the normal token API and pass the entity as
context:

```php
$html = \Drupal::token()->replace('[node:render:teaser]', ['node' => $node]);
```

The `['node' => $node]` context becomes `$data['entity']` / `$data['entity_type']` inside the hook.

## Rendering semantics an integrator must know

- **Output is a plain HTML string.** `renderPlain()` renders in an isolated render context, so the
  render array's cache metadata (tags / contexts / max-age) is **not** bubbled back into the
  surrounding page, email or field. If that container is cached, add the entity's cache tags yourself
  so it invalidates when the entity changes.
- **Deprecation / forward-compat.** `Renderer::renderPlain()` is deprecated in Drupal 10.3 and removed
  in 12.0 (`web/core/lib/Drupal/Core/Render/Renderer.php:150`); the module still calls it (`:83`), so
  it emits a deprecation notice under Drupal 11 and will need `renderInIsolation()` for Drupal 12.
