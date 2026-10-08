<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tealium iQ Tag Management injects Tealium's `utag.js` loader into non-admin pages and builds the `utag_data` JavaScript data layer that its tags read, with default, per-entity, context, and token-driven values.

---

The module has two jobs. First, it composes the loader URL from three settings — `account`, `profile`, `environment` — into `https://tags.tiqcdn.com/utag/{account}/{profile}/{environment}/utag.js` (or, when a first-party-domain `fpd_url` is set, `{fpd_url}/{profile}/{environment}/utag.js`) and emits it on every front-end page. Loading is either **asynchronous** (a JS library in `hook_page_attachments` reads `drupalSettings.tealiumiq` and injects the script) or **synchronous** (a Twig template in `hook_page_top`/`hook_page_bottom` writes an inline `var utag_data = {…}` block followed by the `utag.js` `<script>`). An optional `utag.sync.js` can be added to the head, and an "anonymous only" switch suppresses the loader for logged-in users. Second — the real work — it builds the **data layer**: a `Udo` service holds the `utag_data` namespace and a properties array assembled by the `Tealiumiq` service from four layers, applied in order: **defaults** (config `tealiumiq.defaults`, on by `defaults_everywhere`), an **`AlterUdoPropertiesEvent`** other modules subscribe to (the `tealiumiq_context` submodule maps Context reactions here), **per-entity field values**, and a **`FinalAlterUdoPropertiesEvent`** for last-minute renaming. Values may contain `token` patterns (e.g. `[current-page:title]`), resolved against the entity on the current route and reduced to plain text before being JSON-encoded. Per-entity values live in a `tealiumiq` map field: `hook_entity_base_field_info` attaches a computed base field to every canonical content entity for REST normalization, while site builders add the editable "Tealium tags" field through Field UI (its widget serializes the tag values into one column). The tag vocabulary itself is pluggable — `@TealiumiqTag` and `@TealiumiqGroup` annotation plugins (shipped: `page_name`, `page_url` in the `page` group). Configuration is admin-gated behind two `restrict access: TRUE` permissions, `administer tealium settings` and `manage global tealium tags`. Note the design implication: a tag manager can run arbitrary vendor JavaScript on every visitor's page, and anything placed in the data layer is visible in page source to every tag and every reader, so consent handling and PII disclosure are decisions the integrator must own — the module does neither.

---

- Add a Tealium iQ container to a Drupal site by entering account, profile, and environment.
- Serve the loader from a first-party domain via `fpd_url` instead of `tags.tiqcdn.com`.
- Build a `utag_data` data layer that Tealium tags can act on.
- Choose asynchronous or synchronous loading of `utag.js`.
- Load tags at the top or bottom of the page in synchronous mode.
- Also emit `utag.sync.js` in the document head.
- Suppress tracking for authenticated users (anonymous-only mode).
- Set site-wide default data-layer values (e.g. page name, page URL).
- Populate the data layer from entity tokens like `[current-page:title]`.
- Override the data layer per node/entity with a "Tealium tags" field.
- Translate and revision per-entity tag values using core Field/translation.
- Drive tags conditionally with the Context module via `tealiumiq_context`.
- Alter or rename data-layer properties from a custom module via events.
- Expose content type, section, author, or publication date to analytics.
- Pass product or campaign identifiers to marketing tags.
- Run a headless/decoupled site with API-only mode (module emits nothing itself).
- Add custom data-layer variables through `@TealiumiqTag` plugins.
- Consolidate hand-added vendor tracking snippets into one governed container.
- Let marketing manage vendor tags without a Drupal deployment.
- Expose per-entity Tealium tags to REST/JSON consumers via the computed base field.
- Support a multi-brand or group-wide tag governance policy.
- Switch between Drupal (`Json::encode`) and PHP (`json_encode`) data-layer serialization.
- Audit what marketing scripts run on the site's pages.
