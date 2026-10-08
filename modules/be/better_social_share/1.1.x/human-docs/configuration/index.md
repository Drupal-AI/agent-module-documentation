# Configuration

Setting up Better Social Share is two steps: choose which platforms you want on
the settings form, then place the share block where it should appear.

## 1. Choose the platforms

1. Log in as a user with the **Administer better social share** permission (this
   permission is restricted, so grant it deliberately).
2. Go to **Configuration → Better Social Share**
   (`/admin/config/…/better_social_share`).
3. Configure which platforms' share buttons appear.

The module offers a very long platform list, but resist the urge to switch on
dozens. **Pick the two or three your audience actually uses** — every extra button
dilutes the ones that matter.

## 2. Place the share block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the Better Social Share block in a region — for example under the main
   content on article pages.
3. Use the block's visibility settings (for example by content type) to show it
   only where you want, such as on articles or product pages.
4. Save the block.

## Getting good share previews

The buttons are plain share links, so what a visitor sees when they share is
determined by your page's **Open Graph metadata**, not by this module. If a shared
link comes out as a bare text preview with no image, that is an Open‑Graph
problem — typically a missing default share image — handled by the Metatag module,
not here.
