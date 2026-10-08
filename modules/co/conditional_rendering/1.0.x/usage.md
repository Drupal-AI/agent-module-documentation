<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Conditional Content Block Rendering lets editors attach show/hide conditions to Layout Builder content blocks, evaluated by comparing a token value against a target using a chosen operator.
---
Layout Builder has no native way to show a content block only when a runtime condition is met. This module adds two base fields to `block_content` entities — `conditional_rendering_action` (Show or Hide) and an unlimited-cardinality `conditional_rendering_conditions` field (a custom field type with property, operator and value, edited via a custom widget). At render time a Layout Builder event subscriber (`RenderBlockSubscriber`, on `SECTION_COMPONENT_BUILD_RENDER_ARRAY`, priority 9999) loads the block's revision, and for each condition calls `TokenConditionalEvaluationService::eval()`, which runs Drupal's token `replace()` on the property and compares the result to the value.

Conditions are combined with logical AND; the action then decides access: for "Show", all conditions must pass or the block is denied (`LayoutPreviewAccessDenied`); for "Hide", passing conditions deny the block. Evaluation is skipped in Layout Builder preview so editors still see the block. The evaluator supports many operators — equals/not_equals, greater/less-than variants, empty/not_empty, contains, starts_with/ends_with, in/not_in, one_of/not_one_of and `regex`. Conditions and operators are authored by users with permission to edit block content, so the token/regex inputs are trusted editor configuration, not anonymous request data. The module has no routes, permissions or config of its own beyond the block fields and its `TokenConditionalEvaluationService` service.
---
- Show a content block only to logged-in users via a user token.
- Hide a block when a token value matches a condition.
- Display a block only when a field/token equals a specific value.
- Combine multiple conditions on one block (all must pass).
- Use "contains" to show a block when a token includes a substring.
- Match a token against a comma list with `in` / `one_of`.
- Show a block only when a token is empty (or not empty).
- Compare numeric token values with greater-than / less-than operators.
- Use a regex operator for advanced token matching.
- Hide promotional blocks outside a targeted context.
- Personalize a Layout Builder layout by user attributes.
- Keep a block visible in Layout Builder preview while conditional live.
- Add a Show/Hide action selector to any content block.
- Author unlimited conditions per block.
- Show a block based on the current path or route token.
- Toggle blocks by date/time tokens.
- Style conditional blocks via the auto-added CSS class.
- Restrict a call-to-action block to a segment of visitors.
- Use starts_with / ends_with to match token prefixes or suffixes.
- Invert logic with not_equals / not_contains / not_in operators.
