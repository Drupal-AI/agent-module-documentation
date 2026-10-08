AddToAny adds social share and follow buttons to Drupal content, powered by the hosted AddToAny universal sharing platform that supports Facebook, Mastodon, Pinterest, WhatsApp, email and hundreds of other services.

---

AddToAny renders a set of share buttons — a "universal" sharing button plus any specific service buttons you list — on nodes, media, comments and other content entities. It attaches the buttons as a pseudo-field (via `hook_entity_extra_field_info`) so site builders position them on any Manage Display screen, and it also provides two blocks: a share block and a follow block. Which entity types show buttons, the icon size, the universal button style, and the raw HTML of buttons are controlled from one settings form at Admin → Configuration → Web services → AddToAny. Buttons are output through overridable Twig templates (`addtoany-standard.html.twig`, `addtoany-follow.html.twig`) with per-entity-type and per-bundle theme suggestions. The front-end behavior loads AddToAny's external `page.js` script from their CDN. Developers can extend the list of supported entity types with the `hook_addtoany_entity_types_alter` hook and build share markup programmatically with helper functions. The module is lightweight, has no PHP library dependencies, and only requires core's Node module.

---

- Add social share buttons below every article and blog post.
- Show a universal "share" button that expands to hundreds of services.
- Display specific service buttons (Facebook, Mastodon, Pinterest, email) inline.
- Place a share block in a sidebar or region via the Block layout.
- Add a "follow us" block linking to your brand's social profiles.
- Enable share buttons on media entities such as images and videos.
- Enable share buttons on comments so replies can be shared.
- Control button icon size (e.g. 16, 32) site-wide.
- Choose the universal button style or supply a custom button image URL.
- Position the universal button before or after the other buttons.
- Restrict which entity types display buttons from a single settings form.
- Inject custom AddToAny HTML to add or reorder specific service buttons.
- Add custom CSS or JS snippets to tweak the sharing widget.
- Override the share button markup with a theme-level Twig template.
- Provide different button layouts per content type using bundle theme suggestions.
- Let a WhatsApp share button appear on mobile for messaging shares.
- Position share buttons precisely using the Manage Display pseudo-field.
- Share the canonical URL and title of each entity automatically.
- Add taxonomy term pages to the shareable entity types via an alter hook.
- Generate AddToAny share markup in custom code with `addtoany_create_data()`.
- Track social shares through AddToAny's platform analytics.
- Give a Views field that outputs a node's share buttons in a listing.
- Restrict administration of sharing settings to trusted roles via permission.
- Standardize social sharing UI across a multi-site or multi-section install.
- Encourage readers to reshare content and grow referral traffic.
