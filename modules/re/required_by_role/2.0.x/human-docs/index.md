# Required by role — manual setup guide

**Required by role** (`required_by_role`) lets you make a field mandatory for
some user roles but optional for others. On a field's settings you tick which
roles the field is required for; when a user in one of those roles fills in the
form, the field is required, and for everyone else it is optional. This is handy
when, say, content authors must complete a compliance field but administrators
should be exempt, or you want to require a byline only for the "journalist" role.

It works as a plugin for the **Required API** module (a hard dependency). Required
API lets each field instance choose *how* its "required" flag is decided at form
build time; this module contributes a "Required by role" strategy that decides it
by comparing the current user's roles against a list you pick. Your selected roles
are stored as exportable configuration on the field.

One important thing to understand: this is a **form‑validation / UX** feature
only. It toggles whether a value must be filled in before the form saves — it does
**not** hide the field or grant/deny access to it. A field that is "not required"
for a role is still fully visible and editable to that role. If you need to
actually restrict who can see or edit a field, use core field access or a
field‑permissions module instead.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Required API is required).
2. [Configuration](configuration/index.md) — choosing the plugin on a field and
   picking the roles.

## Where it lives in the admin menu

There is no settings page of its own. You configure it per field, on the field's
edit form under **Manage fields** (for example **Structure → Content types → …
→ Manage fields → edit**), inside the Required API section.
