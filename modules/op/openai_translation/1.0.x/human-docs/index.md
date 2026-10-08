# OpenAI Translation Toolbox — manual setup guide

**OpenAI Translation Toolbox** (`openai_translation`) is a helper for multilingual
Drupal sites that uses OpenAI (or **Azure OpenAI**) to machine‑translate content
into the languages your site has enabled. Because it uses a large language model
rather than a dictionary‑style translator, it often handles context and phrasing
better than traditional machine translation. With a few clicks you generate
translations for the languages you choose, then copy and paste them wherever you
need them.

Its way of working is deliberately simple: rather than writing translations
straight into your entities, it **generates translations you copy and paste**.
That keeps a human in the loop — you review each translation before it goes live —
which is exactly the right posture for machine output. You can generate
translations in bulk for all enabled languages at once, or pick specific
languages from the list.

Two things to keep in mind. First, the module authenticates with an **OpenAI (or
Azure OpenAI) API key** that you enter on its configuration page — store it
securely and keep it out of version control. Second, the text you translate is
sent to OpenAI, so review what you're sending (watch for personal data) and keep
an eye on cost, since each translation is a billable API call. Always review the
generated translations before publishing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connect your OpenAI or Azure OpenAI
   account and choose your languages.

## How to use it

After connecting your account and selecting languages on the configuration page,
generate translations for your content, then use the copy feature to paste each
translation into the right place on your site. Review every translation before
publishing.
