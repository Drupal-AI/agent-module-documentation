# Mini Layouts — manual setup guide

**Mini Layouts** (`mini_layouts`) lets you build a **reusable layout section** —
several blocks arranged in a Layout Builder layout — and then place that whole
section anywhere as a single block. It's the spiritual successor to the old "Mini
Panels", rebuilt on top of core **Layout Builder**. Design a call-to-action band,
a footer built from columns of blocks, a sidebar "widget stack", or a branded hero
once, and drop it into as many pages as you like. Edit the mini layout in one
place and every placement updates — that central reuse is the whole point.

Each mini layout is a configuration entity you create at **Structure → Mini
Layouts**. You give it an administrative label and category (which control how it
appears in the block chooser), optionally declare **required contexts** it needs —
for example the current node — and then arrange its blocks on a familiar Layout
Builder canvas. Once saved, it shows up in the block library as a normal block you
can place in a theme region via Block Layout, or inside another Layout Builder
section.

Because the sections are stored as standard, portable configuration, mini layouts
can be **exported and deployed** between environments like any other config. The
module requires core Layout Builder and adds a single permission, **administer mini
layouts**, that governs who can create and manage these reusable sections.

This guide is written for a **human** building layouts through the admin UI. If you
want terse, token-cheap references for an AI coding agent (the config entity shape,
the block deriver, the section-storage plugin, and the render flow), read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create a mini layout, set its label,
   category and required contexts, build its layout, and place it as a block.

## Where it lives in the admin menu

Mini layouts are managed at **Structure → Mini Layouts**
(`/admin/structure/mini_layouts`). Managing them requires the **administer mini
layouts** permission.

## How to use it

Create a mini layout, give it a label and category, arrange blocks on its Layout
Builder canvas, then place the resulting block wherever you place blocks. See
[Configuration](configuration/index.md) for the step-by-step, including how
required contexts work.
