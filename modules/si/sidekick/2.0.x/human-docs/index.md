# Sidekick — manual setup guide

**Sidekick** (`sidekick`) is an AI writing assistant for editors, built around a remote
service (AI Sidekick) that is powered by ChatGPT. As you author a node, it fetches
content suggestions from the Sidekick API and surfaces them right in the edit form, so
you can brainstorm ideas, draft body copy, and refine phrasing without leaving Drupal.

The goal is to speed up first-draft authoring. Rather than staring at a blank field, an
editor can ask the assistant for suggestions, review what comes back, and pull the good
parts into their content. Suggestions are woven into the node form through a custom
image widget and templates, and generation is something the editor triggers — nothing
is written automatically.

Sidekick needs configuration before it does anything: you enter an **API key** on its
settings form, and you decide which users are allowed to generate content. It ships two
permissions — one to administer the module's configuration, and one
(`sidekick content generation`) that controls who may actually request AI suggestions.
It depends on core's Node and Dynamic Page Cache modules and on the Token module.

Two practical notes from the module's own guidance. First, generation calls a **paid
remote service**, so restrict the `sidekick content generation` permission to trusted
editors to keep your costs (and quota use) under control. Second, the API key is stored
as **plaintext in the module's exportable configuration** — it is not wired through the
Key module — so be mindful about who can export or read your site configuration, and
guard access to config export accordingly. The module's outbound calls use standard TLS
with certificate verification on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it, along with its dependencies.
2. [Configuration](configuration/index.md) — enter the API key and grant the
   generation permission.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Sidekick**
(`/admin/config/services/sidekick`, route `sidekick.settings_form`), behind the
**Administer Sidekick configuration** permission. That is where you enter your API key
and options.
