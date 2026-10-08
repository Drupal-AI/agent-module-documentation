# Access Entity by Field Value — manual setup guide

**Access Entity by Field Value** (`access_by_field`) restricts who can view,
update, or delete **nodes and taxonomy terms** by comparing a shared field between
the user and the entity. It lets you drive per-user content visibility from a
field value — for example, a user whose "region" matches a node's "region" can see
it — without writing a custom node-access module.

The idea is simple: you pick one field on the entity and one field on the user
account (both must be the same kind of reference or boolean field), and the module
grants access when their values overlap. Concretely, if the user's field and the
entity's field share at least one referenced item (matching `target_id`), the user
gets in; otherwise they are blocked. You configure this mapping per content
type / vocabulary through an admin UI, and you choose which operations each mapping
restricts — create, view, update, delete.

A couple of important behaviours to keep in mind. Selected roles can be set to
**bypass** all restrictions (the administrator role bypasses by default), so
privileged users are never locked out. For **update** and **delete**, the module
requires the matching core permission *in addition* to the field match. And
because a "forbidden" result from this module overrides other modules' "allowed"
results, it composes conservatively with core node grants. This is best suited to
coarse, field-driven segmentation rather than fine-grained per-item ACLs.

One technical caveat worth flagging: the module returns its access decisions
without per-user cache metadata, so pair it with appropriate cache settings to
keep results correct under page/render caching.

This guide is written for a **human** setting the module up through the admin UI.
If you want the terse, token-cheap reference written for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the settings permission.
2. [Configuration](configuration/index.md) — create field mappings, choose which
   operations to restrict, and set bypass roles.

## Where it lives in the admin menu

The module's configuration lives at **`/admin/config/access-by-field`**, with
sub-pages for adding field mappings, choosing bypass roles, and a dashboard
listing every mapping. All of these require the `access abf mapping settings page`
permission.
