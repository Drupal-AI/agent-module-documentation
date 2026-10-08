Configurable Drupal block that renders social-media share buttons and an optional Copy Link button for the current page.

---

Simple Social Share provides a single block plugin (`simple_social_share_block`, category "Social") that builds share links to nine platforms — Facebook, Twitter/X, LinkedIn, WhatsApp, Telegram, Pinterest, Reddit, Tumblr and Email — using the current page's URL and title. Each platform is individually toggled in the block's configuration form, and a Copy Link button (enabled by default) lets visitors copy the page URL to the clipboard via a small JavaScript behavior. On node canonical pages and taxonomy-term canonical pages the shared link points at a short redirect route (`/n/{node}` and `/t/{taxonomy_term}`) that 302-redirects to the canonical entity page; on any other route the block shares the current absolute URL. Each button opens the target platform's own share dialog in a popup window. The module depends only on core `block` and `config`, ships platform icon SVG templates plus a CSS/JS library, provides no permissions, no config schema, no Drush commands, and stores no visitor data server-side.

---

- Add share buttons to article/blog node pages by placing the block in a region on `entity.node.canonical`.
- Add share buttons to taxonomy term listing pages via `entity.taxonomy_term.canonical`.
- Show share buttons site-wide (header, footer, sidebar) via standard block layout placement and visibility conditions.
- Enable only a curated subset of platforms (e.g. just Facebook, LinkedIn, Email) by unchecking the rest in the block form.
- Offer a WhatsApp/Telegram share button tailored to mobile-heavy audiences.
- Provide a Pinterest "Pin it" button on image-rich content pages.
- Provide a Reddit submit button for developer/community content.
- Add an Email "share via email" button that pre-fills subject (page title) and body (URL).
- Give visitors a one-click Copy Link button to grab the page URL without opening a share dialog.
- Expose short, clean share URLs (`/n/123`) instead of long aliased paths when sharing nodes.
- Run multiple block instances with different platform sets in different regions or on different content types.
- Restrict where buttons appear using core block visibility (by path, content type, role, or language).
- Style the buttons to match a theme by overriding `css/social-share.css` or the block template.
- Override the icon set by overriding the per-platform `templates/icons/<platform>.svg.twig` files.
- Override `simple-social-share-block.html.twig` in a theme to change button markup or layout.
- Localize the button `aria-label`s and copy-confirmation announcement through Drupal's translation system.
- Add accessible sharing with built-in `aria-label`s and a `Drupal.announce()` "Link copied" message.
- Deploy a lightweight, SDK-free sharing widget that adds no third-party tracking scripts to the page.
- Configure share behavior entirely through the block UI with no separate settings page to manage.
- Ship sharing on a decoupled-friendly, dependency-light stack (only core block + config).
