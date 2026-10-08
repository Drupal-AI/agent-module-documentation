# Entities, attachment mechanism, helper service, Twig functions

## The two entity types

- **`simple_mega_menu`** — content entity (`RevisionableContentEntityBase`), `base_table`
  `simple_mega_menu`, revisionable + translatable, `admin_permission = administer simple mega menu entities`.
  Base fields include `name` (label), `user_id`, `status`, `created`, `changed`. Handlers: storage
  `SimpleMegaMenuStorage`, list builder, `EntityViewBuilder`, `SimpleMegaMenuAccessControlHandler`,
  HTML route provider. Links under `/admin/content/simple_mega_menu/...`.
- **`simple_mega_menu_type`** — config bundle entity (`ConfigEntityBundleBase`), `config_prefix`
  `simple_mega_menu_type`, `bundle_of = simple_mega_menu`, `config_export = {id, label, uuid, targetMenu}`.
  `getTargetMenu()` / `setTargetMenu()` accessors.

## Attachment mechanism (`data-simple-mega-menu`)

`simple_megamenu_form_menu_link_content_form_alter()` adds an entity-autocomplete
(`#target_type => simple_mega_menu`, `target_bundles` = bundles targeting that link's menu). Its
submit handler writes the selected id to
`$menu_link->link->first()->options['attributes']['data-simple-mega-menu']` (or unsets it). So the
link → mega-menu association lives in the **menu link's options**, not on the entity.

## Helper service `simple_megamenu.helper`

`Drupal\simple_megamenu\SimpleMegaMenuHelper` (`SimpleMegaMenuHelperInterface`):

| Method | Returns |
|---|---|
| `getTargetMenus($type)` | filtered `targetMenu` list of a bundle |
| `getMegaMenuTypeWhichTargetMenu($menu_name)` | `[id => label]` of bundles targeting a menu |
| `menuIsTargetedByMegaMenuType($menu_name)` | bool — is any bundle attached to this menu |
| `getSimpleMegaMenuType($id)` / `getSimpleMegaMenu($id)` | load a bundle / an entity |

Used by the form alter and by `hook_preprocess_block` / `hook_theme_suggestions_menu_alter` to route
targeted menus through the default menu theme and add mega-menu theme suggestions.

## Twig functions (extension `simple_megamenu.twig.extension`)

`Drupal\simple_megamenu\TwigExtension\SimpleMegaMenuTwigExtension` registers:

- **`has_megamenu(url)`** — TRUE when the `Url` object's `attributes['data-simple-mega-menu']` is set
  and non-empty.
- **`view_megamenu(url, view_mode = 'default')`** — loads the referenced `simple_mega_menu` entity
  from the Url's `data-simple-mega-menu` attribute, checks `view` access, and returns the entity's
  render array in the requested view mode (e.g. `before` / `after`). Returns `[]` when there is no
  mega menu or no access.

Typical use in a menu Twig template:

```twig
{% if has_megamenu(item.url) %}
  <div class="megamenu">
    {{ view_megamenu(item.url, 'before') }}
    {{ view_megamenu(item.url, 'after') }}
  </div>
{% endif %}
```

## Access event subscriber

`SimpleMegaMenuAccessCanonicalPageSubscriber` governs access to the entity canonical page
(permission `access simple mega menu entities canonical page`), so mega-menu entities aren't
browsable as standalone pages unless allowed.
