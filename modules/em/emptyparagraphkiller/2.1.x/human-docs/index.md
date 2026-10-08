# Empty Paragraph Killer — manual setup guide

**Empty Paragraph Killer** (`emptyparagraphkiller`) is a text-format filter that
quietly strips out empty `<p>` paragraphs — including ones that contain nothing but
whitespace or a non-breaking space (`&nbsp;`) — from rendered content. It cleans up
the blank gaps editors create when they press *Return* twice in a WYSIWYG editor, so
your body copy keeps consistent paragraph spacing without large empty holes.

The cleanup is **non-destructive**: it only affects the rendered output, never the
stored source text. Behind the scenes it swaps each empty paragraph for a temporary
placeholder during the *prepare* phase, then removes those placeholders during the
*process* phase, which keeps the filter safe and reversible. Because the original
markup in the database is untouched, you can turn the filter off later and the empty
paragraphs come back exactly as authored.

There is nothing to configure — the filter has no settings of its own. You simply
enable the **Empty paragraph filter** checkbox on whichever text formats you want it
to clean, and (as the maintainers recommend) drag it to the bottom of that format's
filter processing order so other filters run first. It is aimed at sites using a
WYSIWYG/CKEditor; on a site without a rich-text editor, core's *Convert line breaks*
filter is usually enough. The module depends only on core's Filter module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The module has no settings page. You turn the filter on per text format:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to the format you want to clean (for example
   *Full HTML* or *Basic HTML*).
3. Under **Enabled filters**, tick **Empty paragraph filter**.
4. Under **Filter processing order**, drag **Empty paragraph killer** to (or near)
   the **bottom** so the other filters run first — unless a later filter genuinely
   needs to process the cleaned output.
5. Click **Save configuration**.

That's it. From now on, content using that text format renders without the stray
empty paragraphs, while the stored text stays exactly as editors typed it. Repeat
the steps for any other text format (comment formats, newsletter formats, and so on)
where you want the same tidy-up.
