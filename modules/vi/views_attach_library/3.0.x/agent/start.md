# Attach Library In Views — agent index

Attach any asset library (CSS/JS) to a View by typing its `provider/library` name in the display
settings. No global config (`configure` null), no permission, no Drush. Config schema provided.
Requires core Views.

- **Enable/where it lives, the Attach Library display setting, storage path, and the pre_render
  attach** → [configure/attach.md](configure/attach.md)

Key facts:
- Display extender plugin `library_in_views_display_extender`
  (`Plugin/views/display_extender/ViewsAttachLibraryDisplayExtender`, `no_ui: TRUE`).
- Auto-registered on install by adding itself to `views.settings` → `display_extenders`
  (`hook_install`); removed on uninstall.
- `hook_views_pre_render()` (`ViewsAttachLibraryHook::viewsPreRender`) reads the display's
  `attach_library`, `explode(',')`, trims, and appends each to `$view->element['#attached']['library']`.
- Stored at `display_options.display_extenders.library_in_views_display_extender.attach_library`
  (comma-separated `provider/library` names).
