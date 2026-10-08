# Configuration

There are two setup steps: choose your site-wide sidenote defaults, and enable the
Sidenotes text filter on the formats where you want to use it.

## 1. Set the defaults

Go to **Configuration → Content authoring → Sidenotes**
(`/admin/config/content/sidenotes`). Here you set the defaults that apply whenever
sidenotes are added to a page, including:

- **Default label style** — Numbers, Symbols (`*`, `†`, `‡`, `§`, `¶`, `‖`, `Δ`, `◊`,
  `☞`), a Custom style you define, or None.
- **Custom labels** — define your own labels (for example `[wik]`) and choose the markup
  editors use to invoke them.
- **Margin placement** — left or right.
- **Responsive rendering** — whether notes render inline after the reference or move
  into an endnotes list; inline references can sit after the paragraph (the default) or
  immediately after the reference.
- **Endnotes section title** — the heading used for the endnotes list (endnotes get
  backlinks added automatically).

The look is themeable through CSS class names and CSS variables, so a themer can adjust
the appearance without touching the module.

## 2. Enable the text filter

Sidenotes are produced by a **text filter**, which you turn on per text format:

1. Go to **Configuration → Content authoring → Text formats and editors**.
2. Edit the format you author in (for example *Full HTML*).
3. Enable **"Sidenotes (Tufte-style)"**.
4. **Order matters:** place the Sidenotes filter *after* "Limit allowed HTML" and
   "Convert line breaks" in the filter processing order.
5. Save the format.

## Authoring sidenotes

With the filter on, write sidenotes in body text using either syntax:

- Shortcode: `[sn]Your sidenote content[/sn]`
- Double parentheses: `((Your sidenote content))`

### Overriding a note's label

Prefix the note content with a marker to override the label it would otherwise get:

- **Unnumbered:** add the marker (default `!@`) — for example `[sn]!@This note is
  unnumbered[/sn]`. Unnumbered notes do not affect the numbering of the others.
- **A specific symbol:** wrap a code in the configured prefix/suffix (default `!code!`)
  — for example `[sn]!d!Dagger symbol note[/sn]` or `[sn]!dd!Double dagger note[/sn]`.
- **A specific number:** `[sn]!1!Note with a 1[/sn]`.
- **A custom label:** `[sn]!custom!Note with a custom label[/sn]`.

Overrides never change the numbering or order of the other notes.

## Limitations to keep in mind

- **Nested sidenotes are not supported.**
- If you paginate content or use multiple body fields, numbering **resets per processed
  field** — usually what you want.
- Make sure your theme reserves enough width for the margin column; the space is set
  aside by the `.sn-content` margins, so a very narrow content area leaves no room for
  the notes.
