# Token Or — manual setup guide

**Token Or** (`token_or`) adds "OR" / fallback logic *inside a single token*.
Write `[token_a|token_b|"a literal string"]` and, when the text is replaced,
Drupal uses the first candidate that produces a non‑empty result. It is the
declarative equivalent of "use this, or that if it's empty, or this default
string if both are empty" — without writing any custom PHP.

You chain candidates with the pipe character `|`. Each candidate is evaluated
left to right; the first one that resolves to something non‑empty wins. A
candidate wrapped in double quotes is treated as a literal fallback string rather
than a token, so you can always end a chain with a guaranteed default. For
example:

```
[node:field_og_image:entity:url|node:field_header_image:entity:url|"https://example.com/default.png"]
```

Token Or extends Drupal's **Token** module, so the syntax works everywhere tokens
are replaced — Metatag values, Pathauto patterns, email templates, and any text
field that runs tokens. Any token registered by core or a contrib module can take
part in an OR chain automatically, with no extra code. There is no admin
interface, no configuration, and no permissions — it is pure syntax on top of the
existing Token API.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) the Webform submodule.

## Where it lives in the admin menu

Nowhere — Token Or has no settings page. Once enabled it simply makes the piped
`[a|b|"c"]` syntax valid anywhere tokens are used.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Wherever you would normally enter a single token, enter a piped chain instead.
   List your preferred token first, any alternatives next, and an optional quoted
   literal string last as a guaranteed fallback.
3. Save. When the text renders, the first non‑empty candidate is used.

A few practical examples:

- **Fallback image:** an Open Graph image field, then a header image field, then
  a hard‑coded default URL.
- **Fallback text:** a node's summary, or its full body if the summary is empty.
- **Fallback name:** `[node:author:field_display_name|node:author:name]`.
- **Guaranteed default:** end any chain with `|"N/A"` so an empty result never
  leaves a blank gap.

If every candidate is empty, the original `[a|b]` text is left in place unless
the surrounding system asks tokens to be cleared, in which case the whole group
is removed. Non‑piped, ordinary tokens continue to work exactly as before.
