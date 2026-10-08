# Override Node Options — manual setup guide

**Override Node Options** (`override_node_options`) adds fine-grained
permissions so you can let non-admin users edit specific node settings —
**authoring information** (author, date), **publishing options**
(published, promoted, sticky), and **revision information** — **without**
granting the all-powerful **Administer content** / *administer nodes*
permission.

By default Drupal hides the *Authoring information* and *Publishing options*
sections of the node add/edit form from anyone who lacks *administer nodes* —
an all-or-nothing switch that is far too broad to hand to ordinary editors.
Override Node Options breaks those sections apart into individual,
permission-gated controls. Grant a role just the *published* checkbox for
Articles, or the *authored on* date everywhere, and nothing more. The module
never changes **which** nodes a user can edit; it only reveals options on
forms they already have edit access to.

This guide is written for a **human** clicking through the admin UI. It walks
you, step by step, from installing the module to granting the right
permissions so those controls appear on the node form. If you are looking for
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Override Node Options settings page](images/settings.png)

## Where it lives in the admin menu

The module's own settings page sits under **Configuration → Content authoring
→ Override Node Options** (`/admin/config/content/override-node-options`).
That page holds only a couple of module-level options — the real control is
handed out as **permissions** at **People → Permissions**
(`/admin/people/permissions`), which is where you spend most of your time when
configuring this module.

## Contents

1. [Installation](installation/index.md) — install Override Node Options with
   Composer and enable it.
2. [Configuration](configuration/index.md) — grant the per-content-type
   override permissions to the roles that need them, and set the module's two
   options.
