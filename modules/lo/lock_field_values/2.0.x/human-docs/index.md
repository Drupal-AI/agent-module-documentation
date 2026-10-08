# Lock Field Values — manual setup guide

**Lock Field Values** (`lock_field_values`) lets administrators and editors **lock
the value of a field on an individual entity** so that it can't be changed by users
who don't hold the unlock permission. It's a content-integrity tool: once a value
is locked — a price, a legal disclaimer, a URL slug, any field where an accidental
or unauthorized edit would be costly — only someone with the right permission can
change it back.

The way it works is deliberately simple. The module adds a new **field setting**,
"Administrator can lock values," to any field you choose. Turn that on for a field,
and the field becomes lockable per entity. It also introduces a **"Lock and unlock
fields"** permission; grant that to the roles you trust to lock and unlock values.
It depends only on core's Field module.

One point to keep clear when you adopt it: this governs **who may change a locked
field's value, not who may view it.** It restricts editing (enforced on the edit
form and through field access), so it complements — rather than replaces — normal
Drupal field and entity access. If you need to hide a field from certain users, use
field/entity access; use Lock Field Values when you want a value to stay put.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** for this module. You configure it per field
through the standard Field UI, and via the "Lock and unlock fields" permission,
both described under "How to set it up" below.

## Where it lives in the admin menu

Lock Field Values adds no admin page of its own. You work with it in two places:

- **Structure → *(content type)* → Manage fields → *(field)* → field settings** —
  where you enable "Administrator can lock values" for a field.
- **People → Permissions** (`/admin/people/permissions`) — where you grant the
  "Lock and unlock fields" permission.

## How to set it up

1. **Enable locking on a field.** Edit the field settings for each field you want
   to make lockable, and check **"Administrator can lock values."** Only fields
   with this enabled can be locked.
2. **Grant the permission.** On **People → Permissions**, give the **"Lock and
   unlock fields"** permission to the administrator (or other) roles that should be
   allowed to lock and unlock values.
3. **Lock values as you edit content.** Users with the permission can now lock a
   value on an entity. Once locked, users without the permission can no longer
   change that field's value on the edit form.

Remember: locking controls the ability to **change** the value, not to see it.
