<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block plugin: `facebook_block` (FacebookBlock)

Class `Drupal\facebook_block\Plugin\Block\FacebookBlock` (`src/Plugin/Block/FacebookBlock.php`),
extends core `BlockBase`. Annotation:

```php
@Block(
  id = "facebook_block",
  admin_label = @Translation("Facebook Block"),
  category = @Translation("Facebook Block"),
)
```

## Install & place

1. `composer require drupal/facebook_block` then `drush en facebook_block -y` (or enable at
   `/admin/modules`). It pulls in core `block`.
2. Go to **Structure → Block layout** (`/admin/structure/block`), click *Place block* in a region,
   find **"Facebook Block"** (its own category), and place it. Requires the core
   **`administer blocks`** permission — there is no module-specific permission.

## Configuration (block config form)

`blockForm()` / `blockSubmit()` expose and persist three keys into the block's `configuration`:

| Key      | Form field           | Type      | Default      | Meaning |
|----------|----------------------|-----------|--------------|---------|
| `fb_id`  | *Facebook ID*        | textfield | `facebook`   | The page slug; used to build `https://www.facebook.com/<fb_id>`. Description: "Your Facebook ID. Eg. facebook". |
| `width`  | *Image width in pixels*  | number | `500` | Maps to `data-width`. |
| `height` | *Image height in pixels* | number | `700` | Maps to `data-height`. |

`defaultConfiguration()` seeds `fb_id=facebook, width=500, height=700`. `blockSubmit()` returns
early if `$form_state->hasAnyErrors()`, otherwise copies the three submitted values.

There is **no config schema** shipped with the module (`config/schema/` absent), so these keys have
no typed-config definition; they are stored in the block config entity as-is.

## What `build()` emits

`build()` assembles a render array of core `#type => container` elements (attributes rendered
through Drupal's `Attribute` object, i.e. auto-escaped):

- `root-div`: `<div id="fb-root">` (the SDK's required root).
- `block`: `<div class="fb-page" data-href="https://www.facebook.com/<fb_id>"
  data-width="<width>" data-height="<height>" data-show-posts="TRUE">` — the standard Facebook
  Page-plugin container. `data-show-posts` is hardcoded to `'TRUE'`.
- a nested `child` container with class `fb-xfbml-parse-ignore`, containing a link element (see
  caveat below).
- `#attached['library'][] = 'facebook_block/facebook_block'`.

The `data-href` is always `https://www.facebook.com/` + the admin-entered `fb_id`; there is no
free-form URL field, and Drupal never fetches this URL server-side — the browser SDK does.

## The JS loader (`facebook_block.js`)

Library `facebook_block/facebook_block` (`facebook_block.libraries.yml`) loads `facebook_block.js`
with deps `core/jquery`, `core/drupal`. The script:

- binds `jQuery(window).on('load', …)`;
- after a `setTimeout(…, 1000)` (1 second), injects a `<script id="facebook-jssdk">` whose `src` is
  the hardcoded `//connect.facebook.net/en_IN/sdk.js#xfbml=1&version=v2.5`;
- guards against double-injection via `document.getElementById('facebook-jssdk')`.

Facebook's SDK then parses the `fb-page` markup (XFBML) and renders the live page feed in the
browser. Locale `en_IN` and SDK `version=v2.5` are fixed in the source and not configurable.

## Caveats

- The inner `child['blockquote']` uses `#type => 'link'` with a `#href` key; core's Link render
  element expects `#url` (a `Url` object), so this fallback link may render empty/incorrectly. It
  does not affect the Page-plugin embed, which is driven entirely by the `fb-page` container.
- `data-width` / `data-height` fall back to `''` when unset (`?? ''`).
- Because everything is client-side and the SDK is Facebook's, the block adds Facebook as a
  third-party origin and loads its tracking script — gate behind cookie/consent tooling if needed.
