# Token Modifier — manual setup guide

**Token Modifier** (`token_modifier`) adds a "meta" token that transforms the
output of any other token. Tokens in Drupal are plain values, not expressions, so
getting an uppercase title or a URL‑encoded field has traditionally meant writing
custom code. This module lets you wrap an existing token in a transformation right
inside the token itself — for example
`[token-modifier:uppercase:node:title]` runs the node title through an uppercase
transform.

The syntax is `[token-modifier:MODIFIER:REST:OF:THE:TOKEN]`: the first segment
after `token-modifier` names the transformation, and everything after it is the
ordinary token you want to transform. So `[token-modifier:urlencode:node:field_slug]`
URL‑encodes the slug field, and `[token-modifier:striptags:node:body]` strips HTML
tags from the body.

Ten transformations ship out of the box — **Length, Lowercase, Ltrim, Rtrim,
Trim, StripTags, TitleCase, UpperCase, UpperCaseFirst** and **Urlencode** — and
they're implemented as a small plugin type, so a developer can add project‑specific
modifiers with a short class. Every modifier is advertised to the Token browser,
so editors can discover them there.

This guide is written for a **human** and for developers. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (it needs the Token module) and enable it.

## How to use it

Use the token anywhere Drupal resolves tokens — Pathauto patterns, Metatag values,
email templates, Token‑aware fields, and so on:

```
[token-modifier:uppercase:node:title]        → the node title, uppercased
[token-modifier:urlencode:node:field_slug]   → the slug, URL-encoded
[token-modifier:trim:node:field_imported]    → the value with surrounding whitespace removed
[token-modifier:striptags:node:body]         → the body with HTML tags removed
[token-modifier:length:node:title]           → the number of characters in the title
```

There is **no configuration** — no settings page, permissions or Drush commands.
Just write the token where you need it. Two things to keep in mind:

- The inner token is resolved in the **same context** as where you use it, so it
  must be a token that's valid there. A token that needs data the current context
  doesn't provide resolves to an empty string.
- The modifier name comes straight from the token text, so an **unknown modifier
  name raises an error** rather than leaving the token untouched. Validate any
  patterns you let editors type.

### Adding your own modifier (for developers)

Create a plugin class in `your_module/src/Plugin/token_modifier/`, extend
`TokenModifierPluginBase`, annotate it with `@TokenModifier` (giving it an `id`,
name and description) and implement `transform()`. Then it's usable as
`[token-modifier:your_id:…]` and appears in the Token browser. See the
[`agent/`](../agent/start.md) docs for a code sketch.

## Where it lives in the admin menu

Nowhere — there's no admin screen. You use it purely by writing tokens, and you
can browse the available modifiers in the **Token browser** dialog wherever Drupal
offers one.
