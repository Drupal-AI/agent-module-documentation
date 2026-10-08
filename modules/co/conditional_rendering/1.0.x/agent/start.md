<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conditional Content Block Rendering (conditional_rendering) — agent index

**Show/hide Layout Builder content blocks based on token-comparison conditions attached to the block.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Dependencies:** `layout_builder` (core)
- **Base fields on `block_content`:** `conditional_rendering_action` (Show|Hide), `conditional_rendering_conditions` (custom field type `conditional_rendering_condition`, unlimited; widget `conditional_rendering_condition`).
- **Services:** `conditional_rendering.token_evaluator` (`TokenConditionalEvaluationService`, arg `@token`); `conditional_rendering.event_subscriber` (`RenderBlockSubscriber`, on `LayoutBuilderEvents::SECTION_COMPONENT_BUILD_RENDER_ARRAY`, priority 9999).
- **Operators:** equals, not_equals, greater/less-than(+or_equal), empty, not_empty, contains, not_contains, starts_with, ends_with, in, not_in, one_of, not_one_of, regex.
- **Logic:** conditions AND-combined; access enforced via `setAccessDependency` / `LayoutPreviewAccessDenied`; skipped in LB preview.
- **Routes/permissions/config:** none of its own.

**Security:** no routes, permissions or public endpoints; conditions (including `regex` and token strings) are authored only by users who can edit block content — trusted editor config, not request input. Recommend `token` module (optional) for token discovery. See [configure/conditions.md](configure/conditions.md).
