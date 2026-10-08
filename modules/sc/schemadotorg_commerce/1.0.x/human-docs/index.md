# Schema.org Blueprints Commerce — manual setup guide

**Schema.org Blueprints Commerce** (`schemadotorg_commerce`) connects **Drupal
Commerce** with the **Schema.org Blueprints** system, so your Commerce products and
related entities can be mapped to Schema.org types — `Product`, `Offer`, and so on —
and emit rich structured data. The result is better SEO for e‑commerce content that
is modelled with Schema.org Blueprints: search engines can read the price,
availability, and other product details straight from your store.

Schema.org Blueprints is a framework for building content types and fields that are
mapped to Schema.org types from the start. This module is the piece that teaches
that framework about Commerce's entities, so a Commerce store built on Blueprints
produces valid product structured data without hand‑built markup. It is an
SEO/structured‑data integration with no content or access role of its own.

The module works as an integration layer once enabled — there is no settings form of
its own; the mapping is handled through the Schema.org Blueprints tooling. It
depends on both **Commerce** (`commerce`) and **Schema.org Blueprints**
(`schemadotorg`) and supports Drupal 10.3+ and 11.

> **Heads‑up:** this module is still under active development and its maintainers
> state that **backward compatibility is not yet guaranteed**. Use it with caution
> on production sites and read the release notes before upgrading.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Commerce and Schema.org Blueprints.

## How to use it

Enable the module on a site that already runs Drupal Commerce and Schema.org
Blueprints. Once on, it registers the Schema.org mappings for Commerce entities, so
the Blueprints mapping tools recognise products (and related types) and emit their
`Product` / `Offer` JSON‑LD. You then model and map your Commerce content through the
normal Schema.org Blueprints workflow.
