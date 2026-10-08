# Menu-link icons, roles, and Link/File fields

Source: `src/Hook/BootstrapIconHook.php` (menu), `src/Plugin/Field/*`.

## Menu-link icons

`hook_form_menu_link_content_form_alter` (content menu links) and `hook_form_menu_link_edit_alter`
(module/config links) add a **Bootstrap Icon** fieldset:

| Field | Stored in link `options` | Notes |
|---|---|---|
| Icon class (textfield + picker) | `icon` | e.g. `bi bi-house`. `Html::escape`'d on submit. |
| HTML tag (select) | `icon_tag` | `i` or `span`. |
| Appearance (select) | `icon_appearance` | `before` / `after` / `only`. |
| Menu Item Roles (checkboxes) | `roles` | Optional per-item role restriction (see below). |

- Content menu links store options on the link field item (`menuLinkContentFormSubmit`).
- Config/base menu links store options into `menu_tree.options` (serialized) **and** into
  `menu_bootstrap_icon.settings:menu_link_icons[<link_id_with_dots_as_underscores>]`
  (`formMenuLinkEditSubmit`); `hook_menu_links_discovered_alter` re-applies them after cache
  clears (which wipe `menu_tree.options`).

Rendering: `hook_link_alter` and `hook_preprocess_menu` wrap the link text with
`<i|span class="<icon>">` per the appearance, using `FormattableMarkup`. The `icon` value was
`Html::escape`'d at save time.

### Per-item role restriction — display only

If `options['roles']` is set and the current user is not `administrator` and shares no role with
it, `hook_link_alter` sets `$variables['access'] = FALSE`, adds a `js-hide` class, and marks the
link `disabled`. This hides the **menu link**; it does **not** protect the destination route —
the target page still enforces its own access. Treat this as menu visibility sugar, not access
control.

## Link field — widget & formatter

- Widget **`bootstrap_icon_link`** (`BootstrapIconWidget extends LinkWidget`): adds a per-value
  `data-icon` attribute (icon class, with picker) and a widget-level default `icon` setting
  (`field.widget.settings.bootstrap_icon_link`).
- Formatter **`bootstrap_icon_link`** (`BootstrapIconFormatter extends LinkFormatter`): settings
  `icon` (default) + `position` (`before`/`after`/`icon_only`) + inherited `target`. Reads the
  value's `data-icon` (falls back to default) and renders `<i class="<icon>">` around the link
  title via a render array `#markup`. Settings schema `field.formatter.settings.bootstrap_icon_link`.

## File field — formatter `file_bootstrap_icon`

`FileBootstrapIconFormatter extends FileFormatterBase`. Settings: `icon` (fallback,
default `bi-file-earmark`), `position` (before/after/icon_only), `target` (`_blank` / `modal`),
`viewer` (`google` / `microsoft`). For each file it maps extension (`getIconClass`) then MIME
(`mimeMap`) to a `bi bi-filetype-*` / `file-earmark-*` glyph. When `viewer` is set and the file
is a doc/xls/ppt type, the link points at the Google Docs (`docs.google.com/gview`) or Microsoft
(`view.officeapps.live.com`) online viewer with the file's absolute URL; `modal` opens it in a
Drupal dialog (`viewer-modal` library). Schema `field.formatter.settings.file_bootstrap_icon`.

## Note on icon output

Menu icon values are `Html::escape`'d at save; the Link-field `data-icon` value is a
content-editor-supplied field attribute rendered into a class attribute via a render-array
`#markup` (so it passes through Drupal's `Xss::filterAdmin` on render). If you author custom
output from these values, escape the class string yourself.
