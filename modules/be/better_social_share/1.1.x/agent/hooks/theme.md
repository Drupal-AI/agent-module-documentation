# Theme hooks, templates & Twig extension

`better_social_share_theme()` registers two theme hooks; the per-platform markup lives in individual
Twig partials, so overriding a single button or adding a platform is a template task.

## Theme hooks

| Hook | Template | Variables (defaults) |
|---|---|---|
| `better_social_share_standard` | `templates/better-social-share-standard.html.twig` | `entity_url`, `entity_title`, `buttons_size`, `more_button_type`, `button_image`, `btn_bg_color`, `btn_type`, `icon_color_type`, `btn_border_round`, `btn_show_label`, `enable_button_spacing`, `buttons_label`, `icon_color` (`#fff`), `more_button_placement`, `entity_type`, `bundle`, `social_share_platforms`, `float` (`none`), `top` |
| `social_share_popup` | `templates/social-share-popup.html.twig` | `close_icon` (module `images/close.png`), `platforms` (`better_social_share_platforms()`) |

The standard template writes the share URL/title into a wrapper as
`data-entity_url="{{ entity_url }}"` / `data-entity_title="{{ entity_title }}"` (Twig
auto-escaped, HTML-attribute context) and then, for each enabled platform, includes the platform
partial. Every dynamic value is emitted inside a quoted attribute or as escaped text — no `|raw`, no
inline `<script>`, no event-handler attributes anywhere in the template set.

## Theme suggestions (per type/bundle)

`better_social_share_theme_suggestions_better_social_share_standard()` adds, in order:
`better_social_share_standard__<entity_type>` then `…__<entity_type>__<bundle>`. Create e.g.
`better-social-share-standard--node--article.html.twig` in your theme to customise buttons for one
bundle.

## Per-platform partials & the Twig extension

Each platform key resolves to `templates/template-parts/<key>.html.twig`. The standard template picks
the file with two Twig functions provided by service `better_social_share.twig_extension`
(`TwigExtension\FileExistsExtension`):

- `media_file_exists(filename)` — TRUE if `<active_theme>/templates/<filename>` **or**
  `<module>/templates/template-parts/<filename>` exists.
- `get_media_file_path(filename)` — returns `@<active_theme>/templates/<filename>` when the theme
  provides an override, else `@better_social_share/templates/template-parts/<filename>`, else `''`.

So to **override one button** (e.g. Facebook), copy
`templates/template-parts/facebook.html.twig` into your active theme's `templates/facebook.html.twig`
and edit it — the theme copy wins. Partials receive `platform_key`, `buttons_size`, `btn_bg_color`,
`btn_type`, `icon_color`, `btn_border_round`, `entity_url`, `entity_title`.

## Adding a new platform

A new platform requires both (1) a partial `templates/template-parts/<key>.html.twig` and (2) the
`<key>` present in `better_social_share_platforms()` — the master list is a hardcoded array in
`better_social_share.module` with **no alter hook**, so a brand-new platform key means patching that
function (or overriding the module). Existing keys can simply be enabled/reordered via config.

## Partial anatomy (share-link mechanics)

Two rendering paths use the partials:

- **Server-rendered row** (block / field / entity view): the partial is included with the real
  `entity_url` / `entity_title`, so its `data-link` / `href` already contains the resolved,
  auto-escaped URL and title. On click, `js/better_social_share.js` opens it with `window.open` /
  `window.location`.
- **"More" popup** (`social_share_popup`): the partials are included with the literal placeholders
  `$share_link` / `$title`, which the JS replaces with `encodeURIComponent(url)` /
  `encodeURIComponent(title)` at click time.

`copy_link` uses the Clipboard API; `pinterest` uses a static `javascript:` bookmarklet (no
interpolated data). None of the partials interpolate the URL/title outside a quoted attribute.
