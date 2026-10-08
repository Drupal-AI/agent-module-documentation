<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Deck Moderation makes deck cards tint and label themselves by Content Moderation workflow state.

---

This feature submodule integrates core Content Moderation into Entity Reference Deck. It provides EntityReferenceDeckContentModerationStyle, a Content Moderation-aware implementation of the deck's moderation-style resolver, so a referenced entity's card reflects its workflow state — draft, has unpublished edits, or new — through the card tint modifier and the status pill rendered by the core 'moderation' card action. Enable it after entity_reference_deck when Content Moderation and Workflows are present.

---

- Tint reference cards by Content Moderation workflow state.
- Show a Draft status pill on cards with a draft revision.
- Show an Unpublished-edits pill on published entities with a pending draft.
- Show a New pill on never-published entities.
- Drive the core 'moderation' card action's status tag from real workflow state.
- Give editors an at-a-glance moderation overview of a reference list.
- Work across Entity Browser deck widgets.
- Work across Paragraphs deck widgets.
- Support any content entity type under a moderation workflow.
- Reflect per-language moderation state where applicable.
- Pair with the Diff submodule to review the drafted changes.
- Help reviewers prioritise unpublished content in long lists.
- Avoid custom code to surface moderation status in reference UIs.
- Degrade gracefully to no tint when an entity is not under moderation.
- Keep published, current content visually unmarked.
- Provide accessible state labels via aria attributes on the card.
- Integrate with editorial workflows without extra configuration.
- Surface moderation status consistently across host widgets.
- Complement the global settings ordering of the moderation action.
- Support content staging and review processes visually.
