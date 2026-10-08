# Configuration

Shortcode has no settings page of its own — you configure it on each **text format**, just
like any other filter. This is where you turn bracket‑tag parsing on and choose which tags
that format allows. Make sure you have enabled a tag provider first (such as **Shortcode
basic tags** — see [Installation](../installation/index.md)); otherwise there are no tags to
turn on.

## Enable the Shortcodes filter on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and click **Configure** next to the format you want to
   add shortcodes to (for example *Basic HTML*, *Full HTML*, or a custom format).
2. Under **Enabled filters**, tick **Shortcodes**.
3. Scroll to the **Shortcodes** settings section. The available tags are listed there,
   grouped by the module that provides them ("Shortcodes provided by *&lt;module&gt;*"), each
   with its own checkbox and a short description. Tick the tags you want editors to be able to
   use in this format, and leave the rest unticked.
4. Save the format.

Only the tags you tick are expanded. A tag you leave off is rendered as literal `[tag]…[/tag]`
text rather than being removed — so unauthorised tags simply show up as plain text instead of
vanishing.

## Enable the HTML corrector (recommended with CKEditor)

If editors use a WYSIWYG editor such as CKEditor, also tick **Shortcodes — HTML corrector**
in the same **Enabled filters** list. WYSIWYG editors tend to wrap block‑level shortcode tags
in stray `<p>` or `<div>` tags, which can break the rendered markup; this filter cleans that
up. Enable it alongside **Shortcodes** on any format whose editor is a WYSIWYG.

## Filter order

Shortcodes are expanded during rendering, as part of the format's filter pipeline. If you
combine the Shortcodes filter with other filters (the URL filter, the HTML corrector, "Limit
allowed HTML tags"), make sure the pipeline order and the allowed‑tags list let the expanded
HTML through — for instance, allow the tags your shortcodes output if the format restricts
HTML.

## Good to know

- **Changes take effect immediately.** Because shortcodes are expanded at render time (not on
  save), turning a tag on or off changes the output of already‑saved content the next time it
  is viewed.
- **Escaping a literal tag.** An editor can prevent a tag from being processed by doubling the
  brackets — `[[tag]]` renders as a literal `[tag]`.
- **Deploy as config.** The per‑format filter settings live in the `filter.format.<format>`
  configuration, so exporting that config carries your shortcode enablement to other
  environments.
