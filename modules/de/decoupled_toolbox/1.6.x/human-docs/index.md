# Decoupled Toolbox — manual setup guide

**Decoupled Toolbox** (`decoupled_toolbox`) bundles common features for
**decoupled (headless) Drupal** sites — or, really, any situation where you want
to serve Drupal content as a structured JSON feed. Its central idea is clever: it
uses Drupal's **Field UI and display view modes** to decide what gets exposed. What
you configure on an entity's *Manage display* page — which fields appear, in what
order, rendered by which formatters — becomes the shape of the JSON endpoint. So a
site builder can expose exactly the data an external rendering service needs, on a
dedicated path, **without writing code** and without the steeper learning curve of
building custom REST resources or GraphQL schemas by hand.

An important scope note from the module's own documentation: Decoupled Toolbox
helps when all you need is to **pull content out of Drupal**. There is no mechanism
to push content back into Drupal — for that you would use other modules.

The toolbox ships several optional **submodules** and integrates out of the box
with a range of contrib modules (Group, Group Content Menu, Redirect, Color Field,
Duration Field, Weight, and Open API for documentation/visualization). You often
also want the **Field Display Override** module so you can expose values — title,
ID, created date, and so on — that do not normally appear on the Manage display
page. It provides its own permissions and lives in the **Decoupled** package.

Because this is about delivery, the security consideration is the **API surface**.
Decoupled delivery exposes content over the API, and JSON:API/REST enforce **entity
and field access** — so the standard rule applies: restrict the fields and
resources you expose to what should genuinely be public, keep any write endpoints
permission‑gated, and review what your front end is actually allowed to read. The
module has no access‑control role of its own beyond the permissions it provides.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   pick the submodules and companions you need.

This module has **no central settings form**. You configure what it exposes on each
entity's **Manage display** page and by enabling submodules — so there is no
separate Configuration section in this guide. See "How to use it" below.

## Where it lives in the admin menu

Decoupled Toolbox adds no dedicated settings page. You use it entirely from
**Structure → (content type / entity) → Manage display**, where you shape the JSON
output field by field. Manage submodules from **Extend** (`/admin/modules`), and
access to any exposed data is governed by Drupal's normal entity/field access plus
this module's permissions on **People → Permissions**.

## How to use it

1. Build your entities and their relationships (nodes, terms, paragraphs, custom
   entities) as usual in the Drupal back office.
2. On an entity's **Manage display** for a chosen view mode, arrange the fields you
   want to expose and pick their formatters — this defines the JSON output.
3. If you need to expose values that are not normally on Manage display (title, ID,
   created date, etc.), install and use **Field Display Override**.
4. Enable the submodules for the extra capabilities you need (see Installation), and
   consume the resulting JSON on your configured path from your front end or
   external rendering service. Optionally add **Open API** to visualize the
   endpoints.
