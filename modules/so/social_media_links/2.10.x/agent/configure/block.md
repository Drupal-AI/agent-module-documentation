# Place & configure the block

Block plugin `social_media_links_block` (`src/Plugin/Block/SocialMediaLinksBlock.php`). Place
it at **Structure → Block layout → Place block** in any region; all options live in the block
config form (settings are stored in the block config entity — no separate admin page).

## Form sections
- **Platforms** — one row per network. Pick the platform (Facebook, X, Instagram, …) and enter
  only the value (username / id / path). The platform's `urlPrefix`/`urlSuffix` build the full
  URL, so `acme` under `twitter` (prefix `https://x.com/`) → `https://x.com/acme`. Rows are
  draggable to set order; each can override description/weight.
- **Appearance**
  - `iconset` — which Iconset plugin renders the icons (default set includes `fontawesome`,
    `elegantthemes`, `nouveller`, `icomoon`).
  - `icon size / style` — style keys the chosen iconset exposes via `getStyle()` (e.g. Font
    Awesome `2x`, `3x`, `lg`, `fw`).
  - `orientation` — horizontal or vertical.
- **Link attributes** — `target` (e.g. `_blank`), `rel` (e.g. `nofollow noopener`), extra
  classes applied to every link.

## Notes
- Icon assets: Font Awesome uses the bundled `social_media_links/fontawesome.component`
  library, or the site-wide `fontawesome` module if enabled. Other sets are located by
  `social_media_links.finder` (`IconsetFinderService`) under the libraries directory.
- A Twig extension (`social_media_links.twig.extension.safe_link`) provides a safe-link filter
  used by the templates; override `templates/*.html.twig` in your theme to change markup.
- The same platform list is reusable as a field — see the `social_media_links_field` submodule.
