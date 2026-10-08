# Paragraphs Summary Token — manual setup guide

**Paragraphs Summary Token** (`paragraphs_summary_token`) adds token
replacements that pull a plain-text **summary** and a representative **image**
out of a Paragraphs field. Content built entirely from paragraphs usually has no
single "summary" or "teaser image" field, which makes things like a meta
description or a social-share image awkward to populate. This module solves that
by exposing tokens such as `[node:field_paragraphs:summary]` and
`[node:field_paragraphs:image]` that derive those values from the paragraph
content automatically.

The summary token walks the referenced paragraphs, finds the first non-empty
long-text field, strips its markup, and trims it to 300 characters. The image
token finds the first image field or image-based media reference and returns the
property you ask for. Both tokens recurse into nested paragraphs and into
Paragraphs Library items, and both respect the current language's translation of
each paragraph, so you get language-correct output on translated content.

Because these are ordinary Drupal tokens, you can use them anywhere tokens are
supported — Metatag, Pathauto, email bodies, token-aware Views fields, or custom
code. There is no settings page and nothing to configure: enabling the module
registers the tokens, and you place them wherever you need them. So this guide
folds the "how to use it" details into this page rather than a separate
configuration chapter.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent — including the full image-property syntax and the two
builder services — read the sibling [`agent/`](../agent/start.md) docs,
especially [`agent/api/tokens.md`](../agent/api/tokens.md).

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Paragraphs and Token.

## How to use it

The tokens appear on any entity type that has a Paragraphs
(`entity_reference_revisions`) field, named after that field:

- **Summary** — `[node:FIELD:summary]`, e.g. `[node:field_paragraphs:summary]`.
  Returns the first paragraph's text, stripped and trimmed to 300 characters.
- **Image** — `[node:FIELD:image]`, e.g. `[node:field_paragraphs:image]`.
  Returns the absolute URL of the first image by default. You can request an
  image style and a specific property using a chained syntax:
  - `[node:field_paragraphs:image:large:url]` — URL of the `large` derivative.
  - `[node:field_paragraphs:image:large:width]` / `:height` — its dimensions.
  - Supported properties are `url` (absolute, the default), `uri` (relative),
    `width`, `height`, `mimetype`, and `filesize`.

Typical uses:

- Populate a **Metatag** meta description or Open Graph description from
  `[node:field_paragraphs:summary]`.
- Derive a social-share image with `[node:field_paragraphs:image:medium:url]`.
- Use the summary token as a **Pathauto** pattern component, or in an outgoing
  email body.
- Resolve one in code with
  `\Drupal::token()->replace('[node:field_paragraphs:summary]', ['node' => $node])`.

If nothing matches (no text or no image in the paragraphs), the token resolves
to an empty string, so it is safe to use as a fallback.

## Where it lives in the admin menu

There is no page of its own — the module simply registers tokens. Use the token
browser wherever tokens are offered (Metatag, Pathauto, and similar forms) to
discover the exact token names for your fields.
