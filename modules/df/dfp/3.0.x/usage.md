DFP (Doubleclick for Publishers) integrates Google Publisher Tags (GPT / Google Ad Manager) into a Drupal site: you define reusable **ad tag** config entities and the module injects the `googletag` JavaScript and ad slots into the page head, optionally exposing each tag as a placeable block.

---

The module provides a `dfp_tag` config entity (`admin_permission = "administer DFP"`) describing one ad slot: slot name, size(s), ad unit pattern, slug, responsive `breakpoints` (browser-size → ad sizes), key/value `targeting`, and AdSense backfill settings. Global behaviour lives in the `dfp.settings` config object (network ID, default ad unit pattern, click URL, async vs sync rendering, disable-initial-load, single-request, collapse-empty-divs, default slug, global targeting, and an ad-test unit pattern). Rendering is done by a **decorator** service, `dfp.html_response.attachments_processor`, which decorates core's `html_response.attachments_processor`: when a page carries `dfp_slot` attachments it injects the GPT loader (`dfp-js-head-top`), one `googletag.defineSlot` block per tag (`dfp-slot-definition-js`), and a settings/targeting block (`dfp-js-head-bottom`) into `<head>`. Each tag can be output as a Drupal block (a block derivative per tag, `Plugin/Block/TagBlock` + `Derivative/TagBlock`) placed via the core Block UI, or as a JavaScript-free "short tag" (an image link) for email. Ad unit patterns and targeting values support **tokens** (`dfp.tokens.inc` adds `[dfp_tag:slot]` and `[dfp_tag:network_id]`; the `dfp.token` service resolves `[current-page:*]` etc.). Four alter hooks (`hook_dfp_target_alter`, `hook_dfp_global_targeting_alter`, `hook_dfp_short_tag_keyvals_alter`, `hook_dfp_tag_alter`) let other modules adjust targeting and tags. An admin "test page" and a `?adtest=true` URL flag route all ad units through the ad-test unit pattern so a campaign can be previewed. All admin routes are gated by the single `administer DFP` permission. Depends on core `block`.

---

- Serve Google Ad Manager / DFP display ads on a Drupal site via Google Publisher Tags.
- Define a reusable ad slot (size, ad unit, targeting) once as a `dfp_tag` and reuse it site-wide.
- Set the Google **Network ID** once globally and have all tags inherit it.
- Place an ad in a region by enabling the tag's auto-generated block in the Block layout.
- Build a responsive ad slot that swaps ad sizes at configured browser-width breakpoints.
- Add page-level key/value **targeting** (e.g. `section=sports`) for ad selection.
- Add per-tag targeting on top of the global targeting.
- Insert tokens like `[dfp_tag:slot]` or `[current-page:url:args:value:0]` into an ad unit pattern.
- Render ads **asynchronously** (default) to avoid blocking page render, or switch to sync mode.
- Disable the initial ad fetch so ads load only on a later `refresh()` (e.g. gallery "next").
- Combine all ad requests into a **single request** to reduce round-trips.
- Collapse empty ad divs (never / only-if-empty / expand-if-served) to control layout gaps.
- Show an "Advertisement" slug label above ads, and hide it when no ad is served.
- Preview a campaign by appending `?adtest=true` to any URL (uses the ad-test unit pattern).
- Output a JavaScript-free "short tag" (image link) for ads embedded in email.
- Configure AdSense backfill (image/text ad types, channel IDs, colours) when inventory runs out.
- Set a DFP click URL (sync mode) to intercept ad clicks for reporting.
- Programmatically alter a tag's targeting from another module via `hook_dfp_tag_alter()`.
- Add URL-argument-based global targeting via `hook_dfp_global_targeting_alter()`.
- Manage all ad tags from one admin list at *Structure › DFP Ad Tags*.
- Expose a `dfp_tag` token type to other token-aware fields.
- Restrict all ad-tag management to trusted editors with the `administer DFP` permission.
- Migrate a legacy DoubleClick setup to GPT-based tagging.
