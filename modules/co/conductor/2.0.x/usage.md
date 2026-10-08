<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Writing Assistant embeds the hosted Conductor SEO/AI writing assistant as a Canvas extension, reaching the Conductor API through a credentialed Drupal-side proxy and storing credentials via the Key module.

---

Writing Assistant (module machine name `conductor`, info.yml name "Writing Assistant") integrates
Conductor — a content-writing and SEO optimization platform (Acquia SEO Content Insights) — with
Canvas, bringing writing/SEO guidance into the content-authoring experience. It depends on the `canvas`
module and the `key` module. It ships a front-end Canvas extension plus a Drupal-side proxy
(`/conductor/proxy/**`) that relays requests to the Conductor API (`api.conductor.com`) with the site's
Conductor credentials attached, an entity-to-draft mapping API and a small local table that links
Canvas entities to Conductor draft UUIDs (with a per-year draft quota), a drafts dashboard at
`/admin/reports/conductor`, and an opt-in cron cleanup of orphaned Conductor-side drafts.

Use it where content teams use Conductor for SEO-driven writing guidance and want that surfaced while
authoring in Canvas. The Conductor credentials are an `api_key` and `shared_secret` pair supplied as a
JSON value; because the module integrates the Key module, store them as a Key (environment or another
secure provider), never in plaintext config. Content or topic data is sent to Conductor's service for
analysis — a data-handling consideration. The module defines two permissions: `use conductor` (gates
the Canvas-extension proxy, the draft/settings API endpoints and the drafts dashboard, for content
editors) and `administer conductor` (restricted; gates the settings form only).

---

- Integrate Conductor writing/SEO guidance.
- Surface SEO guidance while authoring.
- Integrate with Canvas.
- Store Conductor credentials via Key.
- Depend on canvas and key.
- Provide its own permissions.
- Keep API credentials out of plaintext.
- Bring SEO guidance to authors.
- Send topic data to Conductor.
- Support SEO-driven writing.
- Handle credentials securely.
- Use Key for the API token.
- Assist content optimization.
- Guide writing for SEO.
- Integrate a writing assistant.
- Configure the Conductor connection.
- Mind data sent to the service.
- Have an admin permission.
- Improve content for search.
- Author with SEO feedback.
