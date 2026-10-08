ShareThis Block displays the third-party ShareThis social-share buttons on a Drupal site by loading the ShareThis JavaScript for your account's property ID, in either an inline (block-placed) or sticky (page-edge) layout.

---

Configuration lives at *Configuration → User interface → Sharethis*
(`/admin/config/user-interface/sharethis`, permission `administer sharethis_block`): you enter your
ShareThis **Property ID** (obtained from your ShareThis account) and choose **Inline** or **Sticky**. The
module stores these as `sharethis_block.configuration:sharethis_property` and `sharethis_inline` (bool).
`hook_library_info_alter` rewrites the `sharethis.core` asset library's remote/JS URL, substituting your
property ID and the product type (`inline-share-buttons` vs `sticky-share-button`) into
`//platform-api.sharethis.com/js/sharethis.js#property=<id>&product=<type>` — so the ShareThis platform
script is loaded from ShareThis's CDN. A `ShareThis` block plugin attaches that library; when Inline is
selected the block also renders `<div class="sharethis-inline-share-buttons"></div>` where ShareThis injects
the buttons, so you place the block in the region you want. For the Sticky layout the buttons are positioned
by ShareThis itself (configured on the ShareThis site) and the block only needs to load the script. The
actual button set, styling, and networks are all managed on sharethis.com; this module just wires the script
and property ID into Drupal. There is a `block--sharethis.html.twig` template and a `sharethis.ajax` library
helper. Note ShareThis is a commercial, non-GPL external service (the library is marked `gpl-compatible:
false`) that runs third-party JS and its own tracking on pages where the block appears.

---

- Add ShareThis social-share buttons to a Drupal site via a placeable block.
- Load the ShareThis platform script for your account using your property ID.
- Show **inline** share buttons positioned wherever you place the ShareThis block.
- Show **sticky** share buttons pinned to the side/bottom of the page by ShareThis.
- Configure the property ID and layout from a single settings form.
- Restrict who can change ShareThis settings with the `administer sharethis_block` permission.
- Place the inline buttons in a specific theme region through Block layout.
- Switch between inline and sticky layouts without editing code.
- Reuse a ShareThis account/configuration (button set, networks) managed on sharethis.com.
- Provide share-to-social functionality without hand-embedding the ShareThis snippet in a template.
- Theme the block wrapper via the `block--sharethis` template suggestion.
- Serve share buttons across all pages by placing the block globally.
- Quickly enable social sharing on articles/landing pages for a marketing campaign.
- Change the displayed networks/button style entirely from the ShareThis dashboard, no redeploy.
- Enable social sharing without writing a custom block or JS integration.
- Load the ShareThis script only on pages where the block is placed.
- Give content editors share buttons on nodes by placing the block in a content region.
- Swap ShareThis property IDs (e.g. staging vs production) via config override in settings.php.
- Track share activity through your ShareThis account's analytics for the configured property.
