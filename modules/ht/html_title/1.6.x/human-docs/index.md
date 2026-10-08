# HTML Title — manual setup guide

**HTML Title** (`html_title`) lets a small, admin-controlled set of inline HTML
tags actually render inside **node titles** — page titles, teasers, breadcrumbs,
search results, and the "content has been saved" messages — instead of showing the
raw tags. So a title like `H<sub>2</sub>O` displays with a proper subscript, and a
book name wrapped in `<em>` shows in italics.

Normally Drupal escapes titles for safety, which is why markup you type into a
title field shows up as literal `<sub>` text. HTML Title works around this
**without changing how titles are stored**: editors type the markup into the
ordinary title field, and the module decodes and re-renders it wherever the title
appears. Crucially, it runs each title through a strict filter that only allows the
tags you've configured — everything else is stripped, so titles can't introduce
cross-site scripting. The intended tag set is inline-only, such as `em, sub, sup,
b, i, strong, cite, code, bdi, wbr`; the shipped default allows `<br>`, `<sub>`,
and `<sup>`.

You control the allowed tags from a simple settings form, gated by an **Administer
HTML title settings** permission. Beyond node titles, the module provides an
**HTML-title text** field formatter you can apply to any plain-string field so its
value renders the same way, and it automatically upgrades the node **Title** field
in Views so listed titles show the markup too. HTML Title depends only on core's
**Node** module and has no third-party requirements or submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the
`html_title.filter` service and the Views field handler — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the allowed-tags setting, the field
   formatter, and the Views title field.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → User interface → Html
title** (`/admin/config/user-interface/html_title`).

## How to use it

Enable the module, then just type inline markup straight into a node's **Title**
field — for example `H<sub>2</sub>O` or `<em>Moby Dick</em>`. The title renders
that markup everywhere it's shown, as long as the tags you used are on the allowed
list. To change which tags are permitted, or to render marked-up values on other
string fields, see [Configuration](configuration/index.md).
