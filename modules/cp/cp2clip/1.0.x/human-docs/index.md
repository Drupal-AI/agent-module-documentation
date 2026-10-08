# Copy to Clipboard — manual setup guide

**Copy to Clipboard** (`cp2clip`) is a deliberately tiny module that adds a "copy"
button to any element you mark with a CSS class. Wrap some text in a tag carrying the
class `cp-to-clip` — for example `<div class="cp-to-clip">Text…</div>` — and the
module appends a button that copies that text to the visitor's clipboard when clicked.

It solves one small but persistent annoyance: selecting text by hand to copy it is
fiddly, and it is worst for exactly the values people most need — an API key that
wraps across two lines, a long reference number, a shell command, an IBAN, a discount
code. A copy button removes the problem, which is why documentation sites and payment
pages all have one. This module implements it as a **class** rather than a field type
or formatter, so an editor can apply it straight from a WYSIWYG's class control with
no template changes. It ships a small JavaScript file and a little CSS, and has **no
dependencies and no configuration** — install it, add the class, and it works.

Two things are worth knowing before you rely on it. First, a copy control should be
**reachable and announced** — a button that only appears on hover is invisible on
touch and to keyboard users, and a copy that gives no feedback leaves people unsure it
worked; check that the button and its confirmation behave well for everyone. Second,
the browser Clipboard API **requires a secure context**, so copying silently does
nothing on a site served over plain HTTP — make sure you are on HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You use
it entirely by adding a class to your markup, described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Add the class **`cp-to-clip`** to any HTML tag that encloses the text you want to
   be copyable. In a WYSIWYG editor you can do this with the source view or a class
   control; in a template or block you add it directly:

   ```html
   <div class="cp-to-clip">ABCD-1234-EFGH-5678</div>
   ```

3. View the page over **HTTPS** — the module renders a copy button at the end of that
   text, and clicking it copies the enclosed text to the clipboard.

That's the whole workflow. If the button does nothing when clicked, confirm the page
is being served over HTTPS (a secure context is required for the Clipboard API).
