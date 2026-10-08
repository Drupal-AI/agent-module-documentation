# Search API Vragen.ai — manual setup guide

**Search API Vragen.ai** (`search_api_vragen_ai`) integrates Drupal's Search API
with **Vragen.ai**, an AI-powered search service that answers questions based on
your own content. Rather than relying only on keyword matching, Vragen.ai
retrieves relevant information from your configured sources and generates an
answer — with source references — so Drupal content can power an AI search
interface, assistant, or chatbot.

The module's job is the **indexing and synchronisation** part of that flow: it
lets Search API content be synchronised to Vragen.ai as a managed knowledge
source. Your Drupal site stays the content source of truth, and Vragen.ai
provides the natural-language interface on top of the indexed content. The overall
architecture is: Drupal content → Search API index → Vragen.ai backend → AI
search / assistant interface. Typical use cases are documentation and knowledge
bases, service and support content, public information sites, and content-heavy
platforms where plain keyword search falls short.

This module does **not** work on enable alone. It needs access to a Vragen.ai
environment, and you must supply the API endpoint created for your organisation
plus a bearer token, then create a Search API server and index on the Vragen.ai
backend. It depends only on **Search API** and requires **Drupal 10 or 11**.

A data-governance point to weigh honestly: indexed content **and search queries
leave your infrastructure** and are sent to the Vragen.ai service to be embedded
and searched. The bearer token is a credential — keep it out of plain
configuration. For public content this simply adds semantic search; for
confidential content, weigh the external processing before you index it.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Vragen.ai endpoint and
   token, then set up the Search API server and index.

## Where it lives in the admin menu

The authentication form — where you enter your organisation's endpoint and bearer
token — is at **Configuration → Search and metadata → Vragen.ai**
(`/admin/config/search/vragen-ai`). The Search API server and index you connect to
Vragen.ai live under **Configuration → Search and metadata → Search API**.
