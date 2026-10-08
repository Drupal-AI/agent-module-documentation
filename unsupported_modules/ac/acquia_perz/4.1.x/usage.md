<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia Personalization (Perz) integrates a Drupal site with Acquia's Personalization / Content Index Engine (CIS) service, rendering selected entity view modes for export so the service can serve personalized, segment-targeted content and collect visitor data.

---

The module rides on `acquia_connector` for its subscription/credentials and adds three things: a settings form at `admin/config/services/acquia-perz/settings` (config object `acquia_perz.settings`) covering the API endpoint region, identity capture, field and UDF (User Defined Field) mappings, visibility path patterns and advanced content-replacement options; a per-bundle **"Acquia Personalization" opt-in** injected into every entity *Manage display* form (`hook_form_entity_view_display_edit_form_alter`) that records, in `acquia_perz.entity_config` under `view_modes.<entity_type>.<bundle>.<view_mode>`, which view modes are exported plus a render role, preview-image field, personalization label field and an optional boolean "only export specific entities" field; and page attachments that inject the Personalization JS library and page/path context metadata when the current path passes the visibility `path_patterns` filter. Only entities implementing `EntityPublishedInterface` can be made available. The main module by itself only fires a lightweight "decision webhook" on entity insert/update/delete — the actual content export/queue machinery lives in the bundled **acquia_perz_push** submodule, which must be installed for Personalization to receive content (its absence is reported by `hook_requirements`). Site identity is a generated 6-char site hash stored in state, and the module migrates a Site ID from `acquia_lift` if that legacy module is present. Regions map to per-continent CIS endpoints (us/eu/ap/demo).

---

- Expose the Article "full" view mode to Acquia Personalization so the service can serve it as personalized content.
- Opt specific content-type/view-mode combinations in or out of personalization from the Manage display screen.
- Choose which user role a personalized entity is rendered as (e.g. anonymous) before it is exported.
- Pick a bundle image field to use as the preview image for a personalized entity variation.
- Designate a text field on a bundle as the "personalization label" used when exporting to the service.
- Restrict export to individual entities by pointing at a boolean field ("only export specific entities").
- Configure the Personalization API region endpoint (Americas, Europe, Asia-Pacific, Demo).
- Map Drupal fields to content section / content keywords / persona metadata for segmentation.
- Map fields to Acquia UDF person, touch, and event slots for visitor profile data.
- Enable identity capture so a URL parameter identifies the visitor to the service.
- Limit where the Personalization JS runs using visibility path patterns (e.g. exclude /admin, /node/add).
- Turn on dynamic JavaScript support so per-element libraries are attached on rendered pages.
- Override Acquia Lift meta tags when migrating from the older acquia_lift module.
- Reuse an existing Acquia Lift Site ID automatically when upgrading a Lift site to Perz.
- Collect anonymous visitor data (page and path context) for analytics and A/B testing.
- Push published nodes, taxonomy terms, and custom blocks to the Content Index Engine (with acquia_perz_push).
- Bulk re-export all site content to Personalization via Drush (with acquia_perz_push).
- Automatically export a node when it is published and remove it from the service when unpublished/deleted.
- Personalize content per-segment without building the decisioning logic yourself in Drupal.
- Surface a Personalization configuration health check on the site status report.
- Drive a headless/decoupled personalization experience where Drupal is the content source of truth.
- Standardize which view mode is used for personalization across many bundles.
