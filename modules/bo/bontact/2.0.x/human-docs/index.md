# Bontact — manual setup guide

**Bontact** (`bontact`) embeds the **Bontact** live‑chat and contact widget on
your site. Bontact is a third‑party service that offers chat, messaging and other
contact channels through a single on‑page widget; this module places that widget
on your Drupal pages so visitors can reach you directly.

The widget is loaded from **Bontact's own third‑party script**, so the chat and
messaging experience runs on Bontact's side — review its privacy and data‑flow
implications before adding it, since it means loading external code on your pages.
You connect your site to your Bontact account with a widget/account identifier
from your Bontact dashboard; this is a public embed ID, not a secret API key, so
there is no credential to store. This release supports Drupal 9, 10 and 11.

It is a front‑end integration with no content model or access‑control role of its
own, and it provides its own permission for controlling who may configure it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

1. Sign in to your **Bontact** account and find your widget/account identifier in
   its dashboard.
2. In Drupal, open the module's Bontact settings and enter that identifier.
   (Make sure your role has the permission the module provides for administering
   it — set roles under **People → Permissions**.)
3. Save. The Bontact widget then loads on your site's pages so visitors can start
   a chat or contact you.
