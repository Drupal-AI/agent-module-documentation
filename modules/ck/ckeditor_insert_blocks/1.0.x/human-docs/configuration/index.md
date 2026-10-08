# Configuration

CKEditor Insert Blocks is configured entirely on the **text formats** that use
CKEditor 5 — there is no separate global settings page. You add its toolbar
button to a format and then decide which blocks it may insert.

## Add the button to a text format

1. Log in as a user with the **Administer filters** permission (an administrator
   by default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Edit a format that uses **CKEditor 5** as its editor — for example *Full HTML*
   or a custom authoring format.
4. In the CKEditor 5 toolbar configuration, drag the **Insert Blocks** button
   from the *Available buttons* tray up into the *Active toolbar*.
5. Click **Save configuration**.

## Choose which blocks the button offers

This is the most important setting, both for usability and for safety. In the
plugin's settings you can select the specific blocks the button is allowed to
insert. If you leave the selection empty, the button offers **every block on the
site**, which is a much broader grant than most sites want — an editor could
place any block, including ones that render arbitrary markup or attach
JavaScript. Curate the list to the handful of blocks editors should actually be
able to embed (call‑to‑action panels, newsletter signups, specific Views blocks,
and so on).

## Add a CSS class and libraries (optional)

The plugin lets you attach a **CSS class** to the inserted block wrapper, which
is handy for theming the embedded block distinctly from surrounding content. You
can also list one or more custom **libraries** (comma‑separated) to load
alongside the block if it needs extra styling or behavior.

## The re‑rendering filter (optional)

By default the block is stored as a reference and rendered when the page is
built, so clearing the cache re‑renders it with the latest block content — the
text stored in the CKEditor field does not change. If you want each embedded
block's HTML to be processed through the CKEditor 5 filter, enable the module's
filter on the same text format's **Filters** tab. On Drupal 10/11 this path needs
the `symfony/dom-crawler` library installed (see
[Installation](../installation/index.md)).

## A note on Views blocks and caching

A Views block embedded in an article runs the view with its own access checks and
filters, so the result can differ from one viewer to the next. Make sure the host
content's cache metadata accounts for that — otherwise one visitor's results can
be cached and shown to everyone. This is a reason to be deliberate about which
Views blocks you expose through the button.

## Save

Click **Save configuration** on the text format form. The button and its settings
take effect immediately for any field using that format.
