# Entity Dependency Visualizer — manual setup guide

**Entity Dependency Visualizer** (`entity_dependency_visualizer`) draws an
interactive graph of how your entities depend on one another. Complex sites
accumulate tangled relationships — nodes referencing terms, terms referencing other
terms, paragraphs nested inside content — and this module turns that web into a
picture you can actually read. It's aimed at developers and site administrators who
need to understand a content structure before editing or deleting something, or who
are trying to track down a **circular dependency**.

The graph is rendered with the help of **Graphviz** and lets you **zoom, pan, and
search** for a string within it. To keep large sites responsive, the initial graph
is capped at a nesting depth of 100 items; you can then click any node in the chart
to **drill down** into that item's own dependencies. You can also export the
graph's source so you can analyze it offline or refine it on the Graphviz website.
It works with a wide range of entities — nodes, taxonomy terms, users, field
collections, and paragraphs — across Drupal 8 through 11, and integrates with Acquia
Content Hub.

You reach the visualization from an entity's page: on Drupal 8 and above a
**"Content dependencies"** tab appears in the entity's local tasks (the row of tabs
when viewing content). One thing to know up front: you must **enable Dependency
Calculation manually** for the feature to work, and the module also has a
configuration page where you can customize how the graphs look. It provides its own
permission and has no third‑party Composer dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable Dependency Calculation and
   customize graph appearance.

## Where it lives in the admin menu

There's no top‑level menu item. Once enabled (and after Dependency Calculation is
turned on), open any entity and look for the **"Content dependencies"** tab in its
local tasks to view that entity's dependency graph. The module also provides a
configuration page for graph appearance — see
[Configuration](configuration/index.md).

## How to use it

1. View an entity (a node, term, user, and so on).
2. Click the **"Content dependencies"** tab in the local tasks menu.
3. Explore the chart — zoom, pan, and search within the graph for an overview of
   the entity's dependencies.
4. Click any item in the chart to drill down into its specific dependencies for a
   more detailed view.
5. If needed, export the graph's source code for offline analysis or to refine it
   on the Graphviz website.

> **Upgrading?** If you hit errors after updating to newer code, uninstall the
> module first and reinstall it after downloading the latest version.
