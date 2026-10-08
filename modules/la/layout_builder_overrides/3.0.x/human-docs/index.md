# Layout Builder View Modes Overrides — manual setup guide

**Layout Builder View Modes Overrides** (`layout_builder_overrides`) removes a
limitation in core **Layout Builder**: normally, per‑entity layout *overrides* can
only be enabled on the **default** full view of an entity. With this module you can
allow Layout Builder overrides on **any** configured view mode — teaser, card, or a
custom view mode you have defined — giving you much finer control over how each
display is laid out on a per‑entity basis.

This is purely a **content‑display / layout** feature. It changes which view modes
can carry their own Layout Builder layout; it does not change the content itself or
its access. Blocks and fields placed in those layouts still respect their own
access rules, and the module has no access‑control role of its own. It depends on
core Layout Builder and belongs to the "Layout Builder" package.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated configuration page** for this module. You enable Layout
Builder overrides per view mode from the entity display screens, described below.

## How to use it

This module extends core Layout Builder's own display settings, so you configure it
from **Structure → Content types → *(your type)* → Manage display** (or the
equivalent *Manage display* screen for any fieldable entity):

1. Switch to the **view mode** you want to lay out (for example *Teaser* or a
   custom view mode) using the view‑mode tabs / the *Custom display settings*
   section on *Manage display*. Make sure that view mode is enabled first.
2. In that view mode's Layout options, tick **Use Layout Builder**, and then the
   option to **allow each content item to have its layout customized** (the
   per‑entity override). Without this module that override option is only offered on
   the default view; the module makes it available on the other view modes too.
3. Save. Now individual entities can carry their own Layout Builder layout for that
   specific view mode, in addition to (or instead of) the default view.
