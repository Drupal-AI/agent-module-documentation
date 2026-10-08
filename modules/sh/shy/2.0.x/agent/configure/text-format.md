# Configuring shy on a text format

There is NO global settings page (`configure` is null). Everything is done per text
format/editor at `/admin/config/content/formats` (edit a format that uses CKEditor 5).

## Steps (per format)

1. Drag the **Soft hyphen** button from *Available buttons* into the *Active toolbar* of the
   CKEditor 5 configuration.
2. Enable the **Cleanup SHY markup** filter (`shy_cleaner_filter`) in the *Enabled filters*
   list. The CKEditor 5 plugin has `conditions: filter: shy_cleaner_filter`, so the button
   will not appear unless this filter is enabled on the same format.
3. If **Limit allowed HTML tags and correct faulty HTML** (`filter_html`) is enabled, add the
   `class` attribute to `<span>` in *Allowed HTML tags* (i.e. include `<span class>`) so legacy
   `<span class="shy">` content survives filtering. New content uses the `<shy>` element, which
   the CKEditor plugin registers as allowed automatically.

## How it works at runtime

- In the editor, using the button / Ctrl+Hyphen inserts a `<shy>` element at the cursor.
- On output, `shy_cleaner_filter` (a `TYPE_TRANSFORM_IRREVERSIBLE` filter) parses the HTML and
  replaces each `<shy></shy>` (and legacy `<span class="shy">`) node with the UTF-8 soft-hyphen
  byte sequence `"\xc2\xad"` (`&shy;`). The result is an invisible character that only becomes a
  visible hyphen if the browser breaks the word at that point.

## Config that gets written

Enabling the above changes core config only — the format's `filters.shy_cleaner_filter` (from
`filter.format.<id>`) and the CKEditor 5 toolbar/settings (`editor.editor.<id>`). The module
itself ships no `config/install` and no schema of its own.

## Libraries

- `shy/shy.ckeditor5` — `js/shy.js` + `css/ckeditor.shy.css`, depends on `core/ckeditor5`.
- `shy/shy.admin` — admin CSS (`css/shy.admin.css`), used as the plugin's `admin_library`.
