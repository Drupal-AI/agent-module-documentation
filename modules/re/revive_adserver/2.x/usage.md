<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Renders ad zones from a self-hosted Revive Adserver instance in Drupal, either as a placeable block or as a field on any fieldable entity, using async-JS, iframe or classic-JS invocation tags.

---

Revive Adserver (self-hosted, formerly OpenX) is an open-source ad server; this module emits its zone invocation tags inside Drupal. You configure a delivery URL, a publisher id and a set of ad zones once at `/admin/config/services/revive-adserver` (zones can be synced from the Revive XML-RPC API), then place ads two ways: the "Revive Adserver Zone Block" block plugin (pick a zone + delivery method per block), or a "Revive Adserver Zone" field you attach to a content entity (pick the zone per entity, and optionally let editors choose the delivery method per entity). Each of the three delivery methods — Asynchronous JavaScript, iframe, and legacy JavaScript — is a swappable InvocationMethodService plugin producing the exact `<ins>`/`<script>`/`<iframe>` markup Revive expects. Because ad tags load third-party scripts and can track visitors, gate them behind cookie/tracking consent where your jurisdiction requires it.

---

- Display banner ads from a self-hosted Revive/OpenX instance on a Drupal site.
- Place an ad zone in any theme region using the Revive Adserver Zone Block.
- Attach an ad zone to nodes, taxonomy terms, users or any fieldable entity via the field type.
- Choose Asynchronous JavaScript delivery (the modern `<ins data-revive-zoneid>` + `asyncjs.php` tag).
- Choose iframe delivery (`afr.php` framed banner) when you need script-free embedding.
- Choose legacy JavaScript delivery (`ajs.php` document.write tag) for older Revive setups.
- Sync the list of ad zones (id, name, width, height) from Revive over its XML-RPC API.
- Populate a zone select list for editors so they pick a named zone instead of typing an id.
- Let content editors pick the delivery method per entity by enabling "invocation method per entity".
- Whitelist which zones a given field may select on the entity form.
- Whitelist which delivery methods editors may choose per entity.
- Prevent the same banner from showing twice on one page ("block banner").
- Prevent two banners from the same campaign on one page ("block banner campaign").
- Serve ads over HTTP or HTTPS transparently (the async/JS tags pick the page protocol).
- Restrict ad administration to trusted roles via the "administer revive_adserver" permission.
- Restrict who may set a zone id on an entity via the "use revive_adserver field" permission.
- Show a status-report warning until the delivery URL, publisher id and zones are configured.
- Gate ad scripts behind a cookie/consent solution to meet GDPR/e-privacy requirements.
- Render multiple different zones on one page (multiple blocks or a multi-value field).
- Use a single field to show a different zone per node (e.g. an in-article ad slot).
- Migrate from a legacy OpenX/Revive JS snippet to a managed, configurable Drupal block.
- Keep Revive login credentials out of Drupal (they are used only during a manual zone sync).
