# Entity REST Extra — manual setup guide

**Entity REST Extra** (`entity_rest_extra`) adds a handful of REST resources that
expose your site's **entity configuration** — the shape of the content model — so a
decoupled or headless front end can discover it over REST. Rather than serving
content, these resources answer structural questions: which bundles exist for an
entity type, which fields a bundle has, and which view modes a bundle supports.

The three resources are:

- **Bundles** — `GET /entity/{entity_type}/bundles` — lists a type's bundles with
  their labels, descriptions and translatable flags.
- **View modes** — `GET /entity/{entity_type}/{bundle}/view_modes` — lists the view
  modes available for a bundle.
- **Fields** — `GET /entity/{entity_type}/{bundle}/fields` — lists a bundle's
  fields with their configuration.

This is useful when a JavaScript or mobile client needs to introspect the content
model instead of having it hard‑coded — the idea was originally proposed as a
Drupal core patch for headless use. It depends on core's **Serialization** module
and the contributed **REST UI** (`restui`) module, which is how you turn the
resources on.

Because these resources reveal internal structure (every bundle, field and view
mode), treat them as a mild **information‑disclosure / reconnaissance** surface.
They are gated by Drupal's REST permissions — you must enable each resource and
grant the matching `restful get …` permission — so **grant them carefully** and
prefer requiring authentication rather than exposing the content model to
anonymous clients.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and REST UI).

This module has no settings form of its own — the resources are enabled and
secured through the **REST UI** admin screen, described in "How to use it" below.

## Where it lives in the admin menu

The resources are managed through REST UI at **Configuration → Web services →
REST** (`/admin/config/services/rest`), and their permissions under **People →
Permissions**.

## How to use it

1. Enable **REST UI** and go to **Configuration → Web services → REST**.
2. Find the resources added by Entity REST Extra and **enable** the ones you need.
   For each, choose the HTTP method (GET), the **authentication** provider
   (require an authenticated provider rather than allowing anonymous access), and a
   serialization format — **JSON** is recommended.
3. Under **People → Permissions**, grant the corresponding `restful get …`
   permission only to the roles that should be allowed to read the content model.
4. Call the endpoints from your client, for example
   `GET /entity/node/bundles` or `GET /entity/node/article/fields`.

Because the responses disclose your site's structure, keep these endpoints
authenticated and grant their permissions narrowly.
