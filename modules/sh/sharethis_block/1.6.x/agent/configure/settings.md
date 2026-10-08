# Configure ShareThis Block

Settings form at **Configuration → User interface → Sharethis**
(`/admin/config/user-interface/sharethis`, route `sharethis_block.configuration`, form
`SharethisConfigurationForm`). Permission: **`administer sharethis_block`** (defined in
`sharethis_block.permissions.yml`; this is the only permission the module adds).

## Fields → config

| Form field | Config key (`sharethis_block.configuration`) | Type | Notes |
|---|---|---|---|
| Property ID (required) | `sharethis_property` | string | The ShareThis account property id (from sharethis.com → "Get The Code", the value after `#property=`). |
| Inline or sticky (required) | `sharethis_inline` | bool | `1`/Inline or `0`/Sticky. |

Set via Drush:

```bash
ddev drush cset sharethis_block.configuration sharethis_property "5ece3dfd9d73fec01243b231" -y
ddev drush cset sharethis_block.configuration sharethis_inline 1 -y
```

## How the script URL is assembled

`hook_library_info_alter()` (`sharethis_block.module`) rewrites the `sharethis.core` library's remote/JS
entry, substituting placeholders in
`//platform-api.sharethis.com/js/sharethis.js#property=PROPERTYID&product=PRODUCT_TYPE`:

- `PROPERTYID` → `sharethis_property`.
- `PRODUCT_TYPE` → `inline-share-buttons` when `sharethis_inline` is true, else `sticky-share-button`.

The script is loaded from ShareThis's CDN (external, `async`, marked `gpl-compatible: false`). Because the
property id is placed in the URL **fragment** (after `#`), it does not affect which host/script is fetched.

## Placing the block

Add the **sharethis** block (plugin id `sharethis`) at **Structure → Block layout** in the region you want.
The block plugin (`Plugin/Block/ShareThis`):

- Always attaches library `sharethis_block/sharethis.core` (loads the ShareThis script).
- In **Inline** mode also renders `<div class="sharethis-inline-share-buttons"></div>` — the anchor where
  ShareThis injects the inline buttons, so placement/region controls where they appear.
- In **Sticky** mode the buttons are positioned by ShareThis itself (configured on sharethis.com); the block
  only needs to load the script, so its region placement is not visually significant.

The button set, networks, and styling are all managed on the ShareThis site, not in Drupal. Template
override available via `block--sharethis.html.twig` (`hook_theme` registers `block__sharethis`).
