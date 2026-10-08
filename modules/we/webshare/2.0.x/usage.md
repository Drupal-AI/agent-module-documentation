Webshare adds configurable social-sharing buttons and an optional native Web Share API button to a Drupal site, placed as a block, a Views field, or a Drupal Canvas component.

---

Webshare renders a "Share" rail of social buttons for the current page. Enabled platforms (LinkedIn, Facebook, X, WhatsApp, copy-to-clipboard and more) are stored in a dedicated `webshare_platforms` database table and managed at `/admin/config/services/webshare`, where administrators drag to reorder, toggle each platform on or off, and add fully custom platforms by supplying a URL template with `[url]` / `[title]` placeholders and an uploaded icon. Rendering goes through a single-directory component (`webshare:share`) plus a `share` Block plugin, so the rail can be dropped into theme regions via Block layout, shown per-row as a Views field on nodes or commerce products, or placed on content templates in Drupal Canvas (the component falls back to the `webshare_share_data()` Twig function to resolve the current page's links). Presentation — heading/title, start-or-end alignment, horizontal/vertical orientation, mobile visibility, and inline vs. sticky "rail" placement — is configured on the block or component. An optional native share button triggers `navigator.share()` on supporting browsers and copies the URL to the clipboard as a desktop fallback. Icons are library-agnostic: bundled SVGs are used by default, but any platform (and the native button) can be mapped to the Drupal Core Icons API or the `ui_icons` contrib packs via configuration. Recipes can drive the platform set declaratively through config-action plugins (`saveSocialPlatform`, `enableSocialPlatform`, `disableSocialPlatform`, `deleteSocialPlatform`, `reorderSocialPlatforms`, `setSocialPlatforms`).

---

- Add a "Share" button rail to article, news, or any content pages.
- Place the Share block in a theme region via Block layout.
- Show share buttons per-row in a Views listing of nodes.
- Add share buttons to a commerce product listing View.
- Drop the share component onto a content template in Drupal Canvas.
- Offer LinkedIn, Facebook, X and WhatsApp share links out of the box.
- Provide a copy-to-clipboard "Copy URL" button for the current page.
- Enable a native Web Share API button that opens the mobile share sheet.
- Fall back to clipboard copy on desktop browsers without native share.
- Add a fully custom platform (e.g. Instagram, Mastodon) with a URL template and icon.
- Enable additional bundled networks (Telegram, Reddit, Pinterest, Threads, Bluesky, Tumblr, Email).
- Reorder platforms by drag-and-drop on the settings form.
- Toggle individual platforms on or off without deleting them.
- Choose start- or end-side (RTL-aware) alignment for the button rail.
- Lay buttons out horizontally (a row) or vertically (a column).
- Float the rail as a sticky column beside the content (rail-end placement).
- Hide the share rail on mobile, or show it only on mobile.
- Give the rail a custom heading and pick its semantic heading level.
- Map platform icons to a Drupal Core Icons API pack (bootstrap_icons, phosphor, etc.).
- Map the native share button to an Icons API icon instead of the module logo.
- Keep the share rail cache-tag aware so enabling/disabling a platform clears cached pages.
- Provision the platform set declaratively from a recipe via config actions.
- Enable, disable, delete, or reorder platforms from a recipe with one action each.
- Declare the exact enabled platform set and order with `setSocialPlatforms`.
- Reuse an uploaded custom icon across a site by copying it into the module's icon set.
- Build the share render array programmatically via the `webshare.service` API.
