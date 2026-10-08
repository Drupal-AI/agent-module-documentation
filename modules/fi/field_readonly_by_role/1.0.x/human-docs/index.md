# Field Read-Only by Role — manual setup guide

**Field Read-Only by Role** (`field_readonly_by_role`) lets you mark a field as
**editable for some roles and read-only for others — without hiding it**. Instead
of removing a field from a form for certain users, or maintaining duplicate form
displays, you keep the field visible to everyone and simply prevent the wrong roles
from changing it. It's aimed at editorial workflows where different people share the
same form: editors may need to *see* an administrative field while only admins may
*change* it, moderators may review values without editing them, and so on.

Setup is per field: on a field's configuration you choose which roles can edit it,
and every other role sees it as read-only on the entity edit form. No new content
types, form displays, or text formats are created — the module plugs into your
existing field configuration.

> **Please read this before relying on it — important security limitation.** Field
> Read-Only by Role enforces the restriction **only on the entity edit form**, by
> setting the field widget to "disabled." Drupal's Form API does respect that, so a
> read-only-role user genuinely cannot change the field *through the edit form*. But
> the module implements **no server-side field access** (`hook_entity_field_access`),
> so the read-only rule provides **no protection on any other write path**. A user
> in a "read-only" role who otherwise has permission to edit the entity can still
> change the field via **JSON:API** (`PATCH`, part of core and commonly enabled),
> **REST**, **Quick Edit**, **Views Bulk Operations**, or programmatic code. In
> other words this is a **UI convenience, not a field-access control** — do not rely
> on it to stop a role from editing a sensitive field. If you need real per-role
> field protection that holds everywhere, use a module that implements
> `hook_entity_field_access` (for example Field Permissions).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — mark a field read-only for chosen
   roles on the field's configuration.

## Where it lives in the admin menu

There is no central settings page. You configure the read-only behavior on each
field, from **Structure → Content types (or any entity bundle) → *(bundle)* → Manage
fields → *(field)*** field configuration.
