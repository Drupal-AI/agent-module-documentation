# URL Alias Permissions — manual setup guide

**URL Alias Permissions** (`url_alias_permissions`) gives you fine‑grained control
over who can edit the **URL alias** (path) field on your content. Out of the box,
Drupal only lets you grant the single, all‑or‑nothing **Create URL aliases**
permission — anyone with it can set custom aliases on *everything*. This module
replaces that coarse switch with a permission per entity type, and per bundle for
bundle‑granular types like nodes.

Once enabled, the module generates permissions such as **Create and edit Page
Content URL alias** (`edit page node url alias`) or **Create and edit Article
Content URL alias** (`edit article node url alias`) — one for each content type,
taxonomy vocabulary, media type, or any other entity type that has a path field.
You then assign these on the normal Permissions page. A role that holds the
specific permission can edit the alias field on that type; a role that doesn't
simply falls back to Drupal's default behavior (the field is hidden unless they
hold a core alias permission).

The module is **grant‑only**: it opens up the path field for the roles you choose,
and it never adds new denials or overrides another module that hides the field.
The core **Create URL aliases** and **Administer URL aliases** permissions keep
working as global overrides — a user with either still has alias access
everywhere, exactly as before. This pairs nicely with Pathauto: let most content
auto‑generate its paths while a trusted role edits aliases on just a few types.

There is **no configuration form** — you do everything from the standard People →
Permissions page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

The module adds no pages of its own. Its generated permissions appear on the
standard permissions page at **People → Permissions**
(`/admin/people/permissions`), grouped under the module name.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **People → Permissions** (`/admin/people/permissions`).
3. Find the URL Alias Permissions section. You'll see one permission per entity
   type, and — for bundle‑granular types like content — one per bundle, with
   titles like *Create and edit Page Content URL alias*.
4. Tick the box for each role that should be able to edit the alias on that type,
   then **Save permissions**.
5. Users in those roles will now see and be able to edit the URL alias field on
   the matching content forms.

> **Tip:** After adding a new content type, media type, or vocabulary, clear
> caches so its new permission shows up on the Permissions page.
