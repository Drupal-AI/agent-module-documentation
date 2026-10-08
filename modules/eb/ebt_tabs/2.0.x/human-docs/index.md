# EBT Tabs — manual setup guide

**Extra Block Types (EBT): Tabs** (`ebt_tabs`) adds a reusable **Tabs** block type to your
site, part of the EBT family of block-based page-building components. Each tab in the block can
hold a different kind of content — formatted rich text, a referenced page/node, a placed
block, or an embedded View — and the whole thing renders with the jQuery UI Tabs plugin. It's
a code-free way to build FAQ sections, product-detail tabs, or tabbed feature breakdowns on a
landing page, either through the block UI or in Layout Builder.

When you enable the module it installs a *EBT Tabs* block content type and an `ebt_tab`
Paragraph type. A Tabs block holds any number of tab paragraphs; for each tab you set a title,
pick a content type (text / page / block / views), and fill in the matching field — the form
automatically shows only the relevant field for your choice, and validates that you filled it
in. A settings field lets you pick a visual **style preset** (minimalist, buttons, vertical,
rotated vertical, and more) that is passed through to the jQuery UI Tabs JavaScript.

EBT Tabs has no admin settings page and no permissions of its own — it relies on core's block
and paragraph permissions. It builds on **EBT Core** and combines nicely with the other EBT
block types (accordion, carousel, columns, …) for a full block-based page builder.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies with
   Composer and enable it.

## How to use it

Enabling the module installs the structures; you then create Tabs blocks and add tabs.

1. Go to **Structure → Block layout → Add custom block → EBT Tabs** (or add an *EBT Tabs*
   block inside Layout Builder).
2. **Add one or more tabs.** For each tab:
   - Enter a **tab title** (the label on the tab).
   - Choose the **content type** for the tab: **Text**, **Page**, **Block**, or **Views**.
   - Fill in the value field that appears for your choice — the form shows only the relevant
     one:

     | Content type | You provide |
     |---|---|
     | **Text** | Formatted (rich-text) body copy. |
     | **Page** | A reference to an existing node/page. |
     | **Block** | A placed block (via the Block Field). |
     | **Views** | An embedded View (via Views Reference). |

   You can mix different content types across the tabs of one block.
3. **Pick a style preset** in the EBT settings for the block:
   - **Default**
   - **Without header background** (`without_header_background`)
   - **Minimalist tabs** (`minimalist_tabs`)
   - **Tabs like buttons** (`tabs_like_buttons`)
   - **Vertical tabs** (`vertical_tabs`)
   - **Vertical tabs rotated** (`vertical_tabs_rotated`)
4. **Save** the block and place it in a region (or position it in Layout Builder).

Because a Tabs block is reusable custom-block content, you can drop the same block on several
pages. On save, the built-in validation requires each tab's chosen content field to be filled,
so you can't accidentally publish an empty tab.
