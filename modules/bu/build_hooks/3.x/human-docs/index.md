# Build Hooks — manual setup guide

**Build Hooks** (`build_hooks`) lets editors trigger a rebuild — a "build hook" —
of one or more externally hosted front ends from inside Drupal. It is for
**decoupled / static‑site** setups where Drupal is the content source and the
actual website is built by a static‑site generator or CI/CD host (Gatsby, Next,
Netlify, and so on). Instead of sharing a raw deploy webhook URL around, you give
editors a one‑click **Deploy** button in the admin toolbar.

You model each place you deploy to as a **frontend environment** — a deploy
target such as *production*, *staging*, or *preview*. Each environment names a
**plugin** that knows how to talk to a host (the base module ships a `generic`
plugin that simply POSTs to a build‑hook URL you paste in; provider submodules
add plugins for Bitbucket, CircleCI, GitHub, and Netlify), and a **deployment
strategy** that decides *when* it fires:

- **Manual** — only when someone presses the deploy button.
- **Cron** — automatically on each cron run (for example, nightly rebuilds).
- **On entity save** — immediately whenever tracked content is created, updated,
  or deleted (near‑real‑time sites).

Build Hooks also tracks **what changed since the last deploy**. You choose which
entity types are "loggable"; whenever one changes, a per‑environment changelog
records it and the toolbar shows a change counter. When an editor opens the
deploy form they see exactly which content will go out, then press deploy — which
fires the outbound request to your host.

> **A note on secrets.** A build‑hook URL (and some provider tokens) are
> effectively credentials — anyone who has the URL can trigger a deploy. They are
> stored in Drupal configuration. Treat these values as secret: keep them out of
> public config exports where you can, and gate the module's permissions tightly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the Trigger service, the
`FrontendEnvironment` plugin type, and the events — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick a provider submodule.
2. [Configuration](configuration/index.md) — choose loggable content, create
   frontend environments, set deployment strategies, and run a deploy.

## Where it lives in the admin menu

- **Configuration → Build hooks → Settings** (`/admin/config/build_hooks/settings`)
  — choose which entity types are tracked.
- **Configuration → Build hooks → Frontend environments**
  (`/admin/config/build_hooks/frontend_environment`) — add and edit deploy
  targets.
- The **admin toolbar** shows a deploy item per environment; clicking it opens the
  deployment form at `/admin/build_hooks/deployments/{environment}`.

## How to use it

1. Install and enable the module (and a provider submodule if you use one).
2. On the settings form, choose which entity types should be tracked (node by
   default).
3. Create a frontend environment, choose its plugin, paste in the build‑hook URL
   / credentials, and pick a deployment strategy.
4. Editors work as normal; when it is time to publish, they open the deploy form,
   review the changelog, and press deploy.
