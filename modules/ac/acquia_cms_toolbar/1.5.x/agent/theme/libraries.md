# Asset libraries

Defined in `acquia_cms_toolbar.libraries.yml`. Both are attached by hooks (see
[../hooks/toolbar.md](../hooks/toolbar.md)); nothing here is a global library, so plain module-enable
alone does not load them.

| Library | Asset | Attached by |
| --- | --- | --- |
| `acquia_cms_toolbar/styling` | `css/acquia_cms_toolbar.css` (theme-level CSS) | `hook_toolbar_alter`, onto the `admin_toolbar_tools` item |
| `acquia_cms_toolbar/toolbar_styles` | `js/acms_toolbar.js` | `hook_preprocess_page`, only when the user has `access toolbar` |

## css/acquia_cms_toolbar.css

Restyles the admin toolbar under the `.acquia-cms-toolbar` body class: offsets the toolbar bar
(`top: 10px`), and skins the `.toolbar-icon-environment` tab plus per-environment colours keyed on
the `.environment-local` / `-ide` / `-dev` / `-stage` / `-prod` classes. Also swaps several toolbar
menu icons for the SVGs under `images/` (e.g. `images/acacac/*.svg`).

## js/acms_toolbar.js

`Drupal.behaviors.acquiaCmsToolbarOffset` — adjusts the page `body` `margin-top` so the site's main
menu does not overlap the admin toolbar. Runs on `window.onload`, window `resize`, and clicks on
`.toolbar-icon-menu`; when the secondary toolbar (`#toolbar-administration-secondary`) is hidden it
sets `body { margin-top: 10px }`. Depends on jQuery/Drupal/drupalSettings (loaded because it is
attached alongside the toolbar).

There is no `*.info.yml` library dependency wiring beyond core; the CSS/JS assume the core `toolbar`
and contrib `admin_toolbar` markup is present.
