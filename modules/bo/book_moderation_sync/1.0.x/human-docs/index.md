# Book Moderation Sync — manual setup guide

**Book Moderation Sync** (`book_moderation_sync`) keeps the content‑moderation
state of a core **Book**'s pages in step across the book hierarchy. When a book
page's moderation state changes — for example moving from published to archived —
this module synchronizes its child pages' states to match, so an entire book's
workflow status stays consistent instead of drifting page by page.

It is an editorial‑workflow enhancement that sits on top of core's **Content
Moderation** and **Book** modules. It has no content model or access‑control role
of its own — it simply propagates state changes you make through the normal
moderation workflow. It targets Drupal 10.3+ and 11.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it depends on core Content Moderation and Book).

## How to use it

There is no dedicated settings screen. Once your books use a moderation workflow
(core Content Moderation applied to the relevant content type), the syncing
happens as part of the normal editorial flow: when you change a book page's
moderation state, its child pages are updated to keep the book's workflow status
consistent. Set up your workflow through core Content Moderation as usual, and
Book Moderation Sync handles the propagation.
