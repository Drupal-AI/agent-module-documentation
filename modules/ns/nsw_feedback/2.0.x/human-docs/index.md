# NSW Feedback — manual setup guide

**NSW Feedback** (`nsw_feedback`) provides ready‑made **blocks for the NSW
(New South Wales) OneGov feedback and sentiment widgets**. If you run a
NSW‑government Drupal site, this module lets you drop the standard "was this page
helpful?" feedback and customer‑sentiment widgets into your block regions instead
of hand‑coding the OneGov integration. Version 2.x adds the **customer sentiment
check** widget alongside the original feedback widget.

There is an important prerequisite: the widgets only work once your **domains are
registered with OneGov**. The module also lets you specify a **custom path to the
OneGov JavaScript file** from the admin UI, which is useful if you need to point
at a specific version or location of that script.

It ships an optional submodule, **`nsw_feedback_assist`**, and depends on core
**Block**. Because the widgets collect visitor feedback and sentiment and send it
to the OneGov service, treat this as a **data/privacy** consideration — be sure
your site's privacy notices cover what is collected and where it goes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it (and
   optionally the assist submodule), and place the blocks.

This module has **no dedicated settings page** (`configure` is null). Its setup is
done by placing the feedback blocks and, if needed, setting the custom
JavaScript path — both covered in "How to use it" below.

## Where it lives in the admin menu

You work with NSW Feedback from **Structure → Block layout**
(`/admin/structure/block`), where you place the OneGov feedback and sentiment
blocks. The custom JavaScript path is set from the module's own admin UI.

## How to use it

1. Make sure your site's **domains are registered with OneGov** — the widgets
   depend on this to function.
2. Go to **Structure → Block layout** and place the **feedback** block (and, in
   2.x, the **sentiment** block) in the region where you want them, typically
   near the bottom of the page content.
3. If you need the widgets to load a specific OneGov JavaScript file, set its
   **custom path** in the module's admin UI.
4. If you want the extra behaviour it provides, enable the **`nsw_feedback_assist`**
   submodule.
