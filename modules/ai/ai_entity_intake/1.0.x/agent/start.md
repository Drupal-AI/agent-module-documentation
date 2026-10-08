<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Entity Intake (ai_entity_intake) — agent index

**Extracts structured entity candidates from free text via the AI module, then routes them through a human review-to-draft workflow.**

- **Version:** 1.0.x (1.0.0-alpha1)  •  **Core:** ^10.5 || ^11.2  •  **Package:** AI
- **Depends on:** ai, user, system, options, json_field, dynamic_entity_reference
- **Config entities:** `ai_entity_definition`, `ai_intake_profile`.  **Content entity:** `ai_intake`.  **Queue:** `ai_entity_intake_extraction`.
- **Key routes:** settings `/admin/config/ai/entity-intake`; definition/profile collections; `/admin/content/ai-intake` (list, `view any ai intake`); per-intake review/requeue/use/dismiss/delete.
- **Permissions:** `administer ai entity intake` (restricted), `view any ai intake`, `review ai entity intake suggestions`, `create entities from ai intake`, plus dynamic `use ai intake profile {id}`.
- **Access:** `IntakeAccess`, `AiIntakeAccessControlHandler`, `ProfileAccess`.  **Submodules:** commerce, group, media, paragraphs, profile, taxonomy.

**Security:** admin/profile/entity access are layered and enforced; create routes use custom-access services and entity-level access still applies to every draft written. No anonymous or unauthenticated endpoints; LLM keys via the drupal/ai provider layer. See [configure/settings.md](configure/settings.md).
