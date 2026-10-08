# Configuration

Configuring this module is a deliberate, two-part job: first you choose *which*
kinds of permission control to switch on, then you grant the resulting
permissions to the right roles. Because the control is fail-closed, doing these in
the wrong order can lock roles out of your API — so read this page fully before
changing anything on a live site.

## Step 1 — Choose which permissions to enable

1. Go to **Administration → Web services → JSON:API Advanced Permissions**.
2. You'll see options for enabling per-method, per-collection permission control
   (covering the read/create/update/delete operations — GET, POST, PATCH,
   DELETE). Enable the permission type(s) you want to enforce.
3. Save.

> **Important:** the instant you enable a permission type, **every JSON:API
> endpoint of that type begins requiring the newly generated permission.** Until
> you grant that permission (Step 2), only the administrator role can reach those
> endpoints. This is intentional — the module fails closed rather than leaving a
> gap — but it means an API consumer's access can disappear the moment you save,
> unless its role already has the grant.

## Step 2 — Grant the generated permissions to roles

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the new permissions under the **JSON:API Advanced Permissions** section.
   You'll see entries for the enabled resource collections and methods.
3. Tick the permissions for each role that should have that level of access —
   granting read to one role, writes to another, and so on — then **Save
   permissions**.

You don't need to create or change any content types; the module only adds
permissions for controlling API access.

## How it fits with Drupal's other access control

This module is an **additional** gate in front of the JSON:API routes — it does
**not** replace Drupal's entity and field access. When a request comes in, it must
now pass both:

1. the collection/method permission you configured here, **and**
2. Drupal's normal entity/field access that JSON:API already enforces.

So keep your underlying entity permissions correct too. Widening what the API
exposes — by granting a write permission to a broad role, say — is a security
decision; make it deliberately, and test each role's access after changing the
settings.
