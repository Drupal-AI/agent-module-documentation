<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facebook Block (facebook_block) — agent index

A single **block plugin** that embeds a **Facebook Page plugin** (page feed / like box) in a
Drupal region. It renders Facebook's Page-plugin markup and attaches a JS loader that pulls
Facebook's SDK from `connect.facebook.net` to render the embed **client-side**. Version **1.0.4**
(doc dir `1.x`). Core `^8.9 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

- **The block plugin, its three settings, the emitted markup, and the SDK loader** →
  [plugins/facebook-block.md](plugins/facebook-block.md)

## What it actually is

- One plugin: `FacebookBlock` (id **`facebook_block`**, admin label / category *"Facebook Block"*)
  in `src/Plugin/Block/FacebookBlock.php`, extending core `BlockBase`.
- Dependency: core **`block`** only (info.yml `dependencies: drupal:block`). **No** permissions,
  routing, services, hooks, `.module`/`.install`, config schema, config/install, or Drush.
- One asset library `facebook_block/facebook_block` (`facebook_block.libraries.yml`) →
  `facebook_block.js`, depending on `core/jquery` + `core/drupal`.

## Mechanism (from source)

- `defaultConfiguration()` → `fb_id: 'facebook'`, `width: 500`, `height: 700`.
- `blockForm()` exposes three fields: **Facebook ID** (textfield, the page slug), **width**
  (number), **height** (number). `blockSubmit()` saves them into `$this->configuration`.
- `build()` returns a render array of core `#type => container` elements: an `fb-root` div, and an
  `fb-page` container whose `#attributes` include `data-href =>
  'https://www.facebook.com/'.fb_id`, `data-width`, `data-height`, and `data-show-posts => 'TRUE'`.
  It attaches library `facebook_block/facebook_block`.
- `facebook_block.js` waits for window `load`, then after a 1s `setTimeout` injects the Facebook
  JS SDK `//connect.facebook.net/en_IN/sdk.js#xfbml=1&version=v2.5` (hardcoded), which parses the
  `fb-page` markup into the live embed. All Facebook contact happens in the browser — Drupal makes
  **no server-side request** to Facebook.

## Placement & config

- No settings page. Place and configure at **Structure → Block layout** (`/admin/structure/block`),
  under the *"Facebook Block"* category; access is core's **`administer blocks`** permission.
  Config is stored in the block config entity (no module-provided schema).

## Notes / caveats

- SDK version is pinned to `v2.5` (an old Graph/SDK version) and the locale to `en_IN` — both
  hardcoded in `facebook_block.js`.
- `build()` also adds a `#type => 'link'` child using a non-standard `#href` key (core's link
  element expects `#url`), so that inner blockquote link may not render as intended; the Page-plugin
  embed itself does not depend on it.
- Loads Facebook's third-party tracking script on every page the block appears — a privacy/consent
  consideration, not a module bug.
