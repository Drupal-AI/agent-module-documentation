# Layout Builder Customizer — manual setup guide

**Layout Builder Customizer** (`layout_builder_customizer`) is a small
convenience layer on top of core's Layout Builder that tidies up the editing
experience and adds a few time‑savers for people who work with layouts every day.

It does three things. First, it offers a **Disable** option in its settings form:
when ticked, it removes the "Allow each content item to have its layout
customized" checkbox from the *Manage display* page of the relevant entity type —
useful when you want to keep per‑entity overrides off. Second, it adds quick
**Configure / Move / Remove** action links that appear when you hover over a block
in a layout, so common block operations are one click away instead of buried in a
contextual menu. Third, it adds a **Layout** operation link to Layout Builder
content on content‑listing pages, so you can jump straight into editing a page's
layout from the list.

It is a site‑building / UX tool: it changes how the Layout Builder interface
behaves, not who may see or edit content. Enable it if these conveniences suit
your editorial workflow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the module's settings form, including
   the Disable option.

## Where it lives in the admin menu

The hover action links and the **Layout** operation link appear inside the Layout
Builder interface and on content‑listing pages once the module is enabled. Its own
settings form (described in [Configuration](configuration/index.md)) is where you
toggle the **Disable** option.
