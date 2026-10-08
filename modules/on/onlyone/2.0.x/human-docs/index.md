# Allow a content type only once (Only One) — manual setup guide

**Allow a content type only once (Only One)** (`onlyone`) lets you mark certain
content types as "there can be only one." Once a node of a restricted type
exists, Drupal stops editors from creating a second one — when they click *Add
content* for that type, they are sent to edit the existing node instead. This is
perfect for singleton content: a single Homepage node, one Site settings page,
one Privacy policy, one About us page, and so on.

The restriction is **per language**, so on a multilingual site each language may
still have its own single copy of that content type. Enforcement works through a
validation constraint the module attaches to the node entity, so the "only one"
rule applies to everyone regardless of permission — if someone tries to save a
second node of a restricted type in the same language, they get a validation
error. A single permission, *Administer onlyone*, controls who can change which
types are restricted.

The module depends on **Admin Toolbar** (`^3`) and works on Drupal 10 and 11. It
ships one optional submodule, **Only One Admin Toolbar**
(`onlyone_admin_toolbar`), which keeps the Admin Toolbar Tools *Add content* menu
in sync with your restricted types (labelling configured types so editors see
they lead to an edit). Note that the module's bundled Drush commands use a legacy
Drush 8/9 API and do **not** run on modern Drush — configure everything through
the UI instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the optional Admin Toolbar submodule.
2. [Configuration](configuration/index.md) — pick which content types are
   restricted, and the two behavior options.

## Where it lives in the admin menu

You choose the restricted content types at **Configuration → Content authoring →
Only One** (`/admin/config/content/onlyone`), and the two behavior options sit at
`/admin/config/content/onlyone/settings`. Both are gated by the *Administer
onlyone* permission.

## How to use it

Enable the module, go to the Only One page, tick the content types that should
allow only a single node, and save. From then on, adding a second node of a
restricted type redirects the editor to the existing one. Adjust the two options
(a separate "Add content (Only One)" menu entry, and whether the redirect goes to
the edit form or the published page) on the settings page. See
[Configuration](configuration/index.md) for details.
