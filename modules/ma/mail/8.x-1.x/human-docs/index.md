# Mail — manual setup guide

**Mail** (`mail`) provides a **configuration entity for the emails your site
sends**. Instead of email content living hard‑coded inside `hook_mail()`
implementations, this module lets those "system emails" — the ones whose text is
defined in code, sometimes made configurable, and often processed to replace
tokens — be defined and managed as **configuration**, which means they can be
edited in the admin UI and exported like any other config. Think of user
registration and password‑reset messages, content‑subscription emails, Commerce
order emails, moderation notifications, event reminders, and the like.

Each **mail message entity** can specify which mail backend to use (overriding the
site setting) and which **mail processor plugin** to run. The processor plugin
does the equivalent work of `hook_mail()`: replacing tokens and so on. Entities
also carry a **`group`** property, which lets a module that defines emails build
an admin list showing only *its own* messages — the bundled **Mail Example**
submodule (`mail_example`) demonstrates exactly this pattern.

This is primarily a **developer / site‑builder building block**. It is described
by its maintainers as a testing ground for eventually replacing `hook_mail()` in
core, so it shines when another module defines its emails as default config
entities and gives you a place to edit them.

> **Note on content.** Email bodies can include tokens and user data. Take care
> that sensitive information is not inadvertently emailed, and gate who can edit
> the email definitions using the module's permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the example submodule.

There is **no single site‑wide settings form** for this module — you manage
individual **mail message** config entities, and the admin lists for them are
provided per group by the modules (such as `mail_example`) that define emails.
See "How to use it" below.

## Where it lives in the admin menu

Mail does not add one central settings page. Instead, modules that define email
messages create their own admin lists — filtered by the message **group** — for
editing those emails. The **Mail Example** submodule is the reference for how such
a list is built and where it appears.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. To see it in action, enable the **Mail Example** submodule, which defines
   example mail message entities and an admin list scoped to their group.
3. As a developer, define your module's emails as **default config entities** with
   a shared `group`, choose a mail backend and processor plugin as needed, and
   (optionally) build a group‑filtered admin list so site editors can adjust the
   subject, body, and recipients without touching code.
