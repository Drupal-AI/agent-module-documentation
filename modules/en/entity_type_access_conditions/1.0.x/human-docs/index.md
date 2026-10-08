# Entity Type Access Conditions — manual setup guide

**Entity Type Access Conditions** (`entity_type_access_conditions`) lets you
restrict operations on entity types and their bundles — creating, viewing,
updating, or deleting — using reusable **condition plugins**, without writing a
custom access hook. It builds on the [Conditions
Helper](https://www.drupal.org/project/conditions_helper) module, which wraps
core's Condition plugins (things like current user role, request path, language,
and any contexts your site provides) into a friendly form.

Out of the box it adds an **Entity Type Access Conditions** section to the config
forms of Node types, Media types, and Taxonomy vocabularies. There you build a set
of conditions, and at runtime the module enforces them: for a restricted
operation, if the conditions are **not** met it denies access; otherwise it stays
out of the way and lets core and other modules decide. This is important to
understand — the module is **purely additive and can only deny**. It never grants
access on its own, so it layers restrictions on top of your normal permissions
rather than replacing them.

By default the restrictions are modest: for the *content* entities (node, media,
taxonomy term) only the **create** operation is gated, while the richer
create/update/delete/view operations apply to the *bundle configuration* entities
(the node type, media type, and vocabulary config). That means, for example, that
configuring a "view" condition on a content type does not by itself restrict
viewing the content items — keep that in mind before you rely on it for
content-level access.

Two security-sensitive permissions gate the feature: **Administer entity type
access conditions** (choose which condition plugins are available) and **Bypass
entity type access conditions** (always pass, skipping this module's checks).
Developers can extend it to their own entity types by shipping a small YAML plugin
file.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside
   Conditions Helper, enable it, and grant the permissions.
2. [Configuration](configuration/index.md) — the settings page, adding conditions
   to a bundle, and which operations are restricted by default.

## Where it lives in the admin menu

The settings page is at **Configuration → Content authoring → Entity Type Access
Conditions** (`/admin/config/content/entity-type-access-conditions`). The
per-bundle conditions are set on the edit form of each supported bundle — for
example **Structure → Content types → (edit a type)**.

## How to use it

1. On the settings page, choose which condition plugins editors are allowed to use.
2. Edit a supported bundle (a content type, media type, or vocabulary) and fill in
   the **Entity Type Access Conditions** section with the conditions you want.
3. When someone attempts a restricted operation on that bundle, the module
   evaluates the conditions and denies the operation if they are not met.

See [Configuration](configuration/index.md) for the details and the default
operation map.
