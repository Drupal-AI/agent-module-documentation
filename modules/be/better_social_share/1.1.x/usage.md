<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Better Social Share adds "share this page" buttons for Facebook, X/Twitter, LinkedIn, WhatsApp, Pinterest, email and over a hundred other platforms, without loading any third-party widget scripts.

---

Install it like any module (`composer require drupal/better_social_share`, then enable it — it depends on core **Node** and **Block**) and configure the site-wide defaults at **Configuration → Web services → Better Social Share** (`/admin/config/services/better-social-share`), where you pick which platforms appear and in what order, set the icon size, colours, the "More" popup button, an optional row label, and tick which entity types may show the buttons. Because these are **plain share links** — ordinary anchors to each platform's own sharer URL, opened only when a visitor clicks — the module sets no cookies and contacts no third party on page view, so it does not trigger a GDPR cookie-consent requirement the way script-based share widgets do. There are three ways to place the buttons: drop the **Better Social Share Buttons** block into a region (it has its own per-block platform, style and left/right float settings), enable the **Better Social Share** field on a content type's *Manage display* (after ticking that entity type in settings), or add the **Better Social Share Buttons** field to a View. What actually gets shown when someone shares is your page's Open Graph metadata, not the button — so if previews look bare, that is a metatag/`og:image` job, not a Better Social Share setting. Only the `administer better_social_share` permission (restricted) can reach the settings form; per-block settings follow normal block-placement permissions. You can restyle any single button by copying its Twig partial from `templates/template-parts/` into your theme.

---

- Add share buttons to article pages.
- Let readers share the current page to WhatsApp.
- Share content to LinkedIn or Facebook.
- Add social sharing without third-party tracking scripts.
- Avoid a cookie-consent requirement for share buttons.
- Place a floating share bar down the side of the page.
- Put share buttons in a block region.
- Show share buttons on a specific content type only.
- Add a share-buttons column or field to a View.
- Offer an email or SMS share option.
- Give visitors a one-click "copy link" button.
- Let users share to Telegram, Reddit, or Pinterest.
- Support regional/international platforms (VK, Line, Weibo, Kakao, …).
- Choose exactly which platforms appear and their order.
- Set the icon size, colour, and rounded style.
- Add a "More" popup exposing the full platform list.
- Show platform name labels beside each icon.
- Restyle one platform button by overriding its Twig partial.
- Configure a share block differently per placement.
- Increase social referral traffic from content.
- Support a marketing or campaign landing page.
- Add sharing to product or event pages.
