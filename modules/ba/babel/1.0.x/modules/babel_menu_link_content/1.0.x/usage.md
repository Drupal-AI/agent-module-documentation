Babel submodule that lets translators translate custom menu link titles and descriptions from Babel's unified interface, optionally limited to chosen menus.

---

`babel_menu_link_content` adds a `menu_link_content` translation-type plugin to Babel. On install it batch-harvests the translatable properties (e.g. title, description) of every custom menu link (`menu_link_content` entity) into Babel's index, excluding language/metadata fields and system-provided menu links. Translators then translate these labels alongside code and configuration strings; saved translations are written back as native `content_translation` entity translations. The plugin implements a config subform (on the Babel settings page) to restrict which menus are exposed for translation.

---

- Translate custom menu link titles from the Babel translation interface.
- Translate custom menu link descriptions.
- Limit which menus are exposed for translation via the plugin's settings (menu allow-list).
- Keep menu link translations stored natively as content_translation entity translations.
- Include menu link strings in Babel spreadsheet export/import.
- Send menu link strings to TMGMT translators through `babel_tmgmt`.
- Let non-technical translators localize navigation labels without opening each menu link edit form.
- Curate (activate/deactivate) and lock menu link translations like any other Babel string.
- Exclude system/core menu links automatically so only real custom links appear.
