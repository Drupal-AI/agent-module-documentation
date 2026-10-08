<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Decoupled Preview lets a headless front end render an editor's unsaved node preview, by serialising the draft to JSON:API, storing it, and exposing it through a REST endpoint and an iframe on Drupal's preview page.

---

Preview is the hard part of a decoupled build: the editor works in Drupal, the rendering happens elsewhere, and the draft being previewed is not saved anywhere the front end can fetch. Core's JSON:API can serialise a node preview, but only for the same authenticated user who created it (the draft lives in that user's tempstore), so a separately authenticated front end cannot read it. This module bridges the gap. When an editor clicks **Preview** on a configured content type, a submit handler serialises the in-memory node to JSON:API format via the bundled `simple_decoupled_preview_jsonapi` submodule and saves it as a `preview_log_entity` keyed by the node UUID, language and previewing user id. Drupal's preview page then shows a `decoupled_preview` view mode whose only output is an `<iframe>` pointing at your configured `preview_callback_url` with `/{bundle}/{uuid}/{langcode}/{uid}` appended; your front-end preview page loads in that frame and calls back to the REST endpoint `/api/preview/{uuid}?uid=…&langcode=…` to fetch the stored JSON and render it. On the settings form you choose the callback URL, which node bundles are previewable, and which JSON:API relationships (`includes`) to embed. Turning it on requires enabling the **Simple Decoupled Preview JSON** REST resource (GET, `json`, and your auth providers) in the REST UI provided by the `restui` dependency, granting the resource's access permission to the front end's role, and — per content type — enabling the Preview button and the **Decoupled Preview** view mode. A cron task deletes expired log entities (`log_expiration` defaults to one day, `delete_log_entities` defaults to true) so the table stays small, and every preview is recorded as a log entity with its own admin list, views data and access handler for troubleshooting. Core requirement is `^10.2 || ^11`, framework-agnostic (Gatsby, Next.js, or any front end that can consume the iframe and call the API).

---

- Preview an unsaved node in a decoupled front end.
- Send an editor's Preview button to a Next.js or Gatsby preview route.
- Serialise a draft node to JSON:API format for a headless renderer.
- Fetch stored preview JSON from a front end via `/api/preview/{uuid}`.
- Limit preview support to selected content types.
- Embed referenced entities in the preview payload with JSON:API includes.
- Preview unsaved referenced (paragraph/media) entities alongside the node.
- Preview a translation before it is published.
- Render the preview inside an iframe on Drupal's preview page.
- Point the preview iframe at a local dev URL or a production front end.
- Consume the preview from any front-end framework, not just one.
- Log every preview request as an entity for troubleshooting.
- List and filter preview logs in a view.
- Diagnose why a preview failed for a specific editor.
- Expire old preview log entities automatically on cron.
- Keep the preview log table small on a busy editorial site.
- Choose the JSON:API relationship depth returned per content type.
- Reuse Drupal's authentication providers for the preview API.
- Separate who may configure preview from who may read its logs.
- Give a front-end team a stable, versioned preview contract.
- Support draft mode in a statically generated site.
- Replace a bespoke or Gatsby-only preview integration.
- Keep preview configuration in exported config.
