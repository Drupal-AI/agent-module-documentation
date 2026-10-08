# Configuration Read-only Taxonomy UI — manual setup guide

**Configuration Read-only Taxonomy UI** (`config_readonly_taxonomy_ui`) restores the ability
to **reorder taxonomy terms** on the term‑overview page while the
[Config Read-only](https://www.drupal.org/project/config_readonly) module has the site in
read‑only configuration mode.

Config Read-only makes production configuration immutable — configuration forms refuse to
save, so configuration only changes through a deployment. From Drupal 11.3 onward, the
taxonomy term‑overview (reordering) form was reworked to extend `EntityForm`, which had the
side effect that Config Read-only now blocks term reordering along with everything else.
Reordering terms is really a content‑adjacent, editorial operation that ought to stay
available even when configuration editing is locked, and this module re‑enables exactly that.

It does so **narrowly**: it whitelists the `taxonomy.vocabulary.*` configuration pattern so
the reorder form works again, while still preventing genuine configuration changes — editing
the vocabulary settings is kept disabled by disabling the form, and deletion is blocked
through access control. It depends on **Config Read-only** and core **Taxonomy**, adds no
settings form or permission of its own, and requires Drupal **11.1+**. The current release is
an **alpha (1.0.0‑alpha1)**.

As with any exception to a configuration lock, weigh it against your governance policy: it
re‑opens one specific operation (reordering terms) on a site you otherwise chose to lock down.
That is usually a reasonable trade — editors keep control of term order without loosening the
rest of the lock — but it is a decision worth making consciously.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it (Config
   Read-only first).

There is **no configuration page** for this module — it has no settings form. It changes how
the taxonomy term‑overview page behaves the moment it is enabled.

## How to use it

There is nothing to configure. With Config Read-only active and this module enabled, go to
**Structure → Taxonomy → *(a vocabulary)*** and you will be able to reorder its terms on the
overview page again, while editing the vocabulary's configuration and deleting it remain
blocked by the read‑only lock.
