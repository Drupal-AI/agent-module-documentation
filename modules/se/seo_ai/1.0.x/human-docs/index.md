# SEO AI — manual setup guide

**SEO AI** (`seo_ai`) adds a one-click **Generate Metatags** button to your node
edit forms. Press it and the module sends the page's title and body to an
AI service (an OpenAI-compatible chat API of your choosing) and fills in the
node's Metatag fields with the suggestions it gets back — a meta title, a meta
description, an abstract, keywords, and Open Graph title and description.

It is meant for content creators who want good search-engine and social metadata
without writing it by hand for every page. The AI suggests a concise meta title
(aimed at roughly 60 characters so it fits a search result), a description
written for the search snippet, plus keywords and Open Graph values, and the
module drops them straight into the Metatag basic and Open Graph fields via AJAX
so you can review and tweak before saving.

SEO AI needs configuration before it will do anything — you have to point it at
an AI endpoint, give it a model and an API token, and choose which content types
show the button. It depends on core's **Node** module and the **Metatag** module
(the target content type must have a Metatag field), and it ships no submodules.
The button only appears on the content types you enable, and only when the node
has a Metatag field.

A note on security: the AI endpoint is set by an administrator (it is never taken
from user input), and the outbound call uses normal TLS verification. The API
token, however, is stored in the module's configuration in plain text, so treat
your site config as sensitive and restrict who holds the `administer seo ai`
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Node and Metatag.
2. [Configuration](configuration/index.md) — point SEO AI at an AI endpoint, set
   the model and token, and choose which content types get the button.

## Where it lives in the admin menu

The settings form sits at **Configuration → Search and metadata → SEO AI**
(`/admin/config/content/seo-ai`, route `seo_ai.admin_settings`), behind the
restricted `administer seo ai` permission.

## How to use it

Once configured, edit a node of an enabled content type. You will see a
**Generate Metatags** button on the form; click it and the Metatag fields fill in
with the AI's suggestions. Review them, adjust anything you like, and save the
node as usual. If the AI service is unreachable or returns an error, the module
shows an error message rather than changing your fields.
