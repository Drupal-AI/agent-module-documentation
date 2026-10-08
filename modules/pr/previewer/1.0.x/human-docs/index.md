# Previewer — manual setup guide

**Previewer** (`previewer`) enhances Drupal's node preview so editors can see how a
node will render **while they're still editing it**, rather than leaving the edit
form to check. It reuses core's preview route as the source for an iframe shown in
an **off‑canvas** dialog: the existing **Preview** button is altered to submit over
AJAX and open that dialog, so the rendered node appears alongside the edit form.

Better still, while the off‑canvas preview stays open it **refreshes itself** as you
change the form — it listens for the standard `formUpdated` JavaScript event that
Drupal core and many modules fire when content changes, so the preview keeps pace
with your edits and cuts down the save‑and‑check cycle.

Currently it focuses on previewing **while editing nodes**; the project's aim is to
grow this into a more general preview base. The preview reflects the content being
edited and respects the viewer's own access — it changes the *editing experience*,
not the content itself or who can see what. It is published under the
**Development** package.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module has no settings. See "How to use
it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit any node and click the **Preview** button as usual. Instead of navigating
   away, an off‑canvas dialog opens showing the rendered node.
3. Keep editing with the dialog open — as you change fields, the preview refreshes
   to reflect your latest input.

There is nothing to configure; the enhanced preview applies to node editing once
the module is enabled.
