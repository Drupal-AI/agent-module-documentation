# Open AI Metadata — manual setup guide

**Open AI Metadata** (`open_ai_metadata`) uses the OpenAI chat‑completions API to
help editors generate content directly from the node form. Its headline feature
is generating an SEO **meta description** from a node's title — click a *Generate
Metadata* button and the model drafts a summary that lands in the node's Summary
field, ready to serve as the page's meta description. It also offers a **content
generator**: a *Generate Content* link opens a modal where you enter a prompt,
and the generated text can be pushed into the body field.

Under the hood the module sends your prompt (built from the node title, or from
what you type into the content form) to OpenAI over HTTPS using Drupal's default
HTTP client, so TLS verification stays on. The OpenAI access token is stored in
Drupal's `state` store rather than in exported configuration, which keeps the
secret out of your config sync directory. Because content is sent to OpenAI,
review that provider's data‑handling terms before enabling it for editors, and
keep in mind that every generation is a billable API call.

One quirk worth knowing: the admin routes reference custom permissions that the
module does not actually define, so until those permissions are provided the
settings pages are effectively restricted to user 1 (the superuser). That is a
fail‑closed situation — locked down rather than exposed — but it's why you may
find you need to be user 1 to reach the settings at first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connect your OpenAI account and pick
   which content types get the generation buttons.

## Where it lives in the admin menu

The OpenAI connection settings live at **Configuration → Open AI Metadata → Open
AI API settings** (route `open_ai_metadata.admin_settings`,
`/admin/config/open_ai_metadata/open-ai-api-settings`), and the per‑content‑type
settings at `/admin/config/metadata-content-settings`. Both are described in
[Configuration](configuration/index.md).

## How to use it

Once configured, edit a node of a selected content type. A **Generate Metadata**
button appears on the form — enter the node title and click it to have OpenAI
draft a meta description into the Summary field. A **Generate Content** link opens
a modal where you enter a prompt; review the result and click **Use Content** to
drop it into the body field. Treat everything the model produces as a first draft
and edit it before publishing.
