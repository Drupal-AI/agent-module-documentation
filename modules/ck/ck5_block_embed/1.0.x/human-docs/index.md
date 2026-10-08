# CKEditor5 block embed — manual setup guide

**CKEditor5 block embed** (`ck5_block_embed`) adds a toolbar button to CKEditor 5
that lets editors insert Drupal **blocks** directly into body text. It handles three
kinds of block: **content blocks** (basic or custom reusable blocks), **view
blocks** (a Views display, ideal for dynamic or templated listings), and **region
blocks** (the layout regions of your active theme, so you can place core, contrib,
or custom blocks within a region — including "readonly" regions that don't render
on the front end).

The appeal is pragmatic. When an editor wants a related-content view partway down an
article, a call-to-action between sections, or a signup block at the end, the
structured answers (a paragraph type or Layout Builder) are a larger change to how
the site is built, and the unstructured answer (pasting raw embed code) is fragile.
This button is the middle path — and crucially it keeps the block as a **reference**:
the block is rendered at display time, so updating the block updates every article
that embeds it. The module depends on core **CKEditor 5** and supports Drupal 10 and
11.

**One thing deserves more weight than its name suggests: the `use ck5 block embed
button` permission.** Understand it before granting it. Embedding a *view block* runs
a view inside the article, with the view's own access and filters — correct, but it
means the result varies by viewer, so the page's cache metadata must account for it.
Embedding a *region block* places whatever is in that region — site chrome under
someone else's control. And blocks can render arbitrary markup and attach
libraries, so the ability to drop any block into body text is closer to a
site-building permission than an editing one. Grant it to the people who would
otherwise be placing blocks in block layout, and check which blocks the button
actually offers — an unrestricted list is a much larger grant than a curated one.

> **Avoid loops:** never embed a block inside itself (or otherwise create a
> self-containing chain). Doing so creates an infinite loop that can break the editor
> and page rendering.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no standalone settings page. You turn the feature on per text format at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), and you grant the button permission at **People →
Permissions**.

## How to enable the button in a text format

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the format your editors use (for example *Full HTML*).
2. In the CKEditor 5 toolbar configuration, drag the **Embed Block** icon from the
   available items up into the active toolbar.
3. In the format's **Enabled filters**, tick the **Embed blocks** filter so the
   embedded blocks are rendered on output.
4. Save the format.
5. At **People → Permissions**, grant **`use ck5 block embed button`** only to the
   trusted roles that should be allowed to embed blocks (see the caveat above).

Now, when editing content with that format, editors can click the **Embed blocks**
icon and choose a content, view, or region block to insert.
