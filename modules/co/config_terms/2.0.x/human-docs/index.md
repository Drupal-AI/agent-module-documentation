# Config Terms — manual setup guide

**Config Terms** (`config_terms`) provides vocabularies and terms as
**configuration entities** instead of content. A config term has a title,
description, weight, parentage, and a vocabulary — just like a taxonomy term — but
because it is *configuration* rather than *content*, it is managed by Drupal's
configuration management system: it exports with `drush cex`, imports with `drush
cim`, is reviewable in a merge request, and has identical IDs on every environment.

The reason to want this is simple. Drupal's core taxonomy terms are content, which
is right when editors own them and wrong when developers do. A list of statuses,
regions, document types, or service categories that your *code* branches on is
configuration in everything but storage: it needs to be identical across
environments, reviewed before it changes, and deployed rather than re-entered by
hand. Because core terms are content, teams end up leaning on default-content
modules, migration stubs, or a hand-maintained list of term IDs that differ per
environment — a classic source of "it works on staging" bugs. Config Terms gives you
the config-entity equivalent: `config_terms_vocab` and `config_terms_term` entity
types with a full admin UI, plus an optional `config_terms_views` submodule for
listing them in Views.

The trade-off is the mirror image of the benefit, and it is the decisive point:
**config terms are not taxonomy terms.** They have no revisions, no content
translation, and — crucially — anything that expects a real `taxonomy_term` entity
will not work with them. That includes term reference fields, taxonomy Views, most
contrib term integrations, Pathauto term patterns, and so on. Reach for Config Terms
when you want a controlled, deployable list that code consumes, not when you want the
taxonomy ecosystem. This is the 2.0.x branch for core 10.6 or 11, and it is
minimally maintained.

Access is governed by an `administer config terms` permission plus **per-vocabulary
permissions generated at runtime**, and creating a term is checked against the
specific vocabulary rather than a single flat permission — a correctly scoped model
you should review when assigning roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and add the Views submodule if you need it.

The module has **no global settings form** — you manage vocabularies and terms
directly from its admin UI, so there is no configuration page. See "How to use it"
below.

## Where it lives in the admin menu

Config Terms adds an admin section at **Structure → Config terms**
(`/admin/structure/config-terms`), where you create and manage your config
vocabularies and their terms.

## How to use it

1. Enable the module (and `config_terms_views` if you want to list terms in Views).
2. Go to **Structure → Config terms** (`/admin/structure/config-terms`) and create a
   vocabulary — for example "Regions" or "Document types".
3. Add terms to that vocabulary, setting title, description, weight, and parent as
   needed.
4. Export your configuration (`drush cex`) and commit it. The vocabulary and its
   terms now travel with your config, deploy with `drush cim`, and carry identical
   IDs on every environment.
5. Assign the `administer config terms` permission and the relevant per-vocabulary
   permissions to the roles that should manage each list.
