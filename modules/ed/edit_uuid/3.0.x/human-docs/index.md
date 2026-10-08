# Edit UUID — manual setup guide

**Edit UUID** (`edit_uuid`) exposes an entity's **UUID** on its edit form so a
permitted user can set it by hand. Drupal assigns every entity a UUID at creation
and treats it as the stable identity that JSON:API, content‑deployment tools,
default content, and configuration dependencies all match on. That works — until
the *same* logical content exists in two places with *different* UUIDs: content
recreated by hand on production, an entity restored from a partial backup, a
default‑content export whose target already exists. At that point the tools that
match on UUID see two different things. Edit UUID is how you correct that: it lets
you align a UUID across environments when content is deployed or synchronised
rather than migrated.

You choose exactly **which entity types and bundles** expose the UUID field. That's
done through an `edit_uuid_config` configuration entity — you create one or more
named settings, each targeting an entity type (for example *node*) and one or more
bundles (for example *Article*), and only those get the editable UUID field on
their forms. There's also a **UUID field formatter** you can enable on *Manage
display* to show the UUID on the entity's view page.

Three permissions separate the concerns: administering the module's config, *seeing*
the UUID on a form, and *editing* it. A strong caution: **treat "Edit UUID" as a
migration‑window permission, not a standing grant.** Changing a UUID rewrites the
identity other systems match on — a JSON:API consumer, a deployment tool, or a
config dependency pointing at the old value simply stops resolving, and nothing in
Drupal will warn you. Grant the edit permission only for the reconciliation window
you need it, then revoke it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the PHP
   requirement, and enable the module.
2. [Configuration](configuration/index.md) — create the settings that expose the
   UUID field, assign the permissions, and (optionally) show the UUID on display.

## Where it lives in the admin menu

Edit UUID's settings live at **Configuration → Development → Edit UUID config**
(`/admin/config/development/edit-uuid-config`), where you manage the collection of
`edit_uuid_config` settings entities. Its three permissions are on **People →
Permissions**. See [Configuration](configuration/index.md) for the full walkthrough.
