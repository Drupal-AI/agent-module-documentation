# Entity to Text — manual setup guide

**Entity to Text** (`entity_to_text`) is a developer‑focused suite of utility and
helper APIs that flatten a Drupal entity into **plain text**. It takes an entity —
a node, a paragraph, or (via a submodule) an uploaded file — and gives you back a
clean text representation of its field content. That text is exactly what you need
when feeding content to a search engine (Solr, Elasticsearch), building embeddings
for AI/LLM use, or producing plain text for SEO and JSON‑LD.

This is primarily a **developer experience** tool: it is a set of APIs you call
from your own code, not a point‑and‑click feature. There is **no settings page and
no admin UI** — you enable the module and then use its services in a custom module,
service, or integration. See the project's code examples for complete usage.

The base module requires the `ezyang/htmlpurifier` PHP library (installed
automatically through Composer). Two optional submodules extend it: **Entity to
Text Paragraphs** (`entity_to_text_paragraphs`) adds support for extracting text
from Paragraphs and needs the `drupal/paragraphs` module, and **Entity to Text
Tika** (`entity_to_text_tika`) extracts text from uploaded **files** using Apache
Tika and needs the `vaites/php-apache-tika` library.

A note on data handling: whatever you do with the extracted text is your
responsibility. If you send it to an external AI/LLM service or a hosted search
index, that is data leaving your site — confirm it is acceptable for the content
involved. The Tika submodule extracts text from user‑uploaded files, which should
be treated as untrusted input, so run Tika in a trusted or sandboxed setup. The
extracted text mirrors the entity's own field data, so respect the source's access
rules when you use the output.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and add the Paragraphs or Tika submodules if you need them.

There is **no configuration page** for this module — it exposes APIs for
developers rather than a settings form. Use it from code as shown in the project's
examples.

## How to use it

Entity to Text has no admin screens. After enabling it, a developer calls its
services from custom code to convert an entity to text — for example to build the
document body you send to a search index or an embedding pipeline. Enable the
**Paragraphs** submodule when your content uses Paragraphs, and the **Tika**
submodule when you also need the text content of uploaded files.
