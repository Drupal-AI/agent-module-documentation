# Entity Browser Block Layout — manual setup guide

**Entity Browser Block Layout** (`entity_browser_block_layout`) is a small UX helper
that makes **Entity Browser blocks easier to use inside Layout Builder**. When you
combine Entity Browser with Layout Builder, placing entity-browser-based blocks into a
layout can feel clumsy. This module applies a set of UX and CSS adjustments that
smooth that experience, so editors can browse for and place entities as blocks more
comfortably in the Layout Builder interface.

It is purely a presentation/usability improvement for the block-placement flow. It
does not add content, change what blocks are available, or touch access control — it
just refines the editing experience where Entity Browser and Layout Builder meet. The
module grew out of an earlier sandbox project and a companion GitHub project.

There is **nothing to configure**: enable it on a site that already uses Entity
Browser blocks in Layout Builder and the improvements apply automatically. It works
on Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — the improvements take effect
automatically once it is enabled.

## Where it lives in the admin menu

The module adds no admin page. Its effect is visible in the **Layout Builder** UI
(for example under **Structure → Content types → (type) → Manage display → Manage
layout**, or when editing an individual entity's layout) when you add or manage
Entity Browser blocks there.
