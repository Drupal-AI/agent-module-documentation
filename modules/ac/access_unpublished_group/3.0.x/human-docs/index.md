# Access Unpublished Group — manual setup guide

**Access Unpublished Group** (`access_unpublished_group`) is a small bridge between
the [Access Unpublished](https://www.drupal.org/project/access_unpublished) module
and the [Group](https://www.drupal.org/project/group) module. It makes Access
Unpublished's time-limited preview tokens work for content that belongs to a
Group.

Access Unpublished lets an editor mint a temporary token URL that grants anonymous
view access to a single unpublished entity — handy for sharing a draft with a
reviewer who is not logged in. On its own, though, it does not understand Group's
relationship-based access system, so an unpublished node held inside a Group stays
hidden even with a valid token. This module closes that gap.

It works entirely through Drupal's service-decoration layer and adds **no settings
page, no config entities and no routes** of its own. It decorates Group's
access-control services so that, for a `view` request, it can *add* access — never
broaden it beyond what the token allows. The decorator runs Group's own access
check first; only when that check forbids does it look for a Group that relates the
entity through the matching plugin **and** grants the relevant permission to the
account, and even then it allows access only if the Access Unpublished **token
check also passes**. There is no way for it to open content the token itself does
not authorise, which keeps it safe.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Access Unpublished and Group.

## Where it lives in the admin menu

There is no dedicated settings page. All configuration is done as **Group
permissions**, per group type, at **Groups → Group types**
(`admin/group/types`) → *Edit permissions*.

## How to use it

Setup is permission-only. Once the module and its dependencies are enabled:

1. Go to **admin/group/types**.
2. For each group type whose content you want to be token-shareable, choose
   **Edit permissions**.
3. Grant the **Access unpublished &lt;relation label&gt;** permission (its machine
   id is `access_unpublished_group_<relation_plugin_id>`, e.g.
   `access_unpublished_group_group_node:article`) to the role that should be able
   to open token URLs — **usually the Anonymous user role**, since tokens are
   shared with people who are not logged in. These permissions are generated
   dynamically, one per installed group relation.
4. Save permissions.

Now a reviewer with a valid Access Unpublished token URL can preview an
unpublished, Group-held entity — including on the `/group/{group}/latest`
moderation route.

**How a view request is decided:**

1. Group's own access handler runs first. If it already allows, that stands.
2. Only if Group forbids does the module check whether a Group relates the entity
   through the matching plugin and grants the
   `access_unpublished_group_<plugin_id>` permission to the account.
3. If that permission is held, it runs the Access Unpublished **token check** and
   allows access **only** if the token also allows. Cache metadata from both
   results is merged in.

To **revoke** sharing for a relation, simply remove the group permission — token
access for that relation stops immediately. Because the module is pure service
decoration, re-validate it after any major Group module upgrade.
