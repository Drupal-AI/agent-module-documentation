# Configuration

Better Social Sharing Buttons has one global settings form. The settings you pick
there apply everywhere the buttons render, unless a specific block instance
overrides them.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Web services → Better Social Sharing Buttons
   settings**, or navigate directly to
   `/admin/config/services/better_social_sharing_buttons/config`.

## The settings, field by field

- **Icon set** — choose between two styles: **colored square** icons
  (`social-icons--square`, the default) or **flat/monochrome** icons
  (`social-icons--no-color`) that inherit your theme's color. The colored icons
  can be recolored in your theme by overriding the `--bss-color1` … `--bss-color15`
  CSS custom properties.
- **Services (networks)** — the list of supported networks, each with an
  enable/disable toggle and a drag‑and‑drop order. The first enabled entry renders
  first. Out of the box, **Facebook, X, Email, and LinkedIn** are enabled and
  everything else is off. The full set you can turn on is: `facebook`, `x`,
  `whatsapp`, `facebook_messenger`, `email`, `pinterest`, `linkedin`, `xing`,
  `tumblr`, `reddit`, `truth` (Truth Social), `bluesky`, `evernote`, `print`,
  `copy` (copy the page URL to the clipboard), and `telegram`.
- **Width** — the icon size (height matches width), given as a CSS length. Default
  `20px`; set it to, say, `32px` for larger icons.
- **Radius** — the icon corner radius. `0px` gives square icons, `3px` (the
  default) gives slightly rounded corners, and `100%` gives fully circular icons.
- **Print CSS** — the absolute path to a print stylesheet. This is **required for
  the Print button** to do anything; leave it blank if you are not using Print.
- **Facebook App ID** — **required for the Facebook Messenger button**. Without a
  valid App ID, that button will not work; leave it blank if you are not using
  Messenger.
- **Expose as a node field** — when on, the buttons become a pseudo‑field
  available on all node types. You then position it under the content type's
  **Manage display**.
- **Expose as a paragraph field** — the same idea for paragraphs, useful with
  Layout Builder or paragraph‑based pages.

Save the form when you're done.

## Placing the buttons

You have three options, and you can mix them:

- **Block** — go to **Structure → Block layout**
  (`/admin/structure/block`) and place the **Better Social Sharing Buttons**
  block (plugin `social_sharing_buttons_block`) into a region such as a sidebar
  or footer. The block form repeats the same options (services, icon set, width,
  radius, Facebook App ID, print CSS); any value you set on the block
  **overrides** the global settings for that placement only. This is how you give
  one placement a different network mix than the site default.
- **Field** — turn on **Expose as a node field** and/or **Expose as a paragraph
  field** above, then arrange the "Better Social Sharing Buttons" pseudo‑field in
  the entity's **Manage display**.
- **Twig (with Twig Tweak)** — print the block anywhere in a template:

  ```twig
  {{ drupal_block("social_sharing_buttons_block") }}
  ```

## Good to know

- Buttons are plain `target="_blank"` links to each network's own share URL — no
  external API or tracker calls. Because the links use the *current* page's URL
  and title, place the buttons on canonical content pages (nodes) rather than
  listing pages.
- All icons load once from a single minified SVG sprite, so adding more networks
  does not add more HTTP requests.
- Developers can alter the generated buttons in code with
  `hook_better_social_sharing_buttons_block_items_alter()` (for the block) or
  `hook_better_social_sharing_buttons_node_items_alter()` (for the node field) —
  for example to swap in a campaign/canonical URL or force a share title.
