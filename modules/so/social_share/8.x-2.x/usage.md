Social Share provides contextually configurable social-share buttons through a pluggable "social share link" plugin type, exposed via a field type, a field formatter and a block, with Typed Data token replacement in every share parameter.

---

Social Share (8.x-2.x) is a from-scratch Drupal 8+ rewrite that ships a `social_share_link` plugin type plus default plugins for Facebook, Twitter/X, LinkedIn, Pinterest, WhatsApp, e-mail, and generic Print and PDF links. Editors surface links two ways: a `social_share_link` field (options-buttons widget) whose `Social share link` formatter renders the selected providers, or a `Social share links` block that can restrict/order providers and optionally take a content entity as token context. Each plugin declares its own context parameters (title, shared text, URL, description, hashtags, app id, etc.); those values accept Typed Data placeholder tokens (e.g. `{{ node.title.value }}`) resolved against the surrounding entity at render time, and the literal `<current>` resolves to the current page URL. Every provider renders through a dedicated overridable Twig template, share URLs are simple query strings, and a small `social_share/popup` library opens sharing dialogs in a centered popup window — no third-party tracking scripts are loaded. Requires the Typed Data module.

---

- Add a "Social share link" field to a content type and let editors tick which networks appear per node.
- Use the "Social share link" formatter on the manage-display screen to render the chosen share buttons.
- Configure per-formatter context values (title, URL, description) with Typed Data tokens drawn from the host entity.
- Place the "Social share links" block in a region to show share buttons site-wide or per page.
- Restrict and reorder the providers shown in a block by listing plugin IDs (one per line) in the block's "Allowed plugins" textarea.
- Pass a node (or other content entity) into the block as token context so share text/URLs reflect the current content.
- Share the current page automatically by leaving a URL context set to the special value `<current>`.
- Add Facebook share links using a configurable app id, title, description, caption and preview image URL.
- Add Twitter/X tweet-intent links with pre-filled text, hashtags, `via`, related accounts and reply-to.
- Add LinkedIn share-article links with title, summary and source parameters.
- Add Pinterest pin-creation links seeded with an image URL, title and hashtags.
- Add WhatsApp share links whose message combines a custom text and the shared URL.
- Add "Share via e-mail" links that open the user's mail client with a pre-filled subject and body.
- Offer a "Print" link that appends a query parameter (default `print=1`) to the current URL for print styling.
- Offer a "PDF" link that appends a query parameter (default `pdf=1`) to hand off to a PDF-generation route.
- Theme each network independently by overriding its `social-share-link-<network>.html.twig` template.
- Style buttons as icons using the per-network CSS classes (e.g. `social-share-facebook`, `social-share-twitter`).
- Provide template suggestions per block or per entity/field/view-mode for granular markup control.
- Build a completely custom set of share providers by adding new `SocialShareLink` annotated plugins in a custom module.
- Reuse shared context names (e.g. `title`, `url`, `hashtags`) across plugins so one form field configures several networks at once.
- Localize/customize link text via each plugin's `*_link_text` context value (e.g. "Share on Facebook").
- Keep a privacy-first share bar that avoids external social SDK JavaScript and its visitor tracking.
- Combine share buttons with any entity type (nodes, media, taxonomy terms) since context comes from Typed Data.
