# AI LLMs.txt Generator — manual setup guide

**AI LLMs.txt Generator** (`ai_llms_txt_generator`) creates an `llms.txt` file for
your site using AI. An `llms.txt` is an emerging, spec-defined file — the AI-era
counterpart to `robots.txt` — that gives large language models a curated guide to
your site: what it is about and which pages matter. This module builds that file
by reading your **Simple Sitemap** (`sitemap.xml`) and asking an AI provider to
turn the list of URLs into a well-structured, spec-compliant `llms.txt`.

It sits on two other modules: **AI** supplies the connection to a language model
(configured once there, with its API key), and **Simple Sitemap** supplies the
list of your public URLs. The result is a file aimed at LLM crawlers, so it should
describe **only content you are happy to have public** — the same judgement you
apply to a sitemap.

Two points to keep in mind. Generating the file sends your sitemap and content
data out to the configured AI provider over HTTPS, so confirm that egress is
acceptable and keep the provider key stored as a secret. And because the output is
published for crawlers, review it to be sure it only surfaces public material. The
module defines its own permission to control who can generate the file.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the AI and sitemap prerequisites.

## Where it lives in the admin menu

The module has no general settings screen; it reuses the AI provider configured in
the **AI** module (**Configuration → AI**) and the sitemap produced by Simple
Sitemap. It defines its own permission, so grant that to the roles who should be
able to generate the `llms.txt` before they can use it.

## How to use it

1. Make sure Simple Sitemap is producing a `sitemap.xml` and the AI module has a
   working provider configured; enable this module and grant its permission (see
   [Installation](installation/index.md)).
2. Generate the `llms.txt` — the module reads your sitemap and asks the AI provider
   to produce a spec-compliant file.
3. Review the result so it describes only public content, then publish it for LLM
   crawlers.
