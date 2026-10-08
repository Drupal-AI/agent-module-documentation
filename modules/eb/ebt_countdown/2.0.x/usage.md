<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Countdown adds a reusable "EBT Countdown" block content type that renders an animated FlipDown countdown timer to a chosen date.

---

Part of the Extra Block Types (EBT) family, this module ships a `ebt_countdown` block_content type with a required `field_ebt_countdown_date` (datetime), an optional `body`, and the shared `field_ebt_settings` field driven by a countdown-specific settings widget (`ebt_settings_countdown`). The widget adds a color theme (dark/light), a style (default / New Year), and editable headings for the days/hours/minutes/seconds labels, on top of EBT Core's design options (margins, borders, padding, background, container width). On the front end, the target date is emitted into a `data-date` attribute as a Unix timestamp and the settings are passed to `drupalSettings` by EBT Core; `js/ebt_countdown.js` reads them and initializes the bundled `levmyshkin/flipdown` JavaScript library. Blocks can be placed through Block layout or Layout Builder, and the optional "New Year" style attaches decorative CSS (snowflakes).

---

- Add a landing-page countdown to a product launch, sale start, or release date.
- Show an event countdown (conference, webinar, concert) in a sidebar or hero region.
- Display a "New Year" themed countdown with the built-in snowflake decoration.
- Build a coming-soon / maintenance page with a live countdown block.
- Place a countdown inside Layout Builder on a specific node or landing page.
- Create a reusable custom block once and place it in multiple regions via Block layout.
- Localize the timer by overriding the Days/Hours/Minutes/Seconds heading labels.
- Switch between dark and light countdown color themes to match a section's background.
- Add supporting rich-text copy above the timer using the block's Body field.
- Apply EBT Core design options (margin, padding, border, radius, background color/image) per block.
- Render an edge-to-edge or fixed-max-width countdown section using EBT Core container settings.
- Count down to a flash-sale deadline for an e-commerce promotion.
- Add a registration-deadline countdown for a course or membership signup.
- Use as a ticket-sale or early-bird pricing deadline indicator.
- Show a fundraising campaign end-date countdown.
- Provide a "next episode / next stream" countdown on a media site.
- Compose several EBT blocks (countdown plus CTA/hero) into a promotional page.
- Reuse EBT Core's global Primary/Secondary colors and responsive breakpoints across countdown blocks.
- Translate countdown blocks per language (the block type and settings field are translatable).
- Give editors a no-code way to publish an animated countdown without custom theming.
