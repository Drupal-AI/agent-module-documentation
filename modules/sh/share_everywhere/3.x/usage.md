<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Share Everywhere adds customisable social share buttons (Facebook like & share, X/Twitter, LinkedIn, Messenger, Viber, WhatsApp, and Copy URL) to Drupal content, designed to blend into a custom theme rather than use the social networks' default widgets.

---

All behaviour is driven by one config object, `share_everywhere.settings`, edited on a single form at `/admin/config/services/share_everywhere` (route `share_everywhere.config_form`, permission "administer share everywhere"). You choose which buttons are enabled and their order/labels/images, a share icon, a title, alignment, collapsible behaviour, and whether the module's CSS/JS is included. Buttons can be surfaced four ways: (1) as an **extra field** named `share_everywhere` on node and Commerce product view displays (when `location` = `content`) — enabled per content type and per view mode via the settings form and placed on *Manage display*; (2) inside the node's **links** area (`location` = `links`); (3) via the **"Share Everywhere Block"** block plugin (`share_everywhere_block`); and (4) via a **Views field** (`share_everywhere_field`). A `per_entity` mode adds a "Show social share buttons" checkbox to individual node/product forms and stores which entities are enabled in `enabled_entities`. Rendering goes through the `share_everywhere.service` service and a set of theme hooks/templates (`share-everywhere`, `se-facebook-like`, `se-facebook-share`, `se-x`, `se-linkedin`, `se-messenger`, `se-viber`, `se-whatsapp`, `se-copy-url`), so the markup is fully themeable and the bundled SASS/CSS can be turned off. It depends only on `path_alias`; Commerce and Markdown are optional integrations.

---

- Add themeable social share buttons to article and page nodes.
- Show share buttons on Commerce product pages (with the Commerce module).
- Enable only specific networks (e.g. just Facebook share, X, and Copy URL).
- Reorder the share buttons via per-button weights.
- Customise each button's title/tooltip and image.
- Provide a one-click "Copy site URL" button.
- Add a Facebook Like button that doesn't break the site's layout.
- Place share buttons as a block anywhere via the Share Everywhere Block.
- Add a share-buttons column/field to a View using the Views field plugin.
- Render buttons as an extra field on chosen content types and view modes.
- Show buttons only on the full view mode, not teasers.
- Put buttons in the node links area instead of the content region.
- Toggle sharing per individual node/product with the per-entity checkbox.
- Restrict buttons from appearing on specific paths (restricted pages).
- Left- or right-align the button row to fit the design.
- Make the button set collapsible behind a share icon.
- Disable the module's CSS/JS to fully style buttons in your own theme.
- Swap button icons for custom SVGs to match branding.
- Set a custom heading/title above the buttons (or hide it).
- Add WhatsApp/Viber/Messenger sharing for mobile-heavy audiences.
- Override any button template (e.g. `se-x.html.twig`) in a theme.
- Use the `share_everywhere.service` build() method to render buttons programmatically.
- Keep share markup consistent across nodes, products, blocks, and views.
- Gate access to the settings form with the "administer share everywhere" permission.
