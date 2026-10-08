# Preview Site — manual setup guide

**Preview Site** (`preview_site`) lets content editors build a **shareable static
snapshot** of selected content and deploy it somewhere stakeholders can review it —
without giving those reviewers a login and without touching production. Where core's
Preview link idea covers a single item, Preview Site extends the concept to *many*
pieces of content at once, generated as a small standalone static site.

Each editor can create unlimited **preview sites**, and each one bundles one or
more pieces of draft content they want to share before publishing. When they hit
**Build and Deploy**, the module generates the static artefacts and pushes them to
a configured destination. It even makes a best effort to include drafts of *related*
content shown on the same page — blocks, paragraphs, and so on — by integrating with
Entity Usage to find those relationships.

The two halves of that process are **pluggable**:

- A **generation strategy** builds the static artefacts. The module ships a
  **Tome Static**–based generator by default.
- A **deployment strategy** sends the artefacts to their destination. The bundled
  **Preview Site S3** submodule (`preview_site_s3`) deploys to Amazon S3. If you
  don't use S3, you'll need a module (currently meaning custom code) that provides a
  deployment plugin.

> **Security matters here.** A preview contains **unpublished / draft content**, so
> the **destination must be protected** — a public S3 bucket would expose your
> drafts to anyone with the URL. And the deploy target's **credentials** (S3 keys,
> etc.) are secrets: store them in an environment variable or a Key entity, never
> hard‑coded in config that gets committed. The module also provides its own
> **permissions** to control who may generate previews.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Tome / Entity
   Usage / Dynamic Entity Reference dependencies, and enable it (plus the optional
   S3 submodule).
2. [Configuration](configuration/index.md) — create a preview‑site strategy
   (generator + deployment), build a preview, and secure the destination.

## Where it lives in the admin menu

Preview Site's screens live under **Structure → Preview site**:

- **Strategies** — `/admin/structure/preview-site/strategies`
- **Builds** — `/admin/structure/preview-site/builds`
