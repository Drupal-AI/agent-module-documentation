<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Voiceflow embeds the Voiceflow conversational chatbot widget across a Drupal site, keyed by a Voiceflow project ID, with configurable path exclusions; its `voiceflow_index` submodule publishes an XML feed of selected published nodes for Voiceflow to ingest.
---
The base module attaches the Voiceflow JavaScript library and passes the configured `project_id` to `drupalSettings` on page load via `hook_page_attachments`, but only when the widget is enabled and the current path does not match one of the excluded path patterns (admin, batch, node add/edit, user sub-pages by default). Everything is driven from the `/admin/config/system/voiceflow` settings form. The `voiceflow_index` submodule adds a per-node "Voiceflow index" flag and exposes `/voiceflow.xml`, a sitemap-style XML feed listing the canonical URLs (with hreflang alternates and last-modified dates) of published nodes that have the flag enabled — giving the Voiceflow assistant a curated content index.

On security posture, the admin surfaces (`voiceflow.settings` and `voiceflow_index.settings`) are gated by `administer site configuration`. The `/voiceflow.xml` route uses `_access: 'TRUE'`, i.e. it is intentionally public: it is a read-only, sitemap-style feed built with an entity query restricted to `status = 1` **and** `accessCheck(TRUE)`, so it exposes only already-public published content (reviewed and considered sound by design). No mutating endpoints, external requests from Drupal, or secrets are involved. Typical setup: enter the Voiceflow project ID, enable the widget, tune excluded paths, and (optionally) flag the nodes to include in the index feed.
---
- Enter the Voiceflow project ID on the settings form.
- Enable or disable the chatbot widget site-wide.
- Exclude admin pages from showing the widget (default).
- Exclude node add/edit and user sub-pages from the widget.
- Add custom path patterns to hide the widget on specific pages.
- Load the Voiceflow JS only where the widget should appear.
- Flag individual nodes for inclusion in the Voiceflow index (submodule).
- Publish `/voiceflow.xml` as a curated content feed for Voiceflow.
- Provide hreflang alternates for translated nodes in the index feed.
- Expose last-modified dates in the index feed for freshness.
- Give a Voiceflow assistant a sitemap-style list of key content URLs.
- Restrict widget/index configuration to site administrators.
- Deliver a conversational assistant on a public-facing site with one project ID.
- Keep the chatbot off batch and multi-step form pages.
- Match excluded paths against the current path alias (not just the system path).
- Ship the widget disabled by default until a project ID is set.
- Curate which content the Voiceflow assistant can discover via per-node flags.
- Serve translated content URLs with correct hreflang to the assistant.