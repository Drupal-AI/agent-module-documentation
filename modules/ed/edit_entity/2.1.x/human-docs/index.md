# Edit Entity — manual setup guide

**Edit Entity** (`edit_entity`) adds a quick **"Edit {entity}"** button to the
admin toolbar whenever you're viewing an entity's canonical page — a node, a
taxonomy term, a user, a media item, or any custom content entity that has both a
canonical page and an edit form. When translation is available for that entity, it
also adds a **"Translate {entity}"** button. It saves you a click by jumping
straight from *viewing* something to *editing* it.

The module is toolbar‑only and respects access properly. Before showing the Edit
button it loads the entity and checks `$entity->access('update')`, so the link only
appears when the current user genuinely has update access — it is a shortcut, not
a new way in. The Translate button appears only when core's translation access
check passes and the translation overview route exists, and it's multilingual‑aware
(it targets the current‑language translation). It defines **no routes,
permissions, services, or configuration** of its own.

It works the moment you enable it — there is nothing to configure. You do need the
core **Toolbar** enabled and a user who can see the admin toolbar. It pairs
naturally with [Admin Toolbar](https://www.drupal.org/project/admin_toolbar) for a
fuller editorial navigation experience.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the module has no settings form. It works
automatically once enabled.

## How to use it

1. Make sure the core **Toolbar** module is enabled and you're logged in as a user
   who can see it (and who has update access to the content you're browsing).
2. Visit any entity's page — a node, term, user, or media item.
3. Look in the admin toolbar for **Edit {entity}** (and **Translate {entity}** on
   translatable entities). Click it to jump straight to the edit (or translate)
   form.

The button includes the entity's type label and id for clarity, and it varies per
page. Disabling the module removes the buttons cleanly, with no leftover
configuration.
