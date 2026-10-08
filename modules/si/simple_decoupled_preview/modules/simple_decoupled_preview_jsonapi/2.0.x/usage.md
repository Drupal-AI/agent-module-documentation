<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Decoupled Preview JSON:API exposes node previews on JSON:API, which is what lets a decoupled front end fetch content that has not been saved.

---

JSON:API serves saved entities. A preview, by definition, is not one — the editor is looking at a node revision that exists only in the form state, and a front end asked to render it has nothing to request. This submodule bridges that: it makes the preview available on the JSON:API surface so the front end's preview route can fetch it like any other resource, using the same client, the same includes and the same field mapping it uses for published content.

It is a hard dependency of `simple_decoupled_preview` rather than an optional add-on, so it is enabled as part of that module and not chosen separately. Its two dependencies, `node` and `jsonapi`, are both core.

The thing to review before go-live is access. This endpoint serves **unpublished, unsaved** content by design, so whatever the front end authenticates with must be scoped and secret, and the preview resource's access should be inspected rather than inherited on trust from JSON:API's normal entity access. That is the single most important review item in a decoupled preview setup, and it belongs here rather than in the parent module.

---

- Fetch an unsaved node from a decoupled front end.
- Render a draft in a Next.js preview route.
- Reuse the site's JSON:API field mapping for previews.
- Include referenced entities in a preview response.
- Serve preview content to a static site generator's draft mode.
- Support preview for selected content types.
- Keep the preview client identical to the published-content client.
- Review access on the preview resource before go-live.
- Scope the front end's credentials to preview only.
- Diagnose a preview that returns no content.
- Preview a translation from a decoupled front end.
- Confirm the endpoint is not reachable anonymously.
- Limit which bundles expose previews.
- Trace a preview request from the front end to Drupal.
- Rotate the front end's preview credentials.
