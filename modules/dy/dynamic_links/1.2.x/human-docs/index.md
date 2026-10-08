# Dynamic Links — manual setup guide

**Dynamic Links** (`dynamic_links`) lets you create a single link that **combines
several other links and sends the visitor to the first one they can access**. It's
built for sites where users have multiple roles and a home‑page link or menu link
needs to resolve differently depending on who's viewing — one link definition, many
possible destinations, each access‑checked.

You define a dynamic link as a **configuration entity**: give it a label, add as many
candidate links as you like, and the module resolves to the first available one for
the current user. There are two resolution modes. By default it **redirects** the
visitor to the available link; alternatively, **subrequest mode** displays the content
of the available link *without* a redirect, so the URL stays put while the right
content is shown. Because targets are ordinary links, they respect normal access
rules, and the module adds its own **permission** on top.

Dynamic Links is the supported successor to the older, now‑obsolete **Dynamic front**
module — if you previously used that for role‑aware front pages, this is where to move
to. It targets Drupal 10.3 and 11 and has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings form** — you create dynamic links as individual
configuration entities, described in "How to use it" below.

## Where it lives in the admin menu

You create and manage dynamic links under **Structure** — the add form is at
`/admin/structure/dynamic-link/add`. Each dynamic link you create is a configuration
entity, so it exports and imports with your site configuration.

## How to use it

1. After enabling, go to **`/admin/structure/dynamic-link/add`**.
2. Give the dynamic link a **label**, and add the **candidate links** you want to
   combine — add as many as you need, in the order they should be tried.
3. Choose how it resolves: leave the default to **redirect** the visitor to the first
   available link, or enable **subrequest mode** to display that link's content
   without redirecting (the URL doesn't change).
4. **Save.** You can then use the dynamic link where you need context‑aware
   linking — for example as a menu link or in a block — and it will resolve
   per‑visitor to the first link they're allowed to access.
5. Grant the module's **permission** to the roles that should be able to manage
   dynamic links, under **People → Permissions**.
