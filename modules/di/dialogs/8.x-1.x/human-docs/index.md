# Dialogs — manual setup guide

**Dialogs** (`dialogs`) lets you make any link open its target in a Drupal dialog
— a modal or an off-canvas panel — simply by adding a "magic" query string to the
link. There's no custom JavaScript to write and no per-link configuration UI: you
just append the right parameter to the URL, and Dialogs handles the rest.

For example, a menu link to `/node/add/page?dialog=modal` opens the node-add form
in a modal dialog instead of loading a full page. This is handy for quick modals
on menu links, buttons, and other links throughout your site.

Dialogs is purely a presentation feature. It does **not** change access control:
the linked route still enforces its own permissions, so opening something in a
dialog never bypasses access. It has no permissions or settings form of its own,
and supports Drupal 9, 10, and 11.

> **Tip:** To open links inside body text or other filtered content, pair Dialogs
> with the [Render Filter](https://www.drupal.org/project/renderfilter) module, as
> the project suggests. See the module's README for the full list of query-string
> options.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — you control behavior per
link with query strings, described under "How to use it" below.

## Where it lives in the admin menu

Dialogs adds no admin page. You use it by adding query strings to your links —
there is nothing to configure centrally.

## How to use it

Append a dialog query parameter to any link's URL. For example:

- `/node/add/page?dialog=modal` — open the target in a **modal** dialog.
- Use an off-canvas variant to open the target in a side panel instead.

See the module's README for the complete set of supported query-string options.
The route behind the link keeps enforcing its own access, so this only changes how
the target is presented, not who can reach it.
