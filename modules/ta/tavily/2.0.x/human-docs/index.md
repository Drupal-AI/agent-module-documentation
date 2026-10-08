# Tavily Core — manual setup guide

**Tavily Core** (`tavily`) connects Drupal to [Tavily](https://tavily.com), an
AI‑powered web search and answer engine. Give it a search word or a question and
Tavily returns short summaries drawn from real sources online, plus the links
those summaries came from — the kind of live web context an AI feature often
needs but Drupal cannot produce on its own.

The module offers this in two ways. First, it exposes a service
(`tavily.api`) that any other module or piece of custom code can call to run a
search and get back a JSON array of answers and links. Second — and this is what
most people install it for — it provides two **AI Automator** types for the
[AI module](https://www.drupal.org/project/ai). One takes a text field
containing a search word and fills a set of Link fields with relevant URLs; the
other fills a long‑text field with summaries for that search word. In practice
you point an Automator at a field, save an entity with a search term in it, and
Tavily populates the target fields for you.

A few things to know before you rely on it. Tavily is a paid third‑party
service — you need a Tavily account (there is a free trial) and every search
call is sent to Tavily's servers and may incur cost. Your API key is stored
through Drupal's **Key** module (which can back it with an environment
variable), so it is kept out of configuration exports. Use of the module's tools
is gated behind the `use tavily tools` permission, so grant that only to trusted
roles. It depends on the **Key** module, works with the AI module's AI Automator
submodule, and supports Drupal 10.3+ and 11.

This guide is written for a **human** setting the site up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Key module
   with Composer, then enable it.
2. [Configuration](configuration/index.md) — add your Tavily API key and wire an
   AI Automator to a field.

## Where it lives in the admin menu

Tavily's settings live at **Configuration → Tavily → Settings**
(`/admin/config/tavily/settings`), where you enter your API key. The AI
Automator behaviour is configured per field, on the field's settings, once the
AI module is installed.
