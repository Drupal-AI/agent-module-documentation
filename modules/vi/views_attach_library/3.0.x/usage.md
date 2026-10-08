Attach Library In Views lets you attach any Drupal asset library (CSS/JS) to a View by simply typing the library name in the View's display settings — no custom preprocess code required.

---

The module registers a Views **display extender** plugin, `library_in_views_display_extender`
(`Plugin/views/display_extender/ViewsAttachLibraryDisplayExtender`), and enables it automatically on
install by appending it to `views.settings`'s `display_extenders` (removed again on uninstall). The
extender adds an **Attach Library** section to each View display where you enter one or more library
names in the standard `provider/library` form (e.g. `mytheme/global`, `mymodule/slider`), comma-
separated for multiple. At render time `ViewsAttachLibraryHook::viewsPreRender()`
(`hook_views_pre_render()`) reads the display's stored `attach_library` value, splits it on commas,
trims each entry, and pushes it onto `$view->element['#attached']['library'][]` so Drupal's asset
system loads it with the View. Settings are stored per display under
`display_options.display_extenders.library_in_views_display_extender.attach_library` (config schema
provided), so they can be set per display or inherited from the default display. There is no global
settings page, no permission, and no dependency beyond core Views. The plugin is declared `no_ui`
(the extender itself has no top-level UI row) but exposes its **Attach Library** option through the
display's options summary.

---

- Load a theme or module CSS/JS library only on pages that render a specific View.
- Attach a slider/carousel library to a View that outputs a carousel.
- Add a custom stylesheet to style one View's markup without global CSS.
- Attach a JavaScript behavior library that enhances a View's rows.
- Attach multiple libraries to one View by comma-separating their names.
- Set the library on the View's **Default** display so all displays inherit it.
- Override the attached library per display (page vs. block) of the same View.
- Avoid writing a `hook_views_pre_render()` / preprocess just to attach assets.
- Attach a datatables/tablesorter library to a table-style View.
- Load a map or chart library only where the relevant View appears.
- Keep asset loading scoped to Views output for better front-end performance.
- Attach a print-specific stylesheet to a report View.
- Attach a lightbox library used by fields inside the View.
- Ship a feature's View plus its assets together via exported View config.
- Attach a web-font or icon library needed only by a particular View.
- Let site builders wire assets to Views without developer involvement.
