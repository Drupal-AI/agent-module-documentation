<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Preview Link lets editors generate a unique, tokenised URL that grants anyone (including anonymous users, with no account) temporary access to preview an unpublished or draft entity.

---

The module defines a `preview_link` content entity (base table `preview_link`) that holds a random UUID `token`, a `dynamic_entity_reference` `entities` field listing the entities the link unlocks, a `generated_timestamp`, and an `expiry` timestamp (default lifetime from config). For every supported content entity type it adds — via `hook_entity_type_alter()` — a `preview_link` route provider and a `preview-link-generate` link template (`<canonical>/generate-preview-link`), plus a local task tab where editors with the `generate preview links` permission create or reset a link. Visiting an entity's canonical URL with a valid `preview_token` grants view access through `hook_entity_access()` even when the content is unpublished; a set of access checks (`_access_preview_link`, `_access_preview_enabled`, `_access_preview_link_canonical_rerouter`, `_access_preview_session_exists`) and a route event subscriber wire the token into the normal canonical route and can store it in the session so subsequent unlinked requests still resolve. Which entity types/bundles are eligible, whether a link may reference multiple entities, the link lifetime, and when the "link created" message shows are controlled from the settings form (`preview_link.settings`, route `preview_link.settings` at `/admin/config/content/preview_link`). Expired links are cleaned up on cron (`PreviewLinkExpiry` / `preview_link.link_expiry`). The `preview_link.host` service answers whether an entity has (unexpired) preview links. It has no Drush commands.

---

- Share a draft article with a stakeholder who has no Drupal account via a single link.
- Let a client preview unpublished pages before they go live.
- Give reviewers time-limited access to in-progress content without publishing it.
- Generate a preview URL for a node from its "Preview Link" tab.
- Enable preview links for specific entity types and bundles (e.g. only Article and Page).
- Set how long a preview link stays valid (default 7 days / 604800 seconds).
- Allow a single preview link to unlock multiple related entities at once.
- Reset/regenerate a preview link's token to instantly revoke the old URL.
- Preview unpublished content that content-moderation keeps in a draft state.
- Control whether editors see a confirmation message when a link is created (always/subsequent/never).
- Store the preview token in the session so an anonymous reviewer can browse related pages.
- Programmatically create a preview link for an entity via the `preview_link` entity storage.
- Check whether an entity already has an active preview link with the `preview_link.host` service.
- Automatically expire and clean up old preview links on cron.
- Restrict who can create preview links using the `generate preview links` permission.
- Restrict who can change default preview-link behavior with `administer preview link settings`.
- Let QA test a page's rendered output (including Layout Builder) before publication.
- Provide editors a shareable link for social/marketing sign-off on unpublished campaigns.
- Preview a translation or forward revision of an entity before it is made live.
- Build an editorial approval flow where approvers open a preview link rather than logging in.
- Limit preview access to only the entity types you opt in, leaving others untouched.
- Reference the tokenised preview URL from an external notification or email.
- Grant a one-off preview to an anonymous user without changing content visibility.
- Revoke access to previously shared drafts by letting links expire or resetting tokens.
