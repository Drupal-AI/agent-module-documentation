# Style Switcher block + runtime switching

Block plugin `\Drupal\styleswitcher\Plugin\Block\Styleswitcher`,
id **`styleswitcher_styleswitcher`**, admin label "Style Switcher". Place it at
`/admin/structure/block` (or via a `block` config entity). Place it in every theme where you want
switching. There is no permission on switching — any visitor can use the block.

## What the block renders (`build()`)

- Loads enabled styles for the active theme: `styleswitcher_style_load_multiple($theme, ['status' => TRUE])`.
- **Renders nothing if fewer than 2 styles exist** (no alternatives to offer).
- Sorts by `styleswitcher_sort` and outputs an `item_list` of links. Each link points at route
  `styleswitcher.switch` with params `{theme, type, style}` derived from the style machine name
  (`type` = `custom`|`theme`, `style` = the part after `/`), a `destination` query so no-JS users
  return to the same page, and `rel="nofollow"` + `data-rel="<name>"` + CSS classes.
- Attaches library `styleswitcher/styleswitcher` (jQuery + core/once + the switch JS) and
  `drupalSettings.styleSwitcher`: `styles` (each with an absolute `path`), `default`,
  `enableOverlay`, `cookieExpire`, `theme`.
- Cache: contexts `theme` + `url` (because of the per-page `destination`); tags
  `config:styleswitcher.settings`, `config:styleswitcher.custom_styles`, `config:styleswitcher.styles_settings`.

## Live switch (JS enabled) — js/styleswitcher.js

`Drupal.behaviors.styleSwitcher` binds click on `.style-switcher` links. On click it looks up the
style object from `drupalSettings.styleSwitcher.styles[name]` (server-provided list only), writes the
cookie `styleswitcher[<theme>]=<style name>` (`Drupal.styleSwitcher.cookie()`), and sets the `href`
of `<link id="styleswitcher-css">` to that style's absolute `path` — optionally behind a fade
overlay when `enableOverlay` is on. The active link gets the `active` class.

## No-JS / server path

- `styleswitcher.switch` → `/styleswitcher/switch/{theme}/{type}/{style}`, controller
  `DefaultController::styleswitcherSwitch()`. `{style}` upcasts through the `styleswitcher_style`
  ParamConverter to a loaded style array; the controller saves the matched style's canonical
  `name` to the cookie via `setcookie('styleswitcher[<theme>]', …)` and redirects to `<front>`
  (the block adds a `destination` so the visitor returns to their page). `no_cache: TRUE`,
  `_access_theme: 'TRUE'`.
- `styleswitcher.css` → `/styleswitcher/css/{theme}`, controller `DefaultController::styleswitcherCss()`.
  Reads the visitor's cookie, resolves the active style via `activeStylePath()`, and returns a
  `TrustedRedirectResponse` (302, `Content-Type: text/css`) to the active stylesheet's URL — or an
  empty 200 CSS body for the blank style. `no_cache: TRUE`, `_access_theme: 'TRUE'`.

## How the active stylesheet gets onto the page

`styleswitcher_page_attachments()` attaches library `styleswitcher/dynamic-css`, which declares a
placeholder `styleswitcher.active.css`. `styleswitcher_css_alter()` then rewrites that placeholder to
point at the `styleswitcher.css/{theme}` route (relative URL, group `CSS_AGGREGATE_THEME`,
`weight = PHP_INT_MAX`, `preprocess: false`) so the chosen stylesheet loads last and overrides other
CSS. The `<link>` carries `id="styleswitcher-css"` so the JS can swap its `href` live.

## Cookie

Name `styleswitcher[<theme>]`, value = style machine name, path = base path, lifetime
`DefaultController::COOKIE_EXPIRE` (31536000s ≈ 365 days). One entry per theme. Legacy single-string
and `styleSwitcher` cookies are migrated on read in `activeStylePath()`.
