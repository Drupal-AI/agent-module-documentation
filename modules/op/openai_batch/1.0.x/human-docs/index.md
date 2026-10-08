# OpenAI Batch — manual setup guide

**OpenAI Batch** (`openai_batch`) is a wrapper module that lets your Drupal site
work with OpenAI's **Batch API** — submitting large sets of requests as a single
asynchronous job instead of one call at a time. The main draw is cost: OpenAI's
Batch service is significantly cheaper than real‑time calls, which makes it a good
fit for bulk work over many content entities. You select the entities in a view,
run a Views Bulk Operations (VBO) action, and the module packages them into a
batch and sends it to OpenAI. When processing finishes, Drupal's cron downloads
and parses the response.

It's best thought of as a **framework for developers** rather than a
ready‑to‑click feature. To use it, a developer implements an
`OpenAiBatchProcessor` plugin in a custom module (extending
`OpenAiBatchProcessorPluginBase` and implementing `OpenAiBatchVBOActionInterface`)
that defines what each batch actually asks OpenAI to do — for example "write a
summary", "tag this content with taxonomy terms", or anything else you need. The
module ships an example `WriteSummary` processor to model your own on.

Because it sends your content to OpenAI in bulk, weigh the data‑egress
implications before enabling it on sensitive or large datasets — and remember that
batches cost money, so the permission that lets users run them should be granted
only to trusted roles. The module has no access‑control role beyond that
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the AI
   dependencies, and enable the module.

There is **no settings page of its own**. The OpenAI connection (provider and API
key) is configured in the **AI** module and its **AI Provider OpenAI** submodule,
not here — see below.

## Where its configuration lives

OpenAI Batch relies on the **AI** module for the OpenAI connection. You set the
OpenAI **API key** (as a **Key** entity) and choose the provider in the AI
module's own configuration, at **Configuration → AI**. Batch simply reuses that
connection, so there is no separate credentials form in this module.

## How to use it

1. Have a developer implement an `OpenAiBatchProcessor` plugin (see the bundled
   `WriteSummary` example) describing what the batch should ask OpenAI to do.
2. Grant the module's permission to run batches only to trusted roles at **People
   → Permissions**.
3. In a view of the content you want to process, select the entities and run the
   VBO action your plugin provides. The module creates the batch and sends it to
   OpenAI.
4. Let **cron** run — it downloads and parses the completed batch's results.
