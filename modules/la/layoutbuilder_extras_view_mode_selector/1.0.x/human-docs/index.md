# Layout Builder extras - View mode selector — manual setup guide

**Layout Builder extras - View mode selector**
(`layoutbuilder_extras_view_mode_selector`) improves the view‑mode picker an editor
sees when placing a block in
[Layout Builder](https://www.drupal.org/docs/8/core/modules/layout-builder). It
lets a site builder choose **which** view modes are offered, and attach **icons**
so the choice is visual rather than a long list of machine‑ish labels.

On a mature site, Layout Builder exposes every view mode configured for a block
type — `Default`, `Teaser`, `Card`, `Card wide`, `Card no image`, `Full`, and often
a handful of internal modes that were never meant for editors. The result is a
dropdown where the right answer is hard to find and the wrong answers look alike.
This module narrows and illustrates it: on each block content type you mark which
view modes should be exposed to the front end and assign an icon or image to each,
turning the picker into a visual, curated set of choices.

It builds on Drupal core rather than adding extra fields or bespoke storage, so the
result is deployable: the icon path and the exposed‑mode selection are stored in
configuration and export like any other config. Hidden view modes still exist and
remain fully usable from code, Views, and other renderers — the module only changes
what editors are *offered*, never what is possible.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Layout Builder.

There is **no settings page of its own**. You configure it per block content type,
on the block type's edit form, as described below.

## Where it lives in the admin menu

The module adds no standalone admin page. Its options live on each **block content
type** edit form under **Structure → Block types**
(`/admin/structure/block-content/manage/{type}`), so access follows whoever may
administer block types.

## How to use it

1. Make sure core's **Layout Builder** is enabled and you are placing block content
   in layouts.
2. Go to **Structure → Block types** and edit the block content type you want to
   curate.
3. On the edit form, choose **which view modes** should be exposed to editors in
   the Layout Builder picker, and assign an **icon/image** to each exposed mode.
4. Save the block type.
5. When an editor now places a block of that type in Layout Builder, the view‑mode
   picker shows only the modes you exposed, illustrated with your icons.
