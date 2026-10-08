# OpenAPI — manual setup guide

**OpenAPI** (`openapi`) generates a machine-readable OpenAPI (Swagger 2.0)
specification that describes your Drupal site's web-service API. That spec is a
standard contract other tools understand: you can feed it to Swagger Editor, Swagger
Codegen / OpenAPI Generator, Postman, Insomnia, mock servers, and any OpenAPI-aware
client generator. It is especially useful for decoupled sites, where a frontend or
mobile team needs a clear, downloadable description of the backend they are building
against.

An important thing to understand up front: OpenAPI is a **framework**, not a
finished feature. On its own it knows how to assemble a spec but has nothing to
describe, because it ships **no generators**. To document real endpoints you install
one or both of the companion projects — **OpenAPI REST** (for core REST) and
**OpenAPI JSON:API** (for JSON:API). Each one adds a "generator" that OpenAPI turns
into a downloadable spec.

Once a generator is present, its spec is available as JSON at `/openapi/{generator}`
(for example `/openapi/rest` or `/openapi/jsonapi`), and an admin landing page lists
every available generator with View and Download links. To browse the docs
interactively in your site (with Redoc or Swagger UI) you additionally install the
separate **OpenAPI UI** project. The generated spec even documents your site's
available authentication schemes automatically, based on which auth providers are
enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add a generator so there is something to document.

## Where it lives in the admin menu

There is **no settings form** to fill in. The module's landing page — "OpenAPI
Resources" — sits at **Configuration → Web services → OpenAPI**
(`/admin/config/services/openapi`). It lists the generators you have installed; with
none installed yet, it shows a warning prompting you to enable OpenAPI REST or
OpenAPI JSON:API. Viewing or downloading any spec requires the **Access API Docs**
(`access openapi api docs`) permission — grant it only to trusted roles, since the
spec reveals your API's structure and supported authentication schemes.

## How to use it

1. Enable `openapi`, then enable at least one generator module (OpenAPI REST and/or
   OpenAPI JSON:API).
2. Grant **Access API Docs** to the roles that should see the documentation.
3. Open **Configuration → Web services → OpenAPI** and use the View/Download links,
   or fetch the JSON directly at `/openapi/rest` or `/openapi/jsonapi`.
4. Optionally narrow a spec with query options — for example
   `/openapi/jsonapi?_format=json&options[entity_mode]=content_entities` limits it
   to content entities, and `options[exclude][]` omits specific entity types or
   bundles.
5. To read the docs in a friendly interactive UI, install the separate **OpenAPI
   UI** project, which adds a rendered documentation page.
