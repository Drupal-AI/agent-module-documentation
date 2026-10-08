# Gaya Popup Module — manual setup guide

**Gaya Popup Module** (`gaya_popup`) provides a configurable popup / dialog box
for showing a message or a piece of content to your visitors — an announcement, a
promotion, or a notice presented in a modal. The popup content is authored by an
administrator and rendered through Drupal's normal display layers. It's part of
the **GAYA** theme/module family, and it lets you tweak the popup's look with a
few editable CSS options.

The module depends on core **Field**, **User**, and **System**, and it provides
its own permissions to control who can manage the popups. It has no
access‑control role beyond that admin permission — it's a content‑display and UI
feature, not a security tool.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no dedicated global settings form documented for this module — you work
with the popup content and its display options directly. See "How to use it"
below.

## How to use it

After enabling the module, an administrator authors the popup's content and its
display options (including editable CSS to match your theme), then the popup is
shown to visitors in a modal dialog. Use it to surface a timely announcement or
promotion without redesigning a page. Because the base styling is intentionally
minimal, expect to add some CSS of your own to match your site's look.
