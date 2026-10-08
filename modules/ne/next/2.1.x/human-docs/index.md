# Next.js — manual setup guide

**Next.js** (`next`) connects a Drupal back end to one or more **Next.js** front-end
apps for a decoupled (headless) architecture. It gives you three things a headless
build needs: authenticated **preview / draft URLs** so editors can see unpublished
content, an in-Drupal **iframe live preview** of the decoupled site right on the
entity page, and **on-demand revalidation** (Incremental Static Regeneration, ISR) so
the front end rebuilds the affected pages when content changes.

You describe each front end to Drupal as a **Next.js site** entity — its base URL,
its preview and revalidate endpoints, and the shared secrets used to authenticate
those calls. You then map Drupal content (an entity type + bundle, e.g.
`node.article`) to one or more of those sites and choose how it revalidates. When an
entity is saved or deleted, the module notifies the matching site so it can rebuild;
when an editor opens an entity, its page is replaced with the configured preview.
Almost every part of the integration is pluggable — how the target site is resolved,
how the preview is rendered, how the secure preview URL is generated (OAuth or JWT),
and how revalidation is signalled (by path or by cache tag).

This is a developer-oriented module: the actual data (JSON:API or GraphQL) and the
Next.js app itself live outside Drupal. It depends on **Decoupled Router**,
**Simple OAuth**, **Subrequests** and **Pathauto**, and ships four submodules —
`next_jsonapi`, `next_graphql`, `next_jwt`, and `next_extras` — for the data layer,
JWT previews, and extras.

> **Secrets:** a Next.js site carries a *preview secret* and a *revalidate secret*.
> Treat these like passwords — do not hard-code them into exported configuration that
> lands in Git. Store each value in an environment variable and reference it, so the
> secret never enters version control. See [Configuration](configuration/index.md)
> for the recommended pattern.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the dependencies, install with Composer,
   enable the module and choose submodules.
2. [Configuration](configuration/index.md) — creating a Next.js site, mapping
   entity types, the global settings, preview and revalidation — and how to keep the
   secrets out of config.

## Where it lives in the admin menu

The configuration lives under **Configuration → Web services → Next.js**
(`/admin/config/services/next`). That collection page lists your Next.js **sites**;
the **Entity types** tab maps content to sites; and the **Settings** tab
(`/admin/config/services/next/settings`) holds the global previewer/generator
choices. Each site also has an **environment variables** page that prints the values
your Next.js app needs.
