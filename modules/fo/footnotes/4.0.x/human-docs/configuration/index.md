# Configuration

Footnotes has **no central settings page** — you configure it on a **text format**.
Two things need to be true for a format: the **Footnotes filter** is enabled, and
the **Footnotes button** is on that format's CKEditor 5 toolbar. Everything else is
filter settings and an optional block.

## Two ways to get a footnote‑ready format

### Option A — use the ready‑made "Footnote" format

The module ships an optional **Footnote** text format (and matching CKEditor 5
editor), installed only if they aren't already present. The filter ships switched
*off*, so enable it:

```bash
drush cset filter.format.footnote filters.filter_footnotes.status true -y
```

Then make sure the **Footnotes** toolbar button is present on it (see Option B,
step 2). This format is the fastest way to give editors footnotes without building a
format from scratch.

### Option B — add footnotes to an existing format (e.g. Full HTML)

1. **Enable the filter.** Go to **Configuration → Content authoring → Text formats
   and editors** (`/admin/config/content/formats`), edit your format, and under
   *Enabled filters* tick **Footnotes filter**.
2. **Add the toolbar button.** In the same form, drag **Footnotes** from the
   available buttons into the *Active toolbar*.
3. **Allow the tags.** If the format uses *Limit allowed HTML tags*, the elements the
   footnotes plugin needs are added automatically when you enable the button, so you
   normally don't have to edit the allowed‑tags list by hand.
4. **Save.** Editors now see a **Footnotes** button that opens the insert dialog with
   a live preview.

> **Filter order matters.** Keep the Footnotes filter positioned so that a later
> "Limit allowed HTML tags" filter doesn't strip the markup it produces.

## Filter settings

When you enable the Footnotes filter, its settings control how notes render:

- **Collapse identical footnotes** (`footnotes_collapse`, default off) — merge
  footnotes whose content is identical into a single number with multiple
  back‑reference links. Turn this on so citing the same source twice reuses one
  number.
- **Load footnotes CSS** (`footnotes_css`, default on) — attach the module's bundled
  stylesheet. Turn it off if your theme styles footnotes itself.
- **Show notes in a dialog** (`footnotes_dialog`, default off) — show each note in a
  click‑to‑open popup instead of scrolling the reader down to the footer.
  - **Prevent event bubbling** (`footnotes_dialog_prevent_bubbling`, default off) —
    when dialogs are on, stop the click event from bubbling up.
- **Disable the inline footer** (`footnotes_footer_disable`, default off) — don't
  append the notes list after the content. Use this when you want to render the notes
  elsewhere via the block or display component (see below). **A cache clear is
  required for this to take effect.**
- **Preview: show reference text** (`footnotes_preview_show_text`, default on) — show
  the note's text in the CKEditor live preview while editing.
- **Preview marker character** (`footnotes_preview_character`, default empty) —
  override the character shown as the footnote marker in the editor preview.

You can also set these in config, for example:

```bash
drush cset filter.format.footnote filters.filter_footnotes.settings.footnotes_collapse true -y
drush cset filter.format.footnote filters.filter_footnotes.settings.footnotes_footer_disable true -y
```

## Rendering the notes outside the body

By default the notes list appears inline at the foot of the text. To put it
somewhere else — a sidebar "References" section, say — you disable the inline footer
and render the notes with either the block or the display component:

1. On the text format, turn on **Disable the inline footer**
   (`footnotes_footer_disable`).
2. Clear caches (`drush cr`) — the setting notes this is required.
3. Then either:
   - **Place the Footnotes Group block** from **Structure → Block layout** in the
     region you want. Its one setting, **Group via JS**, collects footnotes on the
     client when several fields or blocks on the same page each contribute notes.
   - **or position the "Footnotes" display component** on the entity's **Manage
     display** page (it appears as a pseudo‑field you can drag into place).

Do one *or* the other alongside the disabled footer, so the notes aren't printed
twice.

## Keeping citations out of search

If you use Search API, enable the **Ignore citations** processor
(`footnotes_ignore_citations`) on your index's *Processors* tab so footnote text
doesn't pollute search relevance.

## Theming

The markup comes from four overridable Twig templates — `footnote-link`,
`footnote-links`, `footnote-list`, and `footnote-dialog`. Copy them into your theme
to customise the output. See the agent docs at
[`agent/theming/templates.md`](../agent/theming/templates.md) for details.
