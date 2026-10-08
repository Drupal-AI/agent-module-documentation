# Forum Access — manual setup guide

**Forum Access** (`forum_access`) turns Drupal's forum from an all‑or‑nothing
public space into one where different groups see different boards. It lets you make
individual forums **private** — controlling which user roles can view, edit,
delete, and post in each forum — and it lets you give each forum its own list of
**moderators** who have administrative access to that forum only.

Core's forum module has no per‑forum access model: if you can see forums, you can
see all of them. Forum Access adds that missing layer. It's built on top of the
**ACL** module rather than its own grants implementation — ACL provides the
per‑user, per‑node access‑list primitive, and Forum Access maps forum containers
onto it. That has a practical consequence worth remembering: access follows
Drupal's normal "grants are OR" semantics, so **another node‑access module that
grants access can override a Forum Access restriction**. When access behaves
unexpectedly, ACL's tables are usually where the answer is.

Two release facts matter before you install. First, Forum Access already declares
support for **Drupal 10.3, 11, and 12** — unusual for a node‑access module.
Second, because the forum feature **left core after Drupal 10**, on **Drupal 11 and
newer you must install the contributed `drupal/forum` project separately** — a
`drush en forum_access` will fail without it. Forum Access also requires PHP 8.1+
and the ACL module (`^2.0`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its ACL (and, on
   D11+, Forum) dependencies with Composer, and enable it.
2. [Configuration](configuration/index.md) — set per‑forum access and moderators
   from the forum overview screen.

## Where it lives in the admin menu

Forum Access does not add a separate settings section — it folds into the existing
**forum overview** at **Structure → Forums** (`configure: forum.overview`,
`/admin/structure/forum`). You set each forum's access there. See
[Configuration](configuration/index.md).
