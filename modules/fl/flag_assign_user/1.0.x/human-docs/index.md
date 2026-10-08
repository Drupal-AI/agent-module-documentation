# Flag Assign User — manual setup guide

**Flag Assign User** (`flag_assign_user`) extends the
[Flag](https://www.drupal.org/project/flag) module with a form that lets an
administrator apply a flag to a piece of content **on behalf of another user**.
Normally a flag records a relationship between *the current user* and an entity —
"I bookmarked this". Flag Assign User lets a trusted admin set that relationship
for *someone else's* account.

The classic example: a new employee joins, and you want the key resources —
employee manual, HR policies — to already appear as bookmarks when they first log
into the portal. Rather than logging in as them or using Masquerade, you use this
form to bookmark that content for their account. (The Tasks module uses it the
same way, assigning task flags to specific users.)

Because setting a flag for another user changes *their* flag state — which may in
turn drive subscriptions or notifications — this is a **privileged action**. The
module ships its own permission for it; grant that permission only to trusted
administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it (with the Flag module), and grant the permission.

There is **no central settings page**. Flag Assign User builds on flags you
create in the Flag module, and access is controlled entirely through its
permission — so there is no separate configuration chapter in this guide.

## Where it lives in the admin menu

Flag Assign User works alongside the Flag module. You create and manage the flags
themselves at **Structure → Flags** (`/admin/structure/flags`), and this module
adds the ability — gated by its permission — to assign one of those flags to
another user for a specific piece of content.

## How to use it

1. Make sure the flag you want to assign exists in the Flag module
   (**Structure → Flags**).
2. Grant the Flag Assign User permission to the administrator role that should be
   able to assign flags for others (see [Installation](installation/index.md)).
3. Use the assign form to pick the user (or users) and set the flag on the target
   content on their behalf. Keep in mind that this may trigger any
   subscription or notification behaviour tied to that flag.
