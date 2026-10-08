Menu Bootstrap Icon adds a Bootstrap 5 icon picker to menu links, to Link fields (widget + formatter), to File fields (extension-aware icon + optional Google/Office viewer), and as a CKEditor 5 toolbar plugin.

---

The module bundles the full Bootstrap Icons set (~2000 icons, one `icons/<name>.md` per icon with search tags) and a JavaScript popover icon picker. It exposes icons in four places: (1) **menu links** — `hook_form_menu_link_content_form_alter` / `_menu_link_edit_alter` add an icon textfield (with picker), an HTML-tag select (`i`/`span`), an appearance select (before/after/only), and an optional per-item **role** restriction; the chosen icon is injected into link output via `hook_link_alter` and `hook_preprocess_menu`; (2) a **Link-field widget** `bootstrap_icon_link` (extends core `LinkWidget`) storing a `data-icon` attribute, and formatter `bootstrap_icon_link` (extends `LinkFormatter`) prepending/appending the icon; (3) a **File-field formatter** `file_bootstrap_icon` that maps file extension/MIME to a Bootstrap filetype icon and can open docs in a modal, new tab, or the Google Docs / Microsoft Office online viewer; (4) a **CKEditor 5 plugin** (`bootstrapIcons.BootstrapIcons`) inserting `<i class="bi …">` inline. A settings page (`admin/config/content/menu_bootstrap_icon`, requires `administer site configuration`) toggles CDN asset loading (`use_cdn`) and regenerates the picker's search index (`js/iconSearch.json`) by scanning the `icons/` folder; it uses an ACE-based YAML editor. Bootstrap CSS/JS and the icon font load from jsDelivr/cdnjs CDNs by default (the `cdn` and `icons` libraries), or from a Bootstrap-5 admin theme. The menu icon library is **not** auto-attached for front-end menus — add `menu_bootstrap_icon/cdn` to your theme's `.info.yml`. Depends on `menu_ui`. No permissions of its own, no Drush.

---

- Add a Bootstrap icon before, after, or instead of a menu link's text.
- Pick menu icons visually with a searchable popover icon picker.
- Choose whether a menu icon renders in an `<i>` or `<span>` tag.
- Show icon-only menu items with an accessible aria-label/sr-only title.
- Restrict which roles see a given menu item (menu-level display restriction).
- Add an icon to a Link field value via the `bootstrap_icon_link` widget.
- Display Link-field icons with the `bootstrap_icon_link` formatter (before/after/icon-only).
- Set a default icon per Link field that individual values can override.
- Show file-type icons automatically for File-field downloads by extension/MIME.
- Open office/PDF files in a modal dialog instead of downloading.
- Preview Word/Excel/PowerPoint files via the Google Docs online viewer.
- Preview office files via the Microsoft Office online viewer.
- Open file links in a new browser tab.
- Insert inline Bootstrap icons into rich text through the CKEditor 5 toolbar.
- Search icons by keyword/tags inside CKEditor or the field pickers.
- Serve Bootstrap icons from a CDN when the admin theme lacks them (`use_cdn`).
- Use a Bootstrap-5-based admin theme's own icon assets instead of the CDN.
- Regenerate the icon search index after adding custom `icons/*.md` files.
- Add custom icon definitions/search terms via the settings YAML editor.
- Build an icon-driven navigation menu that matches a Bootstrap 5 theme.
- Give downloadable-document lists recognizable per-format glyphs.
- Provide consistent iconography across menus, links, files, and body text.
