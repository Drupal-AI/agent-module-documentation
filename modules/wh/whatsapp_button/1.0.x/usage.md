Adds a configurable block that renders a floating WhatsApp click-to-chat button linking to api.whatsapp.com with a pre-filled number and message.

---

WhatsApp Button ships one Block plugin (`whatsapp_button_block`, admin label "WhatsApp Button", category "Custom") that you place like any other block. Every setting lives on the block instance form, so different placements can point at different numbers or messages. You configure the destination phone number, a welcome message that is pre-loaded into the chat, a hover tooltip, and optionally some text shown beside the icon. The icon defaults to the module's bundled WhatsApp SVG but can be replaced with an uploaded image (jpg/jpeg/png/svg/webp/avif). Layout is controlled with a bottom/right offset plus a unit selector (px/rem/em/%/vh/vw), and you can enable separate image-width and position overrides for tablet and desktop breakpoints through generated CSS media queries. The rendered anchor points at `https://api.whatsapp.com/send?phone=<number>&text=<message>` and opens in a new tab. The module depends only on Drupal core and provides no routes, permissions, services, or Drush commands.

---

- Add a floating "chat with us on WhatsApp" button to every page of a marketing site.
- Give a storefront a one-click order channel with a pre-filled "Hello, I want to place an order!" message.
- Place the button only in specific regions or on specific pages using core block visibility conditions.
- Run two button instances (e.g. sales vs. support) pointing at different WhatsApp numbers.
- Provide a localized greeting message per language by placing a separate block per language with visibility conditions.
- Replace the default WhatsApp logo with a brand-matched custom icon uploaded through the block form.
- Show explanatory text beside the icon ("Contact us here") instead of an icon-only button.
- Set a hover tooltip that warns the visitor a new tab will open.
- Pin the button a fixed distance from the bottom-right corner of the viewport.
- Use rem/em/%/vh/vw units instead of pixels for position and image sizing to fit a fluid theme.
- Shrink or enlarge the button icon on tablets versus phones using the tablet image-width override.
- Use a larger icon and different corner offset on wide desktop screens via the desktop overrides.
- Define custom tablet/desktop breakpoint widths so the media-query overrides trigger at your theme's breakpoints.
- Add a contact button to a documentation or knowledge-base theme without writing any custom CSS.
- Offer a quick support contact on a landing page or campaign microsite.
- Give an event or booking page an instant WhatsApp enquiry link with the event name pre-filled in the message.
- Provide a restaurant or delivery site with a tap-to-order WhatsApp button on mobile.
- Add a real-estate or classifieds listing page a "message the seller" button.
- Let a single-page portfolio site expose a WhatsApp contact affordance in the corner.
- Prefill a support ticket reference or product SKU into the chat message for context.
- Combine with block placement per content type so the button only appears on product pages.
- Swap the icon for a seasonal or promotional badge image without touching code.
- Disable the block title (per the README) so only the floating icon shows.
