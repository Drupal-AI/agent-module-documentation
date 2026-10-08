# AI JSON-LD Schema Generator — manual setup guide

**AI JSON-LD Schema Generator** (`ai_jsonld_schema_generator`) uses AI to write
Schema.org structured data for your content and attach it to the page. Schema.org
JSON-LD is the machine-readable summary search engines read to understand what a
page is about (an article, a product, an event, and so on), and building it by
hand is fiddly. This module reads a node's content, asks an AI model to produce
the appropriate JSON-LD, and attaches it — helping search engines index your pages
and potentially earn richer search results.

It builds on Drupal's **AI** module, which provides the connection to a language
model; you configure that provider and its API key once in the AI module, and this
module reuses it. It works with core's **Node** content.

Two things to keep in mind. First, generating schema sends your content out to the
configured AI provider over HTTPS, so confirm that is acceptable for the material
involved and keep the provider key stored as a secret through the AI module's Key
configuration. Second, AI-generated structured data should be **reviewed before
you rely on it** — inaccurate schema can mislead search engines, so treat the
output as a strong draft rather than something to publish blindly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm an AI provider is configured.

## Where it lives in the admin menu

The module has no dedicated settings screen; it works against your nodes using the
provider configured in the **AI** module (**Configuration → AI**). It defines its
own permission, so grant that to the roles who should be able to generate schema
before they can use it.

## How to use it

1. Make sure the AI module has a working provider configured, enable this module,
   and grant its permission to the appropriate roles
   (see [Installation](installation/index.md)).
2. For a node, generate the Schema.org JSON-LD through the option the module adds —
   it reads the content and produces the structured data.
3. **Review** the generated schema for accuracy, then let it attach to the page so
   search engines can read it.
