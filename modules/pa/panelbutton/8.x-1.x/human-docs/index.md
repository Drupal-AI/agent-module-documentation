# Panel Button — manual setup guide

**Panel Button** (`panelbutton`) is a utility plugin for the **CKEditor 4** rich
text editor. It provides the shared floating-panel (toggleable dropdown) UI that
*other* CKEditor button plugins build on — the colour pickers, custom dropdowns,
and palette widgets that need a rich toggle panel. On its own it adds **no toolbar
button** you can see and no features for editors; it exists so that plugins like
**Color Button** have the panel component they depend on.

Under the hood the module registers the upstream CKEditor 4 `panelbutton` add-on
with Drupal's contrib CKEditor 4 editor. You download that add-on library into
your site's `/libraries` folder, enable this module, and then enable the plugin
that requires it. It has no configuration, routes, or permissions of its own.

Two things are worth knowing up front. First, this is a **dependency-only**
module — you install it because something else told you to, not for what it does
by itself. Second, **CKEditor 4 was removed from Drupal core in Drupal 10**, so
this module is only relevant on sites still running the contrib CKEditor 4 editor;
new sites on the default CKEditor 5 do not use it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — download the CKEditor add-on library,
   install the module, and enable it.

There is **no configuration page** — this module has no settings, routes, or
permissions. You enable it and then enable the plugin that depends on it.

## How to use it

Panel Button does nothing visible by itself. The typical flow is:

1. Install and enable Panel Button (see [Installation](installation/index.md)),
   making sure the upstream `panelbutton` CKEditor library is present in
   `/libraries`.
2. Enable and configure the plugin that requires it — for example **Color
   Button** — following that module's instructions.
3. Add that plugin's button to your **CKEditor 4** text format toolbar under
   **Configuration → Content authoring → Text formats and editors**. Its panel UI
   is provided by Panel Button.
