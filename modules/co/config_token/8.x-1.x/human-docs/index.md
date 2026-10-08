# Config Token — manual setup guide

**Config Token** (`config_token`) lets administrators define their own custom
tokens whose values are stored in **configuration**, so they can be reused anywhere
Drupal tokens work. Drupal's token system is everywhere — in text, in patterns, in
other modules' settings — but the set of available tokens is fixed by what modules
provide. Most sites, though, have a handful of values they repeat over and over: a
support phone number, the company name, a current campaign tag, a legal entity.
Hard-coding those into content means editing every occurrence when one changes.
Config Token turns each of them into a defined token instead, so `[config_token:
support_phone]` resolves to the configured number everywhere it appears, and
changing it is a single edit.

It works much like the **Custom Tokens** (`token_custom`) module, with one important
difference: where Custom Tokens stores its data in a custom *content* entity, Config
Token stores each token's value in *configuration*. That means your tokens export to
`config/sync` with `drush cex`, get committed to version control, and import into
other sites with `drush cim` — no database queries to move them around. This design
was originally driven by the need to export config used by the Domain Access module.

Because the values live in configuration, keep two things in mind. First, a token
used in many places is a lever: whoever can edit it changes every occurrence at once,
so token administration should be restricted to trusted site builders and
developers, not ordinary users. Second, config tokens are **not a place for
secrets** — the values are plain configuration, readable wherever the token renders
and visible in config exports. Use them for shared editorial constants, and keep
them non-sensitive. This is the 8.x‑1.7 release; it depends on the **Token**,
**Token Filter**, and core **Filter** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pull in its Token dependencies.

The module manages your custom tokens through its own admin listing rather than a
single settings form, so there is no separate configuration page — the workflow is
described under "How to use it" below.

## How to use it

1. Enable the module and its dependencies (see [Installation](installation/index.md)).
2. As an administrator, add a custom token, giving it a machine name and a value —
   for example a token named `support_phone` with your support line as its value.
3. Reference it wherever tokens are supported, such as `[config_token:support_phone]`
   in body text (via the Token Filter), in other modules' settings, or in patterns.
   It resolves to the configured value everywhere.
4. When the underlying value changes, edit the single token and every occurrence
   updates.
5. Export configuration (`drush cex`) to commit your tokens and carry them to other
   environments. Keep the values non-sensitive, and restrict who may administer
   tokens to trusted roles.
