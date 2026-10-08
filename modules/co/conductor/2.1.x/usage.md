<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Writing Assistant embeds the hosted Conductor SEO/AI writing assistant into Drupal Canvas and opted-in node edit forms, reaching the Conductor API through a credentialed Drupal-side proxy and storing its credentials via the Key module.

---

Writing Assistant (module machine name `conductor`, info.yml name "Writing Assistant", package SEO) integrates Conductor — a content-writing and SEO optimization platform (Acquia SEO Content Insights) — with Drupal Canvas, bringing writing and SEO guidance into the content-authoring experience. It ships a prebuilt front-end app registered as a Canvas extension, and can also embed that app on the edit form of selected node content types via a "Writing Assistant" button that opens an AJAX dialog. The app talks to the Conductor API (`api.conductor.com`) through a Drupal-side proxy at `/conductor/proxy/**` that attaches the site's stored Conductor credentials, so browser code never handles the secret. It maps Canvas/node entities to Conductor draft UUIDs in a local table (`conductor_draft_map`) with a per-year draft quota and a per-draft content score, exposes a small draft-mapping API and a settings API for the front-end, and provides a drafts dashboard at `/admin/reports/conductor`. Credentials are supplied as JSON in a Key entity — either an `api_token` bearer token (recommended) or a legacy `api_key` + `shared_secret` pair — and only the chosen key's id is stored in config. An opt-in cron job can clean up orphaned Conductor-side drafts, and deleting an entity soft-deletes its local draft mapping. It depends on the `canvas` and `key` modules and targets Drupal core `^11`.

---

- Bring Conductor SEO/AI writing guidance into the Canvas authoring experience.
- Add a "Writing Assistant" extension button to the edit form of selected node content types.
- Surface real-time SEO recommendations and content scoring while authoring.
- Proxy front-end calls to the Conductor API without exposing credentials to the browser.
- Store Conductor credentials securely in a Key entity instead of plaintext config.
- Authenticate to Conductor with a bearer `api_token` (recommended) or a legacy `api_key` + `shared_secret` pair.
- Map Canvas or node entities to Conductor draft UUIDs in a local table.
- Enforce a per-year cap on how many Conductor drafts a site may create.
- Persist a 0–100 content score per draft and display it in the dashboard.
- Review current-year drafts, their entities, dates, scores, and status on an admin dashboard.
- Deep-link from the dashboard to each draft in the Conductor web app.
- Choose which content types embed the Writing Assistant on their node form.
- Insert Conductor-generated content into a node's formatted-text fields from the dialog.
- Support NDJSON streaming responses from Conductor for progressive generation.
- Automatically clean up orphaned "Untitled Canvas draft:" drafts on cron (opt-in).
- Keep draft mappings tidy by soft-deleting them when their entity is deleted.
- Test the Conductor connection from the settings form after selecting a key.
- Report draft-quota usage (used vs. maximum) for the current year.
- Restrict who can use the assistant vs. who can administer it via two permissions.
- Integrate an SEO platform's content insights directly into editorial workflows.
- Give marketing and content teams keyword and optimization feedback in Drupal.
