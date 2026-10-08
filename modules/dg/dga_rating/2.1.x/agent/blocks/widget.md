<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DGA Rating Widget block & theming

Source: `src/Plugin/Block/DgaRatingBlock.php`, `dga_rating.module` (`hook_theme`),
`templates/dga-rating-widget.html.twig`, `dga_rating.libraries.yml`, `js/rating.js`.

## Block plugin

`DgaRatingBlock` — annotation `@Block(id = "dga_rating_block", admin_label = "DGA Rating Widget",
category = "Custom")`. Implements `ContainerFactoryPluginInterface`; injects `dga_rating.service`,
`config.factory`, `language_manager`, `request_stack`, `current_route_match`, `path.current`,
`path_alias.manager`.

`build()`:
- Resolves the current path to its **alias** and strips any `/xx` language prefix so the URL matches
  how anonymous ratings are stored (e.g. `/calculator`, not `/en/calculator`).
- If on a node route, sets `entity_type = 'node'` and `entity_id = $node->id()`, then calls
  `getStatistics($type, $id, $url)`; otherwise falls back to `getStatisticsByUrl($url)`.
- Formats `average` to one decimal (or `0.0`) and an int `count`.
- Loads `dga_rating.settings` and, via a `$getTranslation()` closure keyed on current language
  (`ar` vs. else), builds a `#texts` array of ~19 localized strings (question, instructions,
  button/label text, success/error/validation messages, star singular/plural) with English/Arabic
  fallbacks.
- Returns a render array: `#theme => 'dga_rating_widget'` with `#average`, `#count`, `#url`,
  `#entity_type`, `#entity_id`, `#texts`; attaches library `dga_rating/rating_widget` and
  `drupalSettings.dgaRating.refreshBlockUrl` + `refreshDelay` (`refresh_delay` config, default 3000ms).

Cache: `max-age: 3600`, contexts `url.path`, `languages:language_interface`, `user.roles`; tags
`dga_rating:submissions` (invalidated on every save/update/delete) and `config:dga_rating.settings`.

## Theme hook & template

`hook_theme()` registers `dga_rating_widget` (template `dga-rating-widget.html.twig`, path pinned to
the module's `templates/`) with variables `average`, `count`, `url`, `entity_type`, `entity_id`,
`texts`. All `texts.*` values are printed through Twig auto-escaping.

Override by copying `templates/dga-rating-widget.html.twig` into your theme's `templates/`
directory (the module pins its own path in `hook_theme`, so clear cache after adding the override so
the theme registry picks up the theme copy). The template renders three states client-side (closed
summary, open form, submitted confirmation) driven by `js/rating.js`.

## Client behavior (`js/rating.js`)

A `Drupal.behaviors` script (jQuery + `core/once`) wires the star selector, posts JSON to
`/dga-rating/submit`, shows the localized success/validation messages from `#texts`, and after
`refreshDelay` calls `refreshBlockUrl` (`/dga-rating/refresh-block`) to update the average/count in
place. `feedback` is required client-side and re-validated server-side.

## Libraries

- `dga_rating/rating_widget` — `js/rating.js` + `css/bootstrap.css`, `css/rating.css`; deps
  core `jquery`, `drupal`, `once`, `drupalSettings`.
- `dga_rating/admin` — `js/admin.js` + `css/admin.css`; adds core `dropbutton` (dashboard only).
- `dga_rating/toolbar_icon` — `css/menu-icon.css`; attached on pages for users with `access toolbar`.

No external/CDN assets; everything is bundled in the module.
