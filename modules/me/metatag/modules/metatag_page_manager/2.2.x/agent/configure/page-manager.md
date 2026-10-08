# Meta tags on Page Manager variants

Page Manager pages are custom routes, not entity canonical routes, so they don't inherit
entity meta tags. This submodule adds Metatag configuration to Page Manager **variants**:

- Edit a page's variant in Page Manager (`/admin/structure/page_manager`).
- A Metatag section lets you set title/description/OG and other tags for that variant.
- Values are token-enabled and rendered into the page `<head>` when the variant is served.
- Requires `page_manager` (CTools) and works with any Metatag tag submodule you enable.

No config schema of its own — tags are stored on the Page Manager variant configuration.
