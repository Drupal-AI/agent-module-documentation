<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming Share Everywhere

`share_everywhere_theme()` registers a wrapper plus one template per button. All live in the
module's `templates/` and are overridable in your theme.

| Theme hook | Template | Renders |
|---|---|---|
| `share_everywhere` | `share-everywhere.html.twig` | Wrapper: title, share icon, active state, `facebook_like`, `buttons`. |
| `se_facebook_like` | `se-facebook-like.html.twig` | Facebook Like button (`url`). |
| `se_facebook_share` | `se-facebook-share.html.twig` | Facebook Share. |
| `se_x` | `se-x.html.twig` | X/Twitter (the `twitter` button key uses this). |
| `se_linkedin` | `se-linkedin.html.twig` | LinkedIn. |
| `se_messenger` | `se-messenger.html.twig` | Messenger. |
| `se_viber` | `se-viber.html.twig` | Viber. |
| `se_whatsapp` | `se-whatsapp.html.twig` | WhatsApp. |
| `se_copy` | `se-copy-url.html.twig` | Copy URL. |

Button templates receive `url` and `content`; the wrapper receives `attributes` (with an
alignment class `se-align-left`/`se-align-right`), `title`, `share_icon`, `se_links_id`,
`is_active`, `facebook_like`, and `buttons`.

## Turning off bundled assets

Set `include_css` and/or `include_js` to empty in `share_everywhere.settings` (via the settings
form checkboxes) to stop the module attaching its CSS/JS, then style the markup yourself. The
module ships a `sass/share_everywhere.scss` source you can adapt. The SVG button images live in
the module's `img/` directory and are referenced by the `image` value of each button.

## Overriding

Copy any `templates/se-*.html.twig` (or `share-everywhere.html.twig`) into your theme and clear
cache, or implement a `hook_theme_suggestions_HOOK_alter()` / preprocess in the theme. Because
each network is its own template, you can restyle a single button without touching the others.
