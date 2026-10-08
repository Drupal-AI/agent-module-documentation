# miniOrange Custom API — manual setup guide

**miniOrange Custom API** (`miniorange_custom_api`) lets site administrators and
developers define and manage **custom REST API endpoints** that expose exactly the
data a frontend or integration needs — chosen fields, entities, or database data —
without writing custom backend code. It builds on Drupal's core REST framework and
routing system, so you create endpoints through the admin UI rather than in code.

Depending on your plan it can return GET responses (reading data) up to full CRUD
endpoints (GET/POST/PUT/DELETE) with filters and query parameters, role-based
access per endpoint, customisable response structures, and external-API
integrations. The free tier covers read-style endpoints; advanced SQL/CRUD,
per-endpoint role control and external integrations are premium features promoted
in the module's UI — a licensing consideration rather than a technical one. It
supports Drupal 10 and 11.

> **Security is on you, per endpoint.** Because these endpoints expose database
> data, the risk of over-exposure lives entirely in each endpoint's configuration.
> Configure every endpoint's access and authentication carefully, never expose
> sensitive data, and never leave an endpoint unauthenticated/anonymous unless the
> data is genuinely public.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create and secure your custom API
   endpoints.

## How to use it

Once enabled, you define endpoints through the module's admin pages, choose the
data each returns, and lock down who can call them. See
[Configuration](configuration/index.md) for the workflow and the security
essentials.
