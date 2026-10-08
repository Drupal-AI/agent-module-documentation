# Media Library Theme Reset — agent index

Themes core's Media Library with Claro's admin styling when it renders in a **front-end
theme** (Layout Builder, front-end content editing, webforms, low-permission users).
Enabling the module is the entire setup: **no config UI, no permissions, no Drush, no
plugins.** Docs below are cheaper to read than the source.

- Templates, theme hooks, and the CSS libraries it registers/attaches → [theming/templates.md](theming/templates.md)
- Overriding its templates, adding a theme-specific fixes CSS, the active-theme-chain helper → [api/extend.md](api/extend.md)

Key facts:
- Depends on core `system` + `media_library` only. No third-party libraries.
- Registers 14 theme hooks via `hook_theme()` (templates copied from Claro).
- Registers two CSS libraries: `media_library_theme_reset/media_library`
  (`css/media-library-fixes.css`) and `media_library_theme_reset/olivero_fixes`
  (`css/olivero-fixes.css`).
- On the Media Library add-form it attaches `claro/media_library.theme` +
  `media_library_theme_reset/media_library`, and adds `olivero_fixes` **only when Olivero
  is in the active theme chain**.
