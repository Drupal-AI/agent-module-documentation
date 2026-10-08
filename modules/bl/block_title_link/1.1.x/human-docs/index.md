# Block Title Link — manual setup guide

**Block Title Link** (`block_title_link`) does exactly what its name says: it lets you
turn the **title (label) of any block** into a clickable link. Want your "Latest news"
block heading to link to the news listing, or a promo block's title to point at a
landing page? This module adds those options right inside the normal block placement
form — there's no separate admin page and nothing global to set up.

When you place or edit a block, you'll find a small **Block Title Link Settings**
section in the block's advanced options. There you choose where the title should link
(pick a node by name with autocomplete, or type an internal path or external URL),
optionally add a tooltip, choose how the link opens (same tab, new tab, and so on),
and flip the **enable** switch. Turn the switch off and the title renders as plain
text again — without losing the URL you configured, so you can toggle it whenever you
like.

The module is tiny and unobtrusive: it changes only the block's label into a link and
leaves the rest of the block markup untouched. It stores its settings on the block
itself (as third‑party settings), inherits the standard *administer blocks*
permission, and adds no config page, schema, or Drush commands of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. The options appear on each block's configuration
form under **Structure → Block layout** (`/admin/structure/block`), in a
**Block Title Link Settings** section within the block's advanced options.

## How to use it

1. Install and enable the module.
2. Go to **Structure → Block layout** and edit (or place) a block.
3. Expand the **Block Title Link Settings** section and fill it in:
   - **Title Link Url** — where the title links to. Start typing to autocomplete a
     node by name, or enter an internal path (like `/about`) or an external URL.
   - **Link Title** — optional tooltip text (the link's `title` attribute).
   - **Link Target** — how the link opens: same window (`_self`), a new tab
     (`_blank`), or a named frame (`_parent` / `_top`).
   - **Enable** — the master switch. Tick it to make the title a link; untick it to
     show the plain title again while keeping your URL for later.
4. Save the block. Its title now renders as a link.

That's the whole feature — everything is configured per block, right where you place
it.
