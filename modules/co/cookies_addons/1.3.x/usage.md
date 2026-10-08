<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookies Addons is a bundle of submodules for the COOKiES consent framework that withhold blocks, paragraphs, views, entity fields and text-format iframe/YouTube embeds until the visitor consents to the matching cookies service, then loads the real content (via AJAX for the entity types).

---

The top-level `cookies_addons` module ships no code of its own — it is an empty container in the COOKiES package whose only job is to depend on `cookies` and group six functional submodules: `cookies_addons_blocks`, `cookies_addons_paragraphs`, `cookies_addons_views`, `cookies_addons_fields`, `cookies_addons_embed_iframe` and `cookies_addons_embed_video`. Each submodule targets one Drupal content mechanism. The block/paragraph/view/field submodules replace the rendered element with a `<div>` placeholder carrying `data-cookies-service` / entity-id attributes and attach a JS behavior that listens for the COOKiES `cookiesjsrUserConsent` event; when the required service is accepted, the behavior calls a module route that re-renders and AJAX-replaces the placeholder, and when it is denied it shows the COOKiES `cookiesOverlay`. The two embed filters (`cookies_addons_embed_iframe`, `cookies_addons_embed_video`) are text-format filter plugins that rewrite matching `<iframe src>` to `data-src` at filter time so the browser never loads the third party until consent restores `src`. Admins configure which blocks/paragraphs/views are gated in simple textarea settings forms (`id|service`, `id|service`, or `view|display|service` per line); field gating is a per-formatter third-party setting on Manage display. The purpose is GDPR/ePrivacy compliance: stop third-party content and its cookies/trackers from loading before consent.

---

- Enable only the COOKiES add-on submodules you need — the parent `cookies_addons` module alone does nothing.
- Gate a Drupal block (e.g. a Google Maps or social-feed block) behind consent by listing `block_id|service` at `/admin/config/system/cookies-addons-blocks`.
- Show a consent placeholder overlay in place of a blocked block until the visitor accepts the matching service.
- Auto-load a gated block via AJAX the moment its cookies service is consented to, without a page reload.
- Gate a Paragraphs entity (e.g. an embedded-map or external-widget paragraph) by listing `paragraph_id|service` at `/admin/config/system/cookies-addons-paragraphs`.
- Load a gated paragraph on consent through the `cookies_addons_paragraphs.get_paragraph` AJAX route.
- Gate a full view display (e.g. a Leaflet map view) by listing `view_id|display_id|service` at `/admin/config/system/cookies-addons-views`.
- Pass contextual-filter arguments through to a gated view when it is loaded on consent.
- Auto-attach the Leaflet libraries when a gated `leaflet` view is loaded post-consent.
- Gate an individual entity field (map field, external embed widget, tracking pixel field) by choosing a Cookies service in that field's formatter settings on Manage display.
- Reuse any COOKiES service (YouTube, Google Maps, Matomo, a custom service) as the consent gate for a block, paragraph, view or field.
- Fall back to the service label as the placeholder name when the referenced cookies service entity is missing or disabled.
- Block all non-YouTube `<iframe>` embeds inside CKEditor/formatted text with the "Block iframes" filter, which requires the built-in `iframe` cookies service.
- Block YouTube (and youtube-nocookie) video iframes in formatted text with the "Block YouTube videos" filter, deferring to the COOKiES Video service placeholder.
- Restore an iframe's original `src` only after the browser confirms the visitor's consent, keeping YouTube/Vimeo/maps from setting cookies pre-consent.
- Enforce that only `http`/`https` (or root-relative) iframe sources are re-activated on consent (the embed-iframe JS rejects other protocols).
- Meet GDPR/ePrivacy "load third-party content only after consent" requirements across many content types with one consent UI.
- Add the built-in "Iframes other than YouTube" cookies service and "Iframes" service group automatically when enabling the embed-iframe submodule.
- Recover from the historical `cookies_addons_embed_viedeo_filter` typo automatically via update hook `8001` when upgrading the embed-video submodule.
- Combine several submodules on one site (e.g. embed filters for editorial content plus block/view gating for placed components).
- Keep gating decisions server-side in config so they are deployable and translatable rather than hard-coded in templates.
