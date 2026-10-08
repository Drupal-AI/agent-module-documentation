# Icon pack, library, and attachment

The module ships a small theming surface so its **Tools** menu item shows a wrench icon
consistent with the Navigation toolbar's design.

## Icon pack

Declared in `navigation_extra_tools.icons.yml`:

- Pack id `navigation_extra_tools`, extractor `svg`, sources `assets/icons/*.svg` (a single
  `wrench.svg`, the Phosphor Icons wrench).
- Settings: `size` (integer, default 20) and `class` (string). The template renders an
  `<svg>` with a `viewBox` of `0 0 24 24` by default and `aria-hidden="true"`.
- The Tools parent menu link references it via
  `options.icon: { pack_id: navigation_extra_tools, icon_id: wrench }` in
  `navigation_extra_tools.links.menu.yml`.

## CSS library

`navigation_extra_tools.libraries.yml` defines an `icon` library:

- CSS: `css/navigation_extra_tools.css` (theme layer).
- Dependency: `navigation/internal.navigation`.

## Attachment logic (`src/Hook/NavigationExtraToolsHooks.php`)

- `hook_page_attachments()` attaches `navigation_extra_tools/icon` only for users with the
  core `access navigation` permission.
- `hook_library_info_alter()` adds `toolbar/drupal.toolbar` as a dependency of the `icon`
  library when the core `toolbar` module is also enabled.

There are no Twig template overrides or theme hooks beyond the icon pack template above.
