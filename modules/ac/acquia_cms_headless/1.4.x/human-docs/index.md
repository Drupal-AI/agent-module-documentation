# Acquia CMS Headless — manual setup guide

**Acquia CMS Headless** (`acquia_cms_headless`) turns a Drupal / Acquia CMS site
into a **headless or progressively decoupled** backend for JavaScript front ends,
primarily **Next.js**. Rather than inventing new APIs, it composes and
pre-configures an established decoupled stack so you don't have to wire it up by
hand.

Under the hood it bundles and configures: **JSON:API** (with JSON:API Extras and
JSON:API Menu Items) for reading content, the **Next.js** integration modules
(`next`, `next_jsonapi`), **Consumers** and **Simple OAuth** for authenticated
API access, and **OpenAPI UI** (ReDoc and Swagger) for browsable API
documentation. An optional submodule, **Acquia CMS Headless UI**
(`acquia_cms_headless_ui`), adds an admin dashboard for managing headless
settings, consumers, and tokens.

Because it enables authenticated web-service access, the security posture that
matters most is the **Simple OAuth configuration** — key material, token
lifetimes, and which consumers and scopes are allowed — together with which
entities you expose through JSON:API. It provides its own permissions and Drush
commands for headless setup tasks. It carries a broad dependency set and expects
the Acquia CMS ecosystem to be present.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module (and its stack), and choose whether to add the Headless UI dashboard.
2. [Configuration](configuration/index.md) — set up OAuth keys, register
   consumers, and control what JSON:API exposes.

## Where it lives in the admin menu

Once enabled, the pieces it configures appear across a few admin areas:

- The **Headless dashboard** (added by the `acquia_cms_headless_ui` submodule) —
  a central place to manage headless settings, consumers, and tokens.
- **Configuration → Web services → Simple OAuth** — OAuth keys, tokens, and
  scopes.
- **Configuration → Web services → Consumers** — the registered API consumers.
- **Configuration → Web services → JSON:API Extras** — how JSON:API output is
  shaped.
- The **OpenAPI** documentation UI (ReDoc / Swagger) for browsing the API.

## How to use it

At a high level: enable the module, generate OAuth keys and register a consumer
for your front end, decide which entities JSON:API exposes, then point your
Next.js (or other) application at the JSON:API endpoints using OAuth-secured
requests. The provided Drush commands automate parts of this setup. See
[Configuration](configuration/index.md) for the details.
