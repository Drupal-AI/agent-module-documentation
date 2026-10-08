# Content Lock — manual setup guide

**Content Lock** (`content_lock`) stops two people from editing the same content
at once. It uses a *pessimistic locking* strategy: the moment one editor opens a
piece of content's edit form, Content Lock locks that content so nobody else can
save changes to it until the first editor is done. This prevents the frustrating
"the content has been modified by another user" conflict that otherwise loses
someone's work on busy editorial teams.

When an editor opens a locked entity's edit form, they get a normal form plus an
**Unlock** button. If a *different* user opens the same form while it is locked,
the whole form is disabled and they see a message naming who currently holds the
lock. The lock is released automatically when the owner saves the form, and
trusted users can be given permission to forcibly break someone else's forgotten
lock.

You choose exactly which entity types and bundles are lockable, and can go
further: lock at the translation level so different people can edit different
translations simultaneously (with the Conflict module), or limit locking to
specific form operations. A configurable timeout marks abandoned locks as stale.
Content Lock needs nothing beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose whether you need the timeout submodule.
2. [Configuration](configuration/index.md) — choose which content is lockable and
   tune the locking behavior, option by option.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Content lock**
(`/admin/config/content/content_lock`), gated by the **Administer content lock**
permission.

## How to use it

1. Enable the module and open the settings form.
2. Turn on locking for the entity types (and, if you like, the specific bundles)
   you want protected — for example only the Article and Basic page content
   types.
3. Save. From then on, opening an enabled entity's edit form locks it for that
   editor; anyone else who opens it sees a disabled, read‑only form until it is
   released.
4. Optionally grant trusted staff the **Break content lock** permission so they
   can release a colleague's abandoned lock.

See [Configuration](configuration/index.md) for the full set of options.
