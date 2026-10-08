# Content Workflow (by Bynder) — manual setup guide

**Content Workflow (by Bynder)** (`content_workflow_bynder`) imports content from
the **Content Workflow** platform — Bynder's collaborative content‑production
tool, formerly known as **GatherContent** — into your Drupal site. Editorial
teams draft and structure content in Content Workflow; this module pulls that
structured content into Drupal, mapping it to **nodes, taxonomy terms, media, and
menu links** through Drupal's **Migrate** framework. You can import items as any
node content type, and choose whether to create new pages or overwrite existing
entities.

Beyond a one‑way import, the module supports **updating content in Drupal from
Content Workflow**, **pushing updates from Drupal back to Content Workflow**,
**multilingual** content (via entity translation), basic **meta‑tag** support,
content **hierarchy**, and **Drush** commands for scripted imports. It is the
supported replacement for the deprecated GatherContent module; installing it on a
site that still has GatherContent will migrate the existing configuration, after
which you uninstall and remove GatherContent.

Two practical points shape setup. First, the module talks to the **Content
Workflow API** using a custom communication library, so you need a **Content
Workflow account** and **API credentials** — and because it makes **outbound
calls to Bynder's service**, treat that egress as a dependency and keep those
credentials out of version control (see Configuration). Second, imports run
through **Migrate**, so it depends on **Migrate Plus** and **Migrate Tools** in
addition to core Node, Taxonomy, and Media.

The module runs on Drupal 9.2, 10, and 11, and is actively maintained. Access is
gated by the **administer content_workflow_bynder** permission. Note the
maintainers' warning: this major version is **not backwards compatible** with
older major versions and there is **no upgrade path** between them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in
   the Migrate dependencies) and enable it.
2. [Configuration](configuration/index.md) — connect your Content Workflow
   account, store the API credentials safely, and run imports.

## Where it lives in the admin menu

After enabling, the module's settings and import tools live under the admin area
(gated by **administer content_workflow_bynder**). See
[Configuration](configuration/index.md) for connecting your account and running
an import, including how to store the API credentials securely.
