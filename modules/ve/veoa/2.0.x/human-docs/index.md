# Views Entity Operation Access — manual setup guide

**Views Entity Operation Access** (`veoa`) adds a Views access‑control option that
grants access to a view page only if the current user is allowed to perform a
chosen operation — such as **view**, **update**, or **delete** — on an entity
taken from the view's path. In other words, a view built under a path like
`node/%node/related` can inherit the *exact* access rules of that node, rather
than relying on a flat permission or role check.

It works by providing one Views access plugin called **Entity Operation**. On a
view's page display you set its access to "Entity Operation" and tell it three
things: which path argument holds the entity, what entity type that is, and which
operation to check. When you save the view, the plugin wires a core route
requirement (`_entity_access`) onto the view's path and up‑casts the path
argument into a full entity. From then on Drupal's own routing and access system
enforces the check on every request — honouring the entity's access handlers and
any `hook_entity_access` logic.

This is a **strengthening** access plugin: it only adds a constraint, it never
grants extra permissions or loosens core's access. It has no settings page, no
permissions of its own, and no Drush commands — all configuration lives inside a
view.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choosing the "Entity Operation"
   access plugin on a view and setting its three options.

## Where it lives in the admin menu

There is no page of its own. You use it inside the Views UI (**Structure →
Views**) when editing a view page display's **Access** setting.
