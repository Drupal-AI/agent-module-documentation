# ACL — manual setup guide

**ACL** (`acl`) is an **access control list API for developers**. Its own project
description says it plainly: *"Access control list API. Has no features on its
own."* On its own it shows you nothing and does nothing — it exists so that *other*
modules can build per-user access control lists and grant those users view,
update, or delete access to individual nodes.

There is **no user interface, no settings page, no permissions, and no Drush
commands**. Instead, ACL provides a set of procedural `acl_*` functions and
implements Drupal's node-access hooks, backed by three database tables. A client
module creates a list (`acl_create_acl()`), adds users to it (`acl_add_user()`),
and attaches the list to one or more nodes with view/update/delete flags
(`acl_node_add_acl()`). At runtime ACL registers a node-access **realm** called
`acl` and emits the appropriate grants for the users on each list. It also cleans
up after itself — a node's ACL rows are removed when the node is deleted, and a
user's memberships are removed when the account is cancelled.

Because Drupal treats ACL as a node-access module, **enabling it forces a
node-access permissions rebuild**. That's expected and normal.

You would typically install ACL not because you want it directly, but because
another module you're using depends on it as a shared backend (several access
modules can interoperate through it). If you're a site builder, you likely won't
touch ACL directly at all — you'll configure the module that builds on top of it.
If you're a developer, ACL gives you a ready-made way to implement document-level,
per-user permissions (for example "only assigned reviewers can edit this article")
without reinventing node grants.

This guide is written for a **human**. Because ACL is an API with no UI, the
practical detail lives in the sibling [`agent/`](../agent/start.md) docs — the
`acl_*` functions, the three tables, and the hooks your client module must
implement.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — ACL has no admin pages, no settings form, and no permissions of its own.
Everything it does is driven by other modules' code.

## How to use it

For **site builders:** there's nothing to configure. Install and enable ACL only
when another module requires it; that other module provides the actual interface.

For **developers:** the typical flow is:

```php
$acl_id = acl_create_acl('mymodule', 'editors');   // create a named list
acl_add_user($acl_id, $uid);                        // add a user
acl_node_add_acl($nid, $acl_id, 1, 1, 0, 0);        // grant view+update on a node
```

Two things to remember, because they trip people up:

- Your client module **must** implement `hook_enabled()` returning `TRUE`, or ACL
  will suppress your grants entirely.
- A list that exists but has **no users** produces a *deny* grant, not open access.

See the [`agent/`](../agent/start.md) docs for the full function reference, the
optional `hook_acl_explain()` for the node-access debug screen, and the bundled
Drupal 6/7 migrate plugins for upgrading legacy ACL data.
