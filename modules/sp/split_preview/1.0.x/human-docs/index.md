# Split Preview — manual setup guide

**Split Preview** (`split_preview`) upgrades the core *Preview* button on node
add/edit forms into a live, side‑by‑side preview. Instead of the usual redirect to
a separate preview page, the rendered node loads in an iframe right next to the
edit form, and buttons let you switch the iframe's width between **mobile**,
**tablet** and **desktop** — so editors can check how content looks at different
breakpoints without ever leaving the editing screen. It also works on
Layout Builder‑enabled node forms.

Under the hood the module relabels the core *Preview* action to *Live Preview*,
wires it to an AJAX callback, and injects the resulting HTML into the split‑pane
iframe. It is presentation‑only: it adds **no routes, services, permissions,
settings pages or blocks**, and it works entirely inside the existing node‑edit
form. That means access is governed by nothing more than the user's normal node
create/edit permissions, and core handles the form's security token as usual —
there is nothing extra to lock down.

The module works as soon as you enable it and switch on preview for a content
type; there is no configuration form. It has no dependencies beyond Drupal core
and runs on Drupal 8, 9 and 10.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, enable it, and
   turn on preview for your content types.

## How to use it

Split Preview piggybacks on Drupal's built‑in preview setting rather than adding a
control of its own:

1. Log in as an administrator and go to **Structure → Content types**.
2. Edit the content type you want (for example *Article*).
3. Under the content type's settings, set **Preview before submitting** to
   *Optional* or *Required*.
4. Save the content type.

Now, when you add or edit a node of that type, click **Live Preview** and the
rendered node appears in the split pane beside the form. Use the device‑width
toggles to see it at mobile, tablet and desktop sizes.
