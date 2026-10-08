<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookies Addons Blocks withholds a placed Drupal block until the visitor consents to a configured COOKiES service, replacing it with a placeholder overlay and AJAX-loading the real block on consent.

---

A submodule of Cookies Addons. `cookies_addons_blocks_preprocess_block()` inspects each block's `#id`; if that id appears in the `cookies_addons_blocks.settings:blocks` textarea (one `block_id|service` per line), it replaces the block's `#content` with a `<div class="cookies-addons-blocks-placeholder" data-cookies-service data-service-name data-block-id>` and attaches the `cookies_addons_blocks/cookies-addons-blocks` JS library. That behavior listens for the COOKiES `cookiesjsrUserConsent` event; when the block's service is accepted it POSTs `/cookies-addons-blocks/get-block/{block_id}/{service}`, whose `CookiesAddonsBlocksController::getBlock()` renders the block entity and returns an AJAX `ReplaceCommand` for the placeholder; when denied it shows the COOKiES `cookiesOverlay`. Admins configure the block list at `/admin/config/system/cookies-addons-blocks` (permission `administer site configuration`). Gating is skipped on POST requests so the AJAX re-render itself is not re-gated.

---

- Defer loading of a map, social-feed or other external-service block until consent.
- Pick which placed blocks are gated by listing `block_id|service` lines in the settings form.
- Map each gated block to any existing COOKiES `cookies_service` entity.
- Show a consent placeholder with the service's label in place of the block.
- Auto-load the block via AJAX the instant its service is consented to, without reload.
- Fall back to the raw service machine name as the placeholder label if the service entity is missing/disabled.
- Keep a marketing/analytics block off the initial page load to satisfy GDPR/ePrivacy.
- Reuse one COOKiES service to gate several blocks that share the same third party.
- Deploy gating decisions as config (`cookies_addons_blocks.settings`).
- Combine with other Cookies Addons submodules to gate paragraphs, views and fields too.
