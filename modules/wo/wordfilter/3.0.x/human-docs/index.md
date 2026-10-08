# Wordfilter — manual setup guide

**Wordfilter** (`wordfilter`) replaces banned or keyword words in your content
with configurable substitution text. Its classic use is a profanity filter —
censoring bad words in comments and content with `***` or `[removed]` — but it's
equally at home doing keyword replacement, such as normalizing brand names,
masking competitor mentions, or swapping placeholder keywords for dynamic values.

You define reusable **Wordfilter configuration** entities, each holding one or
more lists of *words to filter* paired with the *substitution text* to replace
them with, and a **filtering process** that decides how the replacement happens.
Two processes ship: **Direct substitution**, which builds a case‑insensitive
match from your word list and swaps in the substitution text, and **Token
substitution**, which does the same but also runs Drupal tokens inside the
substitution — so you can inject the current user name, site name, or other
dynamic values.

Once you've defined a configuration you can apply it in three ways: as a **text
format filter** (so it runs on any field using that format), directly on **content
types and comment types** (filtering the rendered title/body and comment subject),
or programmatically from code. Filtering happens on output only — your stored
content is left intact, and the transformation is applied each time the content is
rendered.

Wordfilter is careful about safety: every filter word and substitution string is
passed through Drupal's admin XSS filter before use, so script and dangerous‑HTML
vectors are stripped even from substitution text. New filtering backends (for
example an external moderation API) can be added as plugins.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create a configuration, apply it, and
   understand the permissions.

## Where it lives in the admin menu

The configuration list sits at **Configuration → Content authoring → Wordfilter
configurations** (`/admin/config/wordfilter_configuration`). Managing all
configurations requires the **Administer wordfilter configurations** permission
(a restricted permission).

## How to use it

Create a Wordfilter configuration with your word list and substitution text, then
apply it to a text format, a content/comment type, or in code. See
[Configuration](configuration/index.md) for the step‑by‑step.
