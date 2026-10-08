# Redirect on Delete — manual setup guide

**Redirect on Delete** (`redirect_on_delete`) prompts you to create a redirect
whenever you delete content, so the old URL does not simply start returning a 404.
Deleted content often still has inbound links from other sites, bookmarks, and
search results, and it may carry accumulated SEO value — capturing a redirect at
delete time preserves both, sending visitors (and search engines) to a sensible
replacement instead of a dead end.

To make that easy, the module **suggests a default redirect target**: the nearest
parent of the content being deleted, worked out from either the menu structure or
the path. You can accept the suggestion or point the redirect somewhere else. It
builds on the contrib Redirect module, which stores and serves the redirect that
gets created.

The module has no site-wide settings page — the prompt appears as part of the
normal content-deletion flow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Redirect
   module it depends on, and enable it.

There is **no dedicated configuration page** for this module — the redirect prompt
is part of the delete flow, described in "How to use it" below.

## How to use it

1. Delete a piece of content the usual way.
2. As part of the deletion, the module prompts you to create a redirect for the
   URL that is about to disappear. It offers a **suggested target** — the nearest
   parent of the deleted content, determined by menu or path — as a sensible
   default.
3. Accept the suggestion or enter a different destination, then confirm. The
   redirect is created via the Redirect module, so the old URL now points at the
   replacement instead of returning a 404.

This keeps inbound links working and helps preserve the SEO value that would
otherwise be lost when content is removed.
