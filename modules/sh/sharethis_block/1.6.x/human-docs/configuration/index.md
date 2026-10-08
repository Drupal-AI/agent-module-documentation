# Configuration

Configuring ShareThis Block is two short steps: fill in the settings form, then
place the block.

## Open the settings form

1. Log in as a user with the **Administer sharethis_block** permission (the only
   permission this module adds).
2. Go to **Configuration → User interface → Sharethis**, or navigate directly to
   `/admin/config/user-interface/sharethis`.

## The fields

| Field | What to enter |
|---|---|
| **Property ID** *(required)* | Your ShareThis account's property id. On sharethis.com, open **Get The Code** and copy the value that appears after `#property=`. |
| **Inline or sticky** *(required)* | Choose **Inline** to place the buttons yourself via a block region, or **Sticky** to let ShareThis pin them to the edge of the page. |

Behind the scenes these are stored as `sharethis_property` and `sharethis_inline`
in the `sharethis_block.configuration` config object. You can also set them from
the command line:

```bash
ddev drush cset sharethis_block.configuration sharethis_property "your-property-id" -y
ddev drush cset sharethis_block.configuration sharethis_inline 1 -y
```

(`sharethis_inline` = `1` for Inline, `0` for Sticky.)

The module builds the ShareThis script URL from these values —
`//platform-api.sharethis.com/js/sharethis.js#property=<your id>&product=<type>`,
where the product type is `inline-share-buttons` for Inline or
`sticky-share-button` for Sticky.

## Place the block

The settings alone don't display anything — you also need to place the block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **ShareThis** block (plugin id `sharethis`) in the region you want.

How placement behaves depends on your layout choice:

- **Inline** — the block outputs a `<div class="sharethis-inline-share-buttons">`
  where ShareThis injects the buttons, so the block's region controls exactly where
  they appear. Place it in a content region for per‑page share buttons, or a
  global region to show them site‑wide.
- **Sticky** — the buttons are positioned by ShareThis itself (configured on
  sharethis.com), so the block only needs to load the script; its region isn't
  visually significant.

## Where the rest is configured

The button set, the networks offered, and the styling all live in your ShareThis
account on sharethis.com — not in Drupal. You can change them there at any time
without redeploying your site. If you need to theme the block wrapper, an override
template `block--sharethis.html.twig` is available.

Because the property id sits in the URL fragment (after `#`), swapping it — for
example between staging and production — can also be done with a config override in
`settings.php` rather than editing the form.
