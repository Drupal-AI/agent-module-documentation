# Entity Bundle Permissions — manual setup guide

**Entity Bundle Permissions** (`entity_bundle_permissions`) gives you a simple,
per‑bundle "Access" permission for every content entity type that has bundles — one
for each content type, media type, vocabulary, custom block type, and so on. Once
enabled, a user can only reach an entity if their role has been granted that
bundle's permission. It's a quick way to carve up who can touch which content types
without writing a custom access handler.

The most important thing to understand is that these permissions **only restrict**.
Granting a bundle's permission adds no access a user didn't already have; it simply
stops being a blocker for that bundle. Lacking it, on the other hand, **forbids
every operation** — view, edit, and delete alike — on entities of that bundle. And
because a "forbidden" result always beats an "allowed" one, this overrides
permissive grants from other modules. In practice: after you enable the module, a
role sees a bundle **only if** you've explicitly granted it that bundle's
permission.

That behaviour is broad, so the module lets you **exclude** entity types you don't
want gated (for example users or taxonomy terms) through a short list on its settings
page. There are no plugins, hooks, or Drush commands to learn — just the generated
permissions and one setting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings page, the
   `ignored_entity_types` exclusion list, and how the generated permissions work.

## Where it lives in the admin menu

The settings form is at **Configuration → Entity Bundle Permissions**
(`/admin/config/entity-bundle-permissions`), gated by the **Administer entity bundle
permissions** permission. The generated per‑bundle permissions themselves are granted
on the usual **People → Permissions** page.

> **Heads up:** because the module blocks access to any bundle a role hasn't been
> granted, it's easy to lock yourself (or editors) out of content right after
> enabling it. Plan to grant the needed bundle permissions to your roles promptly —
> see [Configuration](configuration/index.md).
