# Flag — manual setup guide

**Flag** (`flag`) lets you create custom "flags" — toggleable markers such as
*bookmark*, *favorite*, *like*, *follow*, *subscribe*, or *report* — that users
set on content and other entities. Think of a flag as a boolean relationship: a
user (or, for a global flag, the whole site) either has flagged a given node,
comment, or user, or they haven't. Clicking the flag link toggles that state,
usually over AJAX so the page never reloads.

Site builders create flags at **Structure → Flags**. For each flag you choose the
entity type it applies to (and, optionally, which bundles), the link text and
messages for both flagging and unflagging, whether the flag is per‑user or global,
and which "action link" style to use. Because each flagging is stored as its own
entity, you can even attach fields to a flag — for example a "reason" field on a
*report* flag.

Flag is highly extensible. It defines two plugin types — **Flag Type** plugins
(entity, comment, user) that decide *what* can be flagged, and **Action Link**
plugins (AJAX link, confirmation form, reload, field‑entry form) that decide *how*
the interaction renders. It ships a `flag` service for flagging and unflagging in
code, a count manager, Twig `flagcount()` and `flaglink()` functions, Views
integration (relationships, fields, and filters on flaggings), and events fired on
every flag and unflag. Every flag you create automatically gets its own *use*
permissions, so you can grant flagging of a specific flag to specific roles. Three
example submodules — **Bookmark**, **Follower**, and **Count** — demonstrate common
setups.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the example submodules you want.
2. [Configuration](configuration/index.md) — creating and configuring a flag,
   field by field, plus the permissions each flag generates.

## Where it lives in the admin menu

Flags are managed at **Structure → Flags** (`/admin/structure/flags`, route
`entity.flag.collection`). This is where you add, edit, and order the flags on your
site. Each flag's own fields (for the flagging entity) live on that flag's **Manage
fields** tab.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Flags → Add flag** and pick what you want to flag (content,
   comment, or user).
3. Fill in the flag's link text, messages, scope (per‑user or global), and action
   link type — see [Configuration](configuration/index.md).
4. Grant the flag's *use* permission (`flag <name>` / `unflag <name>`) to the roles
   that should be able to toggle it, under **People → Permissions**.
5. Optionally build a View using the flag relationship to list everything a user
   has flagged, or drop a `flagcount()` count into a Twig template.
