<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Entity Intake extracts structured entity candidates from pasted unstructured text, queues them for AI processing, and lets a reviewer approve each suggestion into a draft Drupal entity.
---
An intake profile defines which entity types/bundles and fields the AI may populate; entity definitions describe the target shape. A user with a profile permission pastes text into an `ai_intake` entity, which is queued (`ai_entity_intake_extraction`). A multi-pass `LlmClient`/`IntakeExtractor` calls the AI module (structured chat output, provider/model resolved profile → module setting → AI default) to produce suggestions, optionally running a duplicate-matcher against existing entities. Reviewers open the review form, dismiss or "use" each suggestion, and Drupal's native add form is pre-filled so the reviewer saves a normal (draft) entity — with entity-level access still enforced.

Access is layered: `administer ai entity intake` (restricted) manages profiles/definitions; per-profile `use ai intake profile {id}` permissions gate who can create intakes; `view any ai intake`, `review ai entity intake suggestions` and `create entities from ai intake` gate the rest. `IntakeAccess` and `AiIntakeAccessControlHandler` enforce ownership + profile-holding for view/delete, and route the create form through a custom-access service. Optional submodules add intake support for Commerce, Group, Media, Paragraphs, Profile and Taxonomy. All LLM credentials come from the drupal/ai provider layer.
---
- Paste unstructured text and extract candidate entities from it.
- Define intake profiles scoping allowed entity types and fields.
- Create AI entity definitions describing target entity shapes.
- Queue intakes for background AI extraction via cron.
- Review AI suggestions before anything is written.
- Approve a suggestion into a pre-filled native add form.
- Save approved candidates as draft entities.
- Dismiss individual suggestions you don't want.
- Requeue a failed or dismissed intake for another attempt.
- Detect duplicates against existing entities before creation.
- Resolve provider/model per profile, per module, or per AI default.
- Grant per-profile create permissions to specific roles.
- Restrict who can view intakes to owners plus `view any ai intake`.
- Limit suggestion review to reviewers.
- Extend intake to Commerce products via the commerce submodule.
- Extend intake to Group content via the group submodule.
- Extend intake to Media, Paragraphs, Profile or Taxonomy.
- Multi-pass extraction: route pass, field pass, per-entity spider.
- Keep AI keys in the Key module through the drupal/ai layer.
- Audit intake status transitions (queued, analyzed, in review, created).
- Enforce standard entity access on every created draft.