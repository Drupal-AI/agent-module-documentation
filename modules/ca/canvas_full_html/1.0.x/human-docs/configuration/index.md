# Configuration

Canvas Full HTML has essentially one setting — an on/off switch — plus a text
format you can style to taste. This page covers both.

## The one setting

Go to **Configuration → Content authoring → Canvas Full HTML**
(`/admin/config/content/canvas-full-html`). It needs the **Administer site
configuration** permission. The form has a single checkbox:

- **Enable Full HTML format in Canvas** *(on by default)* — when ticked, Canvas
  WYSIWYG component fields that would use one of Canvas's restricted formats are
  switched to the richer `canvas_full_html` format. Untick it and the module does
  nothing: Canvas reverts to its own `canvas_html_block` / `canvas_html_inline`
  formats.

Click **Save**. You can also toggle it from the command line without opening the
UI:

```bash
drush cget canvas_full_html.settings enabled
drush cset canvas_full_html.settings enabled 0 -y   # disable
drush cset canvas_full_html.settings enabled 1 -y   # enable (default)
```

After changing the setting, **clear caches** (`drush cr`) and **add new component
instances** to see the change — existing component instances keep whichever
format they were created with.

## Editing the Canvas toolbar

The enhanced editor is just an ordinary CKEditor 5 configuration, so you decide
exactly which buttons appear. Edit it at **Configuration → Content authoring →
Text formats and editors → Canvas Full HTML**
(`/admin/config/content/formats/manage/canvas_full_html`).

Out of the box the toolbar includes: bold, italic, underline, strikethrough,
superscript, subscript, remove format, heading, link, bulleted list, numbered
list, block quote, horizontal line, and source editing. Add or remove buttons
here and it changes **only** Canvas editors — your site's regular `full_html` and
other formats are untouched.

Both core and contrib CKEditor 5 plugins are supported (for example
`ckeditor5_plugin_pack` or `ui_icons_ckeditor5`); the module pre-loads every
plugin library enabled on this editor so contrib plugins are ready before Canvas's
React editor starts. (One core integration library is intentionally left out
because it conflicts with Canvas's own AJAX handling — this is handled for you and
needs no action.)

## What the module does behind the scenes

You don't need to configure any of this, but for context: while the setting is on,
the module intercepts Canvas's resolution of rich-text component props and
substitutes `canvas_full_html` for any prop whose schema expects HTML. It also
attaches a small CSS/JS fix to the Canvas UI that stops toolbar dropdowns ("Show
more items") from being clipped inside the Canvas React interface.
