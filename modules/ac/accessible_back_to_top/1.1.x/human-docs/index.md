# Accessible Back To Top — manual setup guide

**Accessible Back To Top** (`accessible_back_to_top`) adds a "back to top" button
to your pages. As a visitor scrolls down, the button appears and lets them jump
back to the top of the page in one click. The emphasis is on accessibility: the
control is keyboard-operable and screen-reader friendly, so it helps every visitor
navigate long pages, not just mouse users.

It is a small front-end helper. It adds a navigation aid to the page and nothing
else — it does not create content, and it has no role in access control or
permissions. Once enabled, the button works site-wide with no required setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure. Enable the module and the accessible back-to-top
button is added to your pages automatically; it appears once the visitor scrolls
far enough down, and clicking or activating it (by keyboard) scrolls smoothly back
to the top.
