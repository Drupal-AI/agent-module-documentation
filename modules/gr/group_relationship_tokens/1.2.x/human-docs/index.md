# Group relationship tokens — manual setup guide

**Group relationship tokens** (`group_relationship_tokens`) adds tokens for the
entities referenced by [Group](https://www.drupal.org/project/group)
relationships. The Group module already exposes plenty of tokens on its own, but
sometimes you need to reach *through* a group relationship to the entity on the
other side of it — the node a piece of group content wraps, or the user behind a
membership. This module makes that possible.

With it installed, you can chain from a group relationship to the referenced
entity's own tokens. For example, for the `gnode` module you could get the node's
title with `[group_relationship:node:title]`, or the value of a custom text field
with `[group_relationship:node:field_custom:value]`. It works for users on a
membership relationship too, such as `[group_relationship:user:name]`.

A common reason to want this is building a Pathauto pattern (or an email, or any
token‑based text) from data on the referenced entity rather than on the group
relationship itself.

This is purely a developer/tokens convenience. The token values simply reflect the
group relationships that already exist — the module has no access‑control role and
needs no configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Group and Token.

There is **no settings page** and nothing to configure. Once enabled, the new
tokens appear automatically wherever a token browser is available.

## How to use it

There is no setup step beyond enabling the module. For every entity type your
group‑relationship configurations connect to, a new token is exposed under the
`group_relationship` namespace. Open any token browser (for instance while editing
a Pathauto pattern or an email template) and you'll find the chained
`[group_relationship:…]` tokens ready to use.

One thing to be aware of: this module is designed for **Group version 1**. Check
compatibility against your Group version before relying on it.
