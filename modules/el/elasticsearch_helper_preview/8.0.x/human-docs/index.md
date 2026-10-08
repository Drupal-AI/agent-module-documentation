# Elasticsearch Helper Preview — manual setup guide

**Elasticsearch Helper Preview** (`elasticsearch_helper_preview`) adds a **preview
capability for decoupled (headless) Drupal**. In a decoupled setup the front end is
a separate application, so the usual "Preview" button on a node form has nowhere
useful to go. This module bridges that gap: an editor working on an unsaved or draft
entity can preview it in the front-end application, and the module handles getting
the draft content over to that app.

It works by **staging the current form values into a temporary Elasticsearch index**
and then redirecting the editor to the front-end app's preview URL, where the app
reads that temporary document and renders it. The preview payload is held in the
per-user private tempstore, the temporary index entries expire after a configurable
time, and expired preview indices are cleaned up on cron — so previews don't pile up
or get published to the live index.

It depends on the base
[Elasticsearch Helper](https://www.drupal.org/project/elasticsearch_helper) module.
Two things need configuring: a site-wide settings form (the front-end base URL and
the preview-index expiration), and a per-index setting (turn preview on for a given
content index and give it a preview path template). Access to the preview link is
gated to users who can **edit** the entity, so draft and unpublished content is not
exposed to unauthorized visitors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Elasticsearch Helper.
2. [Configuration](configuration/index.md) — set the front-end base URL, enable
   preview per index, and understand the access model.

## Where it lives in the admin menu

The settings form is at **Configuration → Search and metadata → Elasticsearch
Helper → Preview** (`/admin/config/search/elasticsearch_helper/preview`, route
`elasticsearch_helper_preview.settings`), gated by the **Administer site
configuration** permission. Per-index preview options appear on each Elasticsearch
content index's form.

## How to use it

Once configured, editing a node shows a **preview button**. Clicking it stores the
built document in your private tempstore and hands you a link to the front-end
preview URL for that draft. Only a user who can update the entity can follow that
link, so previews of unpublished content stay private.
