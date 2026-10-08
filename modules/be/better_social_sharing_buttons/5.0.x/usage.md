Better Social Sharing Buttons adds lightweight, tracker-free social share buttons to a Drupal site via a block, a node pseudo-field, and a paragraph field, rendered from an inlined SVG sprite.

---

The module ships a single settings form at `/admin/config/services/better_social_sharing_buttons/config` (route `better_social_sharing_buttons.config`, gated by the core `administer site configuration` permission) that writes one config object, `better_social_sharing_buttons.settings`. There you pick which of the ~16 supported networks are enabled and their order, choose one of two icon sets (colored `social-icons--square` or monochrome `social-icons--no-color`), and set the icon `width` (size) and corner `radius`. The same options are exposed per-instance on the "Better Social Sharing Buttons" block (plugin id `social_sharing_buttons_block`), whose block-level values override the global settings for that placement. Each button is a plain anchor to the network's own share URL opened in a new tab — no external API calls, tracker scripts, or ad-server connections — and all icons come from a single minified SVG sprite loaded once. Sharing links carry the current page URL and title, so it is intended for canonical content pages (nodes). Facebook Messenger needs a Facebook App ID and Print needs a print CSS file before those two buttons work. The buttons can also be exposed as a field on nodes and paragraphs (toggled by the `node_field` / `paragraph_field` settings) or printed anywhere in Twig with `drupal_block("social_sharing_buttons_block")` via Twig Tweak. A companion submodule, `better_social_sharing_buttons_per_node`, lets editors turn the buttons on or off on individual nodes.

---

- Add a row of social share buttons to article and blog pages via a block placed in a sidebar or footer region.
- Offer privacy-friendly sharing with no third-party tracker scripts, ad-server calls, or external JavaScript.
- Enable a specific set of networks (e.g. Facebook, X, LinkedIn, WhatsApp) and hide the rest.
- Reorder the buttons by drag-and-drop weight so the most-used network appears first.
- Switch between colored square icons and flat monochrome icons that inherit your theme's color.
- Make the icons circular by setting the border radius to `100%`, or square with `0px`.
- Resize the icons site-wide (e.g. from the default `20px` up to `32px`) to match a design.
- Recolor the square icons by overriding the `--bss-colorN` CSS custom properties in your theme.
- Add a WhatsApp share button that works on both mobile and desktop web.
- Add a Bluesky, Truth Social, Telegram, or Reddit button for niche communities.
- Provide an "Email this page" share link without a contact form.
- Add a "Copy current page URL to clipboard" button for quick manual sharing.
- Offer a print button (with a custom print stylesheet) as a pseudo share action.
- Enable Facebook Messenger sharing by supplying a Facebook App ID.
- Expose the buttons as a node field and position them within a content type's display mode.
- Expose the buttons as a paragraph field for use inside Layout Builder / paragraph-based pages.
- Print the block directly in a node Twig template with `drupal_block("social_sharing_buttons_block")` (Twig Tweak).
- Give one block placement a different network mix than the global default by overriding settings on the block.
- Alter the generated share items (URL, title, services) in code via `hook_better_social_sharing_buttons_block_items_alter()`.
- Let editors toggle sharing buttons on individual nodes using the per-node submodule.
- Keep page weight low: all icons load once from a single minified SVG sprite instead of per-icon requests.
- Add sharing buttons to user and taxonomy term pages (the block resolves the page title on those routes too).
- Pair with Metatag so networks that read Open Graph tags show a rich share preview.
