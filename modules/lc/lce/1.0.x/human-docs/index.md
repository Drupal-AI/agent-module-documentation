# LCE (Link Content Entities) — manual setup guide

**LCE (Link Content Entities)** (`lce`) lets you give a content entity a custom,
unique **identifier** and then link to it by that identifier — so your links keep
working even when the entity's title or URL alias changes. Instead of hard-coding
a node ID or a path, you reference a stable name and let LCE resolve it to the
entity's canonical URL.

For example, you can give a node that shows an articles view the identifier
`articles_overview`, then build a URL pattern like
`[lce:path:articles_overview]/[node:title]`. Another common use is a "back to
overview" link on every article: point it at the overview entity's identifier, and
if that entity's title or alias later changes, the reference stays intact. LCE can
also generate a **theme suggestion** for a specific node based on its identifier,
and — combined with Config Ignore — the ID of the linked content entity can be
excluded from configuration exports. The module ships several **Twig functions**
and various **tokens** for using these references in templates and text.

Links resolve to entities that follow their own access rules on view, so LCE does
not grant access to anything — it simply provides stable references. It provides
its own permission and supports Drupal 10.4 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no central configuration page** of its own (`configure` is
null). You work with it by assigning identifiers to entities and referencing them
via tokens and Twig functions, described below. Its one setting in the admin UI is
a permission.

## Where it lives in the admin menu

There is no dedicated settings page. LCE adds the ability to give a content entity
a unique identifier (on the entity itself), and exposes tokens (the `lce:*` token
family, such as `[lce:path:...]`) and Twig functions you use in URL patterns,
templates, and text. Grant its permission under **People → Permissions** to the
roles that should be allowed to manage entity identifiers.

## How to use it

1. Enable the module and grant its permission to the appropriate roles.
2. Assign a **unique identifier** to a content entity (for example
   `articles_overview` on your articles landing page).
3. Reference that entity elsewhere by its identifier — for instance in a URL
   pattern (`[lce:path:articles_overview]/[node:title]`), a "back to overview"
   link, or a Twig template.
4. Because the reference is by identifier rather than by path or title, the link
   keeps resolving to the right entity even after its alias or title changes.
