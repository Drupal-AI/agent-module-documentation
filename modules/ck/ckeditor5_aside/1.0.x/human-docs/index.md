# CKEditor 5 Aside — manual setup guide

**CKEditor 5 Aside** (`ckeditor5_aside`) adds an `<aside>` option to CKEditor 5's
headings/block dropdown — the same list where you normally pick *Paragraph*,
*Heading 2*, and so on. CKEditor 5 ships with paragraphs and headings but has no
built-in way to mark a block as an aside, and this small module fills that gap by
putting **Aside** at the top of that list.

When an editor applies the aside format, the module simply wraps the block in an
`<aside>…</aside>` tag — for example `<aside>This is an aside</aside>`. It also
adds a little styling (a float, border, and shadow) *inside the editor only* so
the aside stands out while you are writing. That styling is deliberately **not**
carried through to your front-end theme, so you will need to style asides yourself
in your theme's CSS to make them look the way you want on the published page.

This is intentionally a do-one-thing module. It works on a single block of text
with no other tags inside it (swapping an aside for an `<h3>` or `<p>` behaves as
expected). It does **not** yet handle wrapping several tags at once — if you need
that, the project is open to contributions. Its only dependency is core's CKEditor
5 module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. Once enabled, you make the
Aside format available on a per‑text‑format basis, described below.

## How to use it

CKEditor 5 Aside has no admin settings screen (its configure route is empty). You
turn it on per text format:

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Edit the text format whose editor is CKEditor 5 (for example *Full HTML*).
3. In the CKEditor 5 toolbar configuration, make sure the **Style/Heading**
   dropdown (the block-format dropdown) is in your active toolbar — that is where
   the new **Aside** option appears.
4. Check that the text format's **Allowed HTML tags** permit the `<aside>` tag if
   you are using the *Limit allowed HTML tags* filter, otherwise the tag will be
   stripped on save.
5. Save the text format.

Now editors can place the cursor in a block, pick **Aside** from the block-format
list, and the block is wrapped in `<aside>`. Remember to add styling for `aside`
in your theme so it renders as intended on the front end.
