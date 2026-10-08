# CKEditor Div as Block — manual setup guide

**CKEditor Div as Block** (`ckeditor_div_as_block`) configures CKEditor 5 so that
`<div>` elements are handled as block‑level containers in the editor, rather than
the more awkward way CKEditor 5 treats divs by default. This makes structured,
div‑based content easier to edit — you can place your cursor around a `<div>`,
select it, and work with it as a distinct block. It exists to work around a
long‑standing upstream CKEditor limitation with div handling.

The module was built specifically to pair with **CKEditor 5 Plugin Pack Templates**
(`ckeditor5_plugin_pack_templates`) — the maintainers wanted div‑as‑block behavior
for template content without changing how *other* divs on the site are edited — and
it declares that templates module as its dependency. It is a WYSIWYG/authoring
behavior with no settings page and no access‑control role; the markup it produces
still passes through the text format's filters as normal.

Note that the module's own page states it was built with the assistance of an LLM,
and it is minimally maintained. Test it against your content before relying on it
in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. Its div‑as‑block behavior
applies through the CKEditor 5 editing experience once enabled on the relevant
text format.

## How to use it

The module changes how divs behave in CKEditor 5 rather than adding a button you
click. In practice you enable it alongside CKEditor 5 Plugin Pack Templates and
use it on the text format(s) where you author div‑based template content. Confirm
the text format's allowed HTML permits the `<div>` markup you expect to work with,
and test the editing behavior on that format after enabling.
