# Block Library — manual setup guide

**Block Library** (`block_library`) makes Layout Builder's "Add block" picker
easier to scan by giving each of your custom block types its own icon. When an
editor opens the *Choose a block* list while building a layout, every custom
(inline) block type can show a small image or inline SVG next to its name — so a
"Hero", a "Card", and a "Call to action" block are told apart at a glance instead
of reading through a plain text list.

The module does not add any blocks of its own and it has no central settings
page. Instead it adds an **Icon** section to each block content type's add/edit
form, where you either point at an existing image by path or upload one. The icon
you choose is stored as part of that block type's configuration, so it travels
with your config exports between environments.

Under the hood Block Library extends the block picker provided by
**Layout Builder Restrictions** (a required dependency) and swaps in each block
type's icon as the picker renders. SVG icons are inlined so they can inherit your
text color via CSS `currentColor`; other image types (PNG, JPG, GIF) are shown as
a normal `<img>`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module along with its Layout Builder dependencies.
2. [Configuration](configuration/index.md) — how to give each block content type
   an icon, field by field.

## Where it lives in the admin menu

Block Library has **no settings page of its own**. You configure it one block
type at a time on the block content type forms at
**Structure → Block content → Block types** — edit a type (for example
`/admin/structure/block-content/manage/basic`) and you will find the new **Icon**
section there. The icons then appear automatically inside Layout Builder's
"Add block" picker; there is nothing to switch on globally.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit a custom block type and set its **Icon** (see
   [Configuration](configuration/index.md)).
3. Edit a page with Layout Builder, click **Add block → Create custom block**,
   and the block types now show their icons in the list.

Because the icons render on the authoring screen only, keep them to trusted,
sanitized SVG/image assets — the block type forms are limited to administrators
with block-content admin rights, so this is normal trusted-admin territory.
