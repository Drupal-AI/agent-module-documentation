<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Require on Publish lets you mark a field as required only when its entity is published, so editors can save incomplete drafts but cannot publish until the field is filled in.

---

The module adds a **"Required on Publish"** checkbox (and a dependent **"Warning on Empty"** checkbox) to every field's *Field configuration* edit form (`field_config_edit_form`), but only for fields on entity types that implement `EntityPublishedInterface` (nodes, and other publishable entities). Ticking it stores a **third-party setting** on the `FieldConfig`: `require_on_publish.require_on_publish = true` (and optionally `require_on_publish.warn_on_empty = true`). At runtime the module adds an entity-level validation constraint (`require_on_publish`) to all publishable entity types via `hook_entity_type_alter()`. The constraint's validator (`RequireOnPublishValidator`) iterates the entity's fields: if a field is flagged required-on-publish and is empty (for boolean fields, unchecked) **and the entity is being published**, it adds a validation violation "<label> field is required when publishing." — blocking the save. If instead the entity is unpublished and `warn_on_empty` is on, it shows a non-blocking warning message. It also decorates the edit form so those fields get a distinct "required on publish" label indicator (via preprocess hooks and a CSS/JS library), and has special handling so Paragraphs subfields honor the parent's publish status. There is no settings page, permission, service, or Drush command — configuration is entirely per-field third-party settings.

---

- Require an SEO meta-description only when an article is published, not while drafting.
- Let editors save an incomplete node as a draft but block publishing until a hero image is added.
- Force a "publish date" field to be filled before a node can go live.
- Make a legal-disclaimer field mandatory on publish for regulated content.
- Require a featured-image field on publish while allowing empty drafts.
- Show a soft warning (not a hard block) when saving a draft with an empty recommended field.
- Enforce that a boolean "reviewed" checkbox is ticked before publishing.
- Require an author/byline reference on publish for editorial workflows.
- Gate publishing of a landing page on a required call-to-action link.
- Apply publish-time requirements to any publishable entity type (nodes, custom publishable entities).
- Require specific Paragraph subfields to be filled before the host entity is published.
- Keep draft creation friction-free while guaranteeing complete published content.
- Combine with content moderation so incomplete content can't reach the published state.
- Require a canonical URL or redirect field before publish.
- Ensure a summary/teaser is present on published nodes only.
- Mark a taxonomy reference as required-on-publish for categorization compliance.
- Provide editors an at-a-glance "required on publish" indicator on the edit form.
- Migrate from always-required fields to publish-only-required to reduce draft friction.
- Warn editors about empty optional fields at draft time via "Warning on Empty".
- Require a date range or event location field only when an event node is published.
- Enforce completeness rules per field without writing a custom validation constraint.
- Store the requirement in config (third-party setting) so it deploys with the field.
- Require a price or SKU field on publish for catalog-style content types.
