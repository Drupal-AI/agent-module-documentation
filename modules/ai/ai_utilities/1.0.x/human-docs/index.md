# AI Utilities — manual setup guide

**AI Utilities** (`ai_utilities`) is a small developer helper module. Its whole
job is to tidy up the raw output that AI/LLM models return so it can be shown
safely and cleanly on a Drupal site. It provides one service — a **Format**
helper — that other modules call to convert Markdown into HTML, detect whether a
string is already HTML, and strip the wrapping ```` ``` ```` code fences that
models often add around their answers.

There is nothing for a site builder to click here. The module has no
configuration screen, no routes, no permissions, and it makes no network calls of
its own — it is a support library that other AI-related modules depend on and
reuse, keeping all this "clean up the model's response" logic in one place instead
of each module reinventing it. It depends on no other contrib modules and works
on Drupal 10.

You would install this because another module asks for it, or because you are
writing code that needs to normalize AI output before displaying it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no admin UI and no configuration to perform. Once enabled, the module
exposes the `ai_utilities.format` service (class `Drupal\ai_utilities\Format`,
typed via `FormatInterface`). Developers inject or call that service to:

- **`isHtml()`** — check whether a string is already HTML;
- **`markdownToHtml()`** — convert Markdown text to HTML;
- **`trim()`** — strip wrapping code fences (for example ```` ```html ````
  blocks) from a model response.

If you enabled it only because another module required it, you are done — there is
nothing further to set up.
