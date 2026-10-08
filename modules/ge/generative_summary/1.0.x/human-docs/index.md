# Generative Summary — manual setup guide

**Generative Summary** (`generative_summary`) adds a **"Generate Summary"**
button to text/summary fields on your content forms. When an editor clicks it,
the module sends the field's content to **OpenAI's Chat Completions API** and
drops the resulting draft summary back into the field, where the editor can read
it, tweak it, or accept it as-is. It's a small quality-of-life tool for content
teams who write a lot of summaries by hand.

The module uses a layered configuration approach: you set global defaults that
apply to every text field, and then optionally override them per field. You can
control the summary's minimum and maximum length, cap the number of sentences,
and supply your own system and user prompts to steer the tone and framing of what
OpenAI returns. It depends only on core's **Field** module.

Two things are worth understanding before you switch this on. First, using it
**sends your field content to OpenAI** — a third‑party service outside your site.
Make sure that egress is acceptable for the content in question (drafts,
unpublished material, anything sensitive). Second, every click costs an OpenAI
API call against your account, so it's wise to expose the button only to trusted
editors and keep an eye on usage. The module has no access‑control role of its
own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — store your OpenAI API key, set the
   global summary defaults, and configure per‑field overrides.

## Where it lives in the admin menu

The module's global settings live at **Configuration → Content authoring →
Generative Summary** (`/admin/config/content/generative_summary`). That's where
you set the OpenAI API key and the site‑wide defaults. Per‑field options live on
each field's own settings page under **Structure → Content types → *(type)* →
Manage fields**.

## How to use it

Once configured, editors see a **Generate Summary** button beside the enabled
summary field on the content form. They write (or paste) the body content, click
the button, wait for OpenAI to respond, and the drafted summary appears in the
field ready to edit or keep. Nothing is sent until the button is clicked, so the
editor is always in control of when a call happens.
