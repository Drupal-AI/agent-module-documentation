# Group finder — manual setup guide

**Group finder** (`group_finder`) is a small helper for the
[Group](https://www.drupal.org/project/group) module that answers one recurring
question in group-aware code: *"which group are we in right now?"* It provides a
pluggable API for locating the relevant group in different situations — for
example the group a piece of content belongs to, the group named in the current
route, or the group being created on a "create group" page.

Out of the box it ships several finder plugins — *group by content*, *group by
route*, *group from the URL query* (`?group=x`), and a *create group* scenario —
and it lets developers change the order in which finders run or add their own.
Crucially, Group finder only *locates* groups; it never grants or checks access
on its own. Whether a user may actually see or act on a group is still decided by
the Group module's membership and permission system.

Because of that, Group finder is really a developer building block rather than a
feature you configure through the admin UI. You will most often encounter it as a
dependency of other modules — the Group Media Library module uses it, for
instance — rather than installing it directly. It has no settings form and adds
no admin pages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it exposes a developer API
rather than a settings form.

## Where it lives in the admin menu

Group finder adds **no admin page and no permissions of its own**. It extends the
Group module quietly in the background, providing the group-resolution service
that group-aware code (and other contrib modules) can call.

## How to use it

For most sites there is nothing to do beyond enabling it as a dependency. For
developers, the module exposes a service that returns the resolved group in the
current context:

```php
/** @var \Drupal\group_finder\GroupFinderInterface $group_finder */
$group_finder = \Drupal::service('group_finder.provider')->get();
$group = $group_finder?->getGroup();
```

You can register additional finder plugins, or adjust the weight of the built-in
ones (a higher weight runs later), to control how the "current group" is resolved
in your own features.
