# Auto Link — manual setup guide

**Auto Link** (`auto_link`) is a field formatter that automatically turns plain
URLs in a text field into clickable links. Instead of asking editors to wrap
addresses in link markup by hand, you pick the Auto Link formatter for a field
and any URL it finds in that field's output is rendered as a real link when the
content is displayed.

It is a small content-display helper. It changes only how a field is *shown* —
it does not alter the stored value, add content of its own, or touch access
control. The output still passes through Drupal's normal text filtering, and the
module depends only on core's **Filter** module.

There is no settings page. Everything happens where you manage a display: you
choose the formatter, save, and links start appearing. Because of that, this
guide has just two parts — an overview (this page) and installation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Auto Link adds no menu items and no settings page of its own. You reach it
through the normal field display screens under **Structure → Content types →
(your type) → Manage display** (or the Manage display tab of any other
fieldable entity).

## How to use it

1. Go to **Manage display** for the entity type and view mode where the field
   appears.
2. Find the text field whose URLs you want linked.
3. In the **Format** column, choose the **Auto Link** formatter.
4. Click **Save**.

From then on, when that field is displayed, any URLs in its output are turned
into clickable links automatically — no manual link markup required.
