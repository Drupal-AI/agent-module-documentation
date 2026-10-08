# Dify — manual setup guide

**Dify** (`dify`) is the official Drupal integration for the **Dify** AI
application platform. It lets you index your Drupal content into a Dify knowledge
base, embed AI-powered chatbot widgets on your site, and augment your search
results with AI-generated answers — all while keeping your Dify credentials
server-side, so tokens never reach the browser.

The base module provides the shared plumbing (an API client, markdown rendering,
and a server-side streaming proxy) and does very little on its own. You then
enable only the **submodules** you need:

- **Dify Search API** (`dify_search_api`) — a Search API backend that pushes
  Drupal content into a Dify knowledge base, with automatic, custom, or
  hierarchical chunking, per-field priority weights, and file extraction from PDF,
  DOCX, and similar fields.
- **Dify Vanilla Widget** (`dify_widget_vanilla`) — a fully themeable custom
  chatbot block with streaming responses, conversation history, thumbs up/down
  feedback, suggested questions, overridable avatars, and 20 CSS color variables.
- **Dify Official Widget** (`dify_widget_official`) — drops Dify's own hosted embed
  chatbot onto your site as a block, with no custom code.
- **Dify Augmented Search** (`dify_augmented_search`) — a block that detects search
  queries and shows AI-generated answers (from a Dify Workflow) alongside normal
  search results.

Security is designed in: all API calls go through a server-side proxy, credentials
are stored in Drupal State (database-only, never exported with configuration),
POST proxy routes are CSRF-protected, and SSL verification is on for outgoing
requests. It requires Drupal 10 or 11, PHP 8.1+, and a running Dify instance
(cloud or self-hosted).

> **Data and cost note:** This module sends your content and users' prompts to
> your Dify instance, which in turn talks to whatever LLM the Dify app uses.
> Confirm the endpoint is trusted and reached over HTTPS, and treat your Dify API
> token as a secret.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable the base module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — enter your Dify credentials, place
   the chatbot widgets, and set up content indexing and augmented search.

## Where it lives in the admin menu

The base module's credentials form (used by content indexing) is at
**Configuration → Search and metadata → Dify** (`/admin/config/search/dify`). The
chatbot widgets are placed and configured as blocks under **Structure → Block
layout**. Search indexing is set up under **Configuration → Search and metadata →
Search API**.
