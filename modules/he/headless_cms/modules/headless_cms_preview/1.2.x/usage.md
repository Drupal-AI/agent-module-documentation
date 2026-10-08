<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lets content editors preview unpublished node content and revisions from an external decoupled frontend via JSON:API, using per-render preview tokens.

---

Headless CMS - Preview bridges Drupal's editorial preview into a decoupled frontend. For node bundles you enable, it adds a **Save Preview** button to the edit form; saving stashes the in-progress (unsaved) node in a private tempstore and shows the editor ready-to-open **Preview URLs** — one per configured consumer — plus the raw preview token. Each consumer defines its own preview and revision URL templates (with placeholders like `[preview:entity_uuid]` and `[preview:token]`), so the same draft can be opened in each frontend. The frontend fetches the draft through a dynamically-registered JSON:API preview route (`/{jsonapi-path}/{uuid}/preview`) or the standard individual resource, passing the token in the `X-Headless-Preview-Token` header. A custom authentication provider and `hook_entity_access` implementation grant the request access to exactly the previewed entity (and its referenced children, e.g. paragraphs), and a custom JSON:API include resolver returns the draft values of referenced entities. The node revision overview page is also augmented with per-revision preview links. Preview responses are marked no-cache so anonymous frontends always get fresh data. Preview tokens can optionally be encrypted with an Encrypt profile selected on the settings page. Configuration lives at `/admin/config/headless-cms/preview` (enabled bundles + encryption profile) and on each consumer entity (URL templates).

---

- Preview an unsaved draft of a node in a decoupled frontend before publishing.
- Preview a specific historical node revision in the frontend.
- Give editors one-click "Save Preview" from the node edit form.
- Show per-consumer preview URLs directly on the edit form.
- Support multiple frontends, each with its own preview URL template.
- Use placeholder tokens (`[preview:entity_uuid]`, `[preview:token]`, …) in consumer URLs.
- Fetch draft content over JSON:API with a preview token header.
- Resolve referenced draft entities (paragraphs, media) in the preview response.
- Add per-revision preview links to the node revision history page.
- Enable preview only for selected node bundles.
- Optionally encrypt preview tokens with an Encrypt profile.
- Serve preview data uncached so editors always see the latest draft.
- Integrate editorial preview into Next.js / Nuxt / Astro draft-mode flows.
- Let editors verify layout/rendering in the real frontend before going live.
- Preview content per consumer without publishing it site-wide.
- Combine with Preview - NATS to live-reload the frontend on re-save.
- Support previewing new (not-yet-saved) nodes as well as existing ones.
- Keep the standard Drupal editorial workflow while decoupled.
