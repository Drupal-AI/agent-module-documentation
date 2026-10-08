Data Layer builds a JavaScript `window.dataLayer` array on each page and pushes an object of Drupal page/entity metadata into it, so client-side tools (Google Tag Manager, analytics, personalization scripts) can read structured data about what is being viewed without custom code.

---

The module renders an inline `<script>` at the bottom of every non-admin page that does `window.dataLayer = window.dataLayer || []; window.dataLayer.push({ ... })`. The pushed object always includes site-wide defaults (site name, language, country, current user uid) and, when a content entity is the page's route subject, entity metadata: type, bundle, id, title, plus any selected entity properties, taxonomy terms referenced by the entity, and opted-in field values. All of this is driven by config at `datalayer.settings` (admin form route `datalayer.settings_form`, path `/admin/config/search/datalayer`, gated by the core `administer site configuration` permission). The JSON keys are themselves configurable (e.g. `entityType`, `entityBundle`, `siteName`), so you can match an existing GTM data-layer contract. Fields are exposed individually via a per-field third-party setting (`datalayer.expose`) added to the field settings form. Optional features include information-architecture path components, Group module support, current-user detail exposure limited by URL pattern and role, and loading Google's `data-layer-helper` library. The output is assembled in a `#lazy_builder` (cache context `user`) so it stays correct per user while the rest of the page caches. Modules extend or rewrite the payload through several alter/collect hooks (`hook_datalayer_alter`, `hook_datalayer_meta`, `hook_datalayer_field_alter`, and entity-type-specific variants).

---

- Feed page and entity metadata to Google Tag Manager without writing custom dataLayer JS.
- Expose the current node's content type and bundle to GTM triggers and variables.
- Push the viewed entity's id and title so analytics events can be attributed to specific content.
- Include taxonomy terms an entity references (by vocabulary) for content-category tracking.
- Surface the site name, language, and country as global variables for every page.
- Track the current user's uid on every page for logged-in vs anonymous segmentation.
- Expose selected user roles and user metadata on chosen URL patterns for role-based personalization.
- Opt individual fields into the dataLayer (per-field "expose" setting) to publish product SKUs, prices, or codes.
- Rename dataLayer JSON keys to match an existing analytics data contract (e.g. `entityType` → `contentType`).
- Emit information-architecture breadcrumbs (primary/sub category) derived from the URL path.
- Add arbitrary entity properties (e.g. `created`, `changed`, `status`) globally or per entity type.
- Integrate Group module so a node's owning group name is available client-side.
- Keep the dataLayer off admin routes to avoid leaking editorial metadata.
- Load Google's `data-layer-helper` library to read the dataLayer as a state object in custom scripts.
- Alter the whole payload in code via `hook_datalayer_alter` (e.g. lowercase values, strip PII).
- Add computed or third-party data to the dataLayer from a custom module.
- Remove author uid for anonymous/admin authors before output via a meta alter hook.
- Reshape exposed field values (e.g. drop the text format from a formatted field) with `hook_datalayer_field_alter`.
- Provide a stable per-page JSON contract for A/B testing and personalization vendors.
- Populate a customer-data-platform payload with entity and user attributes.
- Map metatag field values into the dataLayer for SEO/analytics reconciliation.
- Drive consent-aware analytics by branching on the exposed user role data.
- Give front-end frameworks a server-rendered snapshot of the current entity.
- Standardize event context (content type, section, language) across multiple tracking vendors.
- Debug what metadata a page exposes by reading `window.dataLayer` in the browser console.
