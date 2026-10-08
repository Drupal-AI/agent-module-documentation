# Configuration

Insert Block has no admin settings page of its own. You configure it through
Drupal core's text-format UI, because it works as a filter. This page covers
enabling that filter, the tag syntax your editors will type, and the single
setting the filter offers.

## Enable the filter on a text format

1. Log in as a user who can administer filters (an administrator by default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Click **Configure** on the format you want to support block embedding — for
   example **Full HTML**.
4. Under **Enabled filters**, tick **"Insert blocks"**.
5. Optionally use the **Filter processing order** section to position the filter
   relative to others. It runs its regular expression over the text and injects
   the rendered block markup.
6. Click **Save configuration**.

Only formats where you enable this filter will expand `[block:...]` tags.

> **Security note:** enable this only on **trusted** formats. Anyone who can write
> in a format that has the filter can render *any* block — including
> role-restricted ones if the Check roles setting (below) is turned off. Formats
> available to untrusted or anonymous users generally should not have it.

## Tag syntax for editors

Inside a field that uses an enabled format, type:

- `[block:BLOCK_ID]` — inserts the rendered block.

`BLOCK_ID` can be either of:

- **A placed block's machine name** — e.g. `[block:olivero_syndicate]`. Find it at
  **Structure → Block layout** (`/admin/structure/block`): hover the block's
  **Configure** link and read the last segment of the URL.
- **A custom (content) block's numeric ID** — e.g. `[block:12]`. Find it from the
  block's edit URL under **Content → Blocks** (`/admin/content/block`).

The filter tries to load a placed block first, then falls back to a content block.
A legacy `[block:module=delta]` form is also accepted; the part after the `=` is
used as the ID. Any tag that doesn't resolve to a block is left in the text
untouched, with no error.

## The setting: Check roles permissions

When you enable the filter, it exposes a single checkbox, **Check roles
permissions** (on by default). It controls how placed blocks with role
restrictions behave:

- **Checked (default)** — a placed block's role-visibility rules are enforced.
  Users who lack the block's allowed roles won't see the embedded block. Any
  "negate" setting on the block's role condition is honored.
- **Unchecked** — role visibility is ignored and the placed block always renders,
  regardless of the viewer's roles.

Custom content blocks are never role-checked either way — they always render.

That setting is stored per format inside the format's own configuration
(`filter.format.<format>.yml`), so it exports and deploys like any other text
format setting.
