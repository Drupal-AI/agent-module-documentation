<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, routes & permissions

## Install & enable

```bash
composer require drupal/single_page_site
drush en single_page_site -y
```

Core `menu_link_content` is enabled automatically (info.yml `dependencies`). Optional:
`drupal/link_attributes` (only needed for the per-item "Menu item selector" feature). The bundled
submodule `single_page_site_next_page` is a separate `drush en`.

## Routes & permissions

`single_page_site.routing.yml`:

| Route | Path | Target | Requirement |
|---|---|---|---|
| `single_page_site.config` | `/admin/config/system/single-page-site` | `_form: Form\SinglePageSiteConfigForm` | perm `administer single page site` |
| `single_page_site.page` | `/single-page-site` | `Controller\SinglePageSiteController::render` (title callback `::setTitle`) | perm `view single page site` |

Permissions (`single_page_site.permissions.yml`): **`administer single page site`** (settings
form) and **`view single page site`** (the assembled page). Menu link `single_page_site.config`
sits under *Configuration → System* (`single_page_site.links.menu.yml`).

## Config object `single_page_site.config`

Written by `SinglePageSiteConfigForm::submitForm()`; schema in
`config/schema/single_page_site.schema.yml` (type `config_object`). There is **no**
`config/install/` — the object is created on first save, and form defaults fill unset values.

| Key | Type | Form field (default) | Meaning |
|---|---|---|---|
| `menu` | string | Menu (required) | Machine name of the source menu. Empty ⇒ page shows a "configure me" link. |
| `menuclass` | string | Menu Class/Id (required) | CSS selector of the menu wrapper in your theme (e.g. `#block-olivero-main-menu`). Used by the JS to find & rewrite links. |
| `class` | string | Menu item selector | Class a menu item must carry to be included. Field is disabled unless `link_attributes` is enabled. Empty ⇒ all items. |
| `title` | label | Title (required) | Page title (falls back to "Single page site"). |
| `tag` | string | Tag (required) | HTML tag wrapping each section heading, e.g. `h2`. |
| `homepage` | boolean | Homepage (default checked) | When saved truthy, also sets `system.site` `page.front` = `/single-page-site`. |
| `down` | integer | Scroll → Down (50) | px distance for highlighting a section when scrolling down. |
| `up` | integer | Scroll → Up (200) | px distance for highlighting when scrolling up. |
| `smoothscrolling` | boolean | Advanced → Use smooth scrolling (default checked) | Attaches the smooth-scroll library. |
| `updatehash` | boolean | Advanced → Update url fragment while scrolling (0) | Scrollspy `pushState`s `#anchor` as you scroll. |
| `offsetselector` | string | Advanced → offset selector | Selector whose height offsets the scroll target (usually same as `menuclass`). |
| `filterurlprefix` | boolean | Advanced → Filter url prefixes out of anchor IDs (0) | Strips the language URL prefix from anchors (multilingual menus). |

`getEditableConfigNames()` returns both `single_page_site.config` and `system.site` (the latter so
the Homepage toggle can rewrite `page.front`).

### Input validation (`validateForm`)

- `menuclass`: only `A-Za-z0-9#.-` allowed.
- `class`: only `A-Za-z0-9-` allowed.
- `tag`: only `A-Za-z0-9` allowed (rejects any special char, keeping the tag safe to interpolate
  into the Twig template as `<{{item.tag}}>`).

## Config-export example

```yaml
# single_page_site.config
menu: main
menuclass: '#block-olivero-main-menu'
class: ''
title: 'Acme one-pager'
tag: h2
homepage: true
down: 50
up: 200
smoothscrolling: true
updatehash: false
offsetselector: '#block-olivero-main-menu'
filterurlprefix: false
```

## Install/uninstall hooks (`single_page_site.install`)

- `hook_uninstall()` deletes `state('single_page_site_settings')`.
- `update_9001` is a no-op cache flush.
- `update_10001` casts stored values to the schema types (`down`/`up` → int;
  `homepage`/`smoothscrolling`/`updatehash`/`filterurlprefix` → bool).

## Menu-link guard

`SinglePageSiteHooks::formMenuLinkContentMenuLinkContentFormAlter` adds
`validateMenuItem()` to `menu_link_content` forms. For links added to the configured source menu it
rejects `internal:/single-page-site`, and rejects `internal:/` (front page) when `homepage` is on —
so the single page cannot be nested inside its own source menu.
