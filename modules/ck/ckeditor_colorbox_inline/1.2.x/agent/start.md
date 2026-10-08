# Colorbox Inline Text Filter — agent index

One text-format **filter** that wraps every inline `<img>` in a Colorbox link so rich-text images open in a
lightbox gallery. Depends on `colorbox`. No global config page (`configure` null), no permissions, no
Drush, no plugin types. Not actually a CKEditor plugin — it is a display-time output filter.

- **Enable the filter, the `css_classes` setting, the `noColorbox` opt-out, gallery grouping** →
  [configure/filter.md](configure/filter.md)

Key facts:
- Filter plugin `ckeditor_colorbox_inline` — `src/Plugin/Filter/CkeditorColorboxInline.php`
  (`TYPE_TRANSFORM_IRREVERSIBLE`, weight -10). Default setting `css_classes = "colorbox"`.
- Behaviour: for each `<img>` (unless its class contains `noColorbox`), inserts `<a href="{img src}"
  class="{css_classes}" data-colorbox-gallery="ckeditor-colorbox-inline">` around it.
- `hook_page_attachments` (`ckeditor_colorbox_inline.module`) attaches the `colorbox.attachment` assets +
  the module's library on every page.
- Config schema: `filter_settings.ckeditor_colorbox_inline` (`css_classes` string).
