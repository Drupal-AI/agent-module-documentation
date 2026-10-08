Facebook Block adds a "Facebook Block" block that embeds a Facebook Page plugin (page feed / like box) into any Drupal region using Facebook's official social-plugin SDK.

---

Facebook Block ships one block plugin (`facebook_block`). You place it like any core block and configure three settings: a Facebook ID (the page slug used to build `https://www.facebook.com/<id>`), a width, and a height in pixels. The block renders the standard Facebook Page-plugin markup — an `fb-root` element plus an `fb-page` container carrying `data-href`, `data-width`, `data-height`, and `data-show-posts` attributes — and attaches a small JavaScript loader that injects Facebook's SDK from `connect.facebook.net`, which turns that markup into the live embedded page feed in the visitor's browser. The rendering is fully client-side: Drupal never contacts Facebook server-side. Because the SDK is Facebook's third-party tracking script, sites subject to cookie/consent rules should gate the block accordingly. The module depends only on core's Block module and provides no permissions, settings routes, config forms, or Drush commands of its own; block placement and configuration use core's normal block UI (administer blocks).

---

- Show a Facebook Page feed in a sidebar or footer region.
- Embed a Facebook "like box" style Page plugin on the site.
- Display a brand or organization's latest Facebook posts on the homepage.
- Add a Facebook Page plugin to a specific theme region via the Block layout UI.
- Configure which Facebook page to embed by entering its page slug (Facebook ID).
- Set the embed's width in pixels through the block configuration form.
- Set the embed's height in pixels through the block configuration form.
- Place multiple Facebook Block instances pointing at different pages.
- Restrict the block's visibility to specific pages, roles, or content types using core block visibility conditions.
- Give visitors a direct link to the Facebook page (rendered alongside the embed).
- Load the Facebook SDK only on pages where the block is present.
- Provide a no-code way for site builders to add Facebook content without custom theming.
- Pair the block with a cookie-consent module so the Facebook script loads only after consent.
- Surface community/social activity next to editorial content.
- Keep a marketing landing page's Facebook presence visible without an iframe of your own.
- Swap the embedded page quickly by editing one block setting.
- Use core caching/placement so the same embed appears across many pages.
- Add social proof (follower counts, recent posts) to campaign pages.
- Replace a hand-coded Facebook embed snippet with a maintainable block.
- Disable or remove the block when the site should not load third-party Facebook scripts.
