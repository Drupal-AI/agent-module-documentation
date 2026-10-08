# Decoupled Kit — manual setup guide

**Decoupled Kit** (`decoupled_kit`) is a set of tools for solving the recurring
tasks you hit when running Drupal **headless (decoupled)** — content managed in
Drupal, front end built elsewhere in React, Vue, Next.js, and the like. Instead of
hand‑rolling a custom resource for each of those needs, Decoupled Kit exposes them
as JSON endpoints your front end can call. It builds on core JSON:API (it depends
on the **JSON:API Resources** module) and its own Decoupled Kit Router.

The 2.x branch focuses on two core capabilities, delivered through submodules: an
**Object** endpoint that resolves the entity link for the current page (via
JSON:API and/or the Decoupled Kit Router), and a **Block** endpoint that returns
the blocks for the current page — respecting each block's region, visibility, and
weight — given the current theme and the regions you select. The 1.x branch offered
a wider menu of integrations (Menu, Taxonomy, Sitemap, Breadcrumb, Metatag,
Webform, Open API); in 2.x, Breadcrumb is folded into the Block endpoint. Each
submodule adds routes that return JSON, driven by simple query parameters such as
`?path`, `?mode`, or an id.

Because this is headless plumbing, the security consideration is the **API
surface**, not the module itself. Any content you expose to the front end — through
JSON:API, REST, GraphQL, or these endpoints — must still enforce entity and field
access, and any redirects handled across the Drupal↔front‑end boundary must not
become open redirects. Decoupled Kit helps you assemble the plumbing; you remain
responsible for confirming that the exposed data respects access and that redirect
targets are controlled. Note that as of this branch the project is *minimally
maintained* (maintenance fixes only).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (and JSON:API
   Resources), enable it, and pick the submodules you need.

This module has **no central settings form**. You choose behaviour by enabling the
submodules you need and by calling their JSON endpoints with query parameters — so
there is no separate Configuration section in this guide.

## Where it lives in the admin menu

Decoupled Kit adds no configuration page of its own. It works through the JSON
endpoints its submodules register, which your front end calls directly. Enable or
disable the submodules from **Extend** (`/admin/modules`). A worked example project
(a Next.js blog) is referenced in the project's documentation.
