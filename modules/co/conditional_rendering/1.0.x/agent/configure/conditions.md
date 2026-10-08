<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure block rendering conditions

## Fields added to content blocks
Editing any `block_content` entity exposes:
- **Conditional Rendering Action** (`conditional_rendering_action`) — `show` or `hide`.
- **Conditions** (`conditional_rendering_conditions`) — unlimited rows, each with **property**, **operator**, **value** (field type `conditional_rendering_condition`, widget `conditional_rendering_condition`).

## Evaluation
`RenderBlockSubscriber::onBuildRender()` (Layout Builder event, priority 9999) runs only outside preview. It loads the block revision, then AND-combines every condition through `TokenConditionalEvaluationService::eval($property, $operator, $value)`:
- `property` is passed through Drupal `token->replace()` before comparison.
- Result drives access: **show** → all pass or block gets `LayoutPreviewAccessDenied`; **hide** → passing conditions add `LayoutPreviewAccessDenied`.

## Operators (`eval()`)
`equals`, `not_equals`, `greater_than`, `greater_than_or_equal_to`, `less_than`, `less_than_or_equal_to`, `empty`, `not_empty`, `contains`, `not_contains`, `starts_with`, `ends_with`, `in`, `not_in` (split the *token* on commas), `one_of`, `not_one_of` (split the *value* on commas), `regex` (`preg_match(value, tokenProperty)`).

## Notes
- Use `[current-user:…]`, `[node:…]`, etc. as the property; install the optional **Token** module to browse available tokens.
- Blocks with an action set get the `conditional-rendering-block` CSS class (`hook_preprocess_block`).
- Conditions are editor-authored config; the `regex`/token inputs are trusted, not anonymous request data.
- No admin route or permission of its own — governed by block-content edit access.
