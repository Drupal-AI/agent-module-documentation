# ckeditor_font — agent start

Adds Font Family, Font Size, Font Color, and Font Background Color dropdowns to the
CKEditor 5 toolbar, each with a per-text-format list of allowed values applied as inline
`<span style>`. Depends on core `ckeditor5`. **No global config UI** (`configure` is null):
everything is set per text format at **Admin → Config → Content authoring → Text formats
and editors** (`filter.admin_overview`). Beta release; README marks the module deprecated
in favor of CKEditor5 Plugin Pack for new sites.

Three CKEditor 5 plugins (from `ckeditor_font.ckeditor5.yml`):

- `ckeditor_font_font` — Font Size & Family, buttons `fontSize` + `fontFamily`.
- `ckeditor_font_font_color` — Font Color, button `fontColor`.
- `ckeditor_font_font_background_color` — Font Background Color, button `fontBackgroundColor`.

- Enable the buttons, configure the font/size/color lists and allowed styles →
  [configure/ckeditor_font.md](configure/ckeditor_font.md)
