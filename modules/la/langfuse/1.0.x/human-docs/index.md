# LangFuse — manual setup guide

**LangFuse** (`langfuse`) connects Drupal to
[LangFuse](https://langfuse.com/), an LLM‑observability platform, so you can trace
and analyse the AI calls your site makes. Once configured, it captures details of
each interaction — the prompts sent, the responses received, latency, token usage,
error rates, and model performance — and sends them to LangFuse where you can
inspect and debug your AI features in one place.

Its headline feature is **zero‑configuration AI tracking** when paired with the
AI module: with the logging submodule enabled, AI interactions are captured
automatically, with no code changes. Multiple AI operations (say an embedding call,
a chat completion, and a tool call) can be grouped into a single coherent trace,
and dedicated submodules add deeper instrumentation for the AI Agents and AI
Search/RAG modules. It supports several authentication methods — an API key pair
(recommended), a bearer token, or basic auth — and works with both LangFuse Cloud
and a self‑hosted LangFuse instance.

**Data‑egress and privacy consideration.** LangFuse works by sending your AI trace
data off‑site to the LangFuse service. That data can include **prompt and response
content, which may be sensitive or contain personal information (PII)**. Before
enabling it, confirm it's acceptable for that content to leave your site, disclose
it in your privacy policy as appropriate, and consider self‑hosting LangFuse if you
need the data to stay within your own infrastructure. Authenticate over HTTPS and
store the credentials as secrets.

It depends on core's **Configuration Manager** (`config`) and **System**
(`system`) modules, requires **PHP 8.1+**, and supports Drupal 10 and 11. It is
currently an alpha release — treat it accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   the core module, and pick the optional instrumentation submodules.
2. [Configuration](configuration/index.md) — set the LangFuse URL, choose an
   authentication method, supply and secure your credentials, and confirm the
   connection.

## Where it lives in the admin menu

The settings form is at **Configuration → System → LangFuse → Settings**
(`/admin/config/system/langfuse/settings`).
