# Plural Variants Serialization — manual setup guide

**Plural Variants Serialization** (`plural_serialization`) fixes an ugly corner of
Drupal's configuration export. Config values typed as `plural_label` — the
singular/plural forms of a translatable string — are stored joined together by a
control‑character delimiter (the ETX / "end of text" byte). That produces YAML that
is hard to read, hard to hand‑edit, and unfriendly to diffs and code review.

This module registers a config **storage‑transform** subscriber that walks every
config object's typed‑data tree, and for any `plural_label` element it **explodes
the delimited string into a clean YAML sequence on export** and **implodes it back
into the delimited string on import**. The stored form becomes a normal list of
items, while the value Drupal uses at runtime is completely unchanged.

The result is cleaner config diffs, hand‑editable plural strings, and fewer merge
conflicts on translated configuration — a real quality‑of‑life win for
config‑first multilingual sites. It exposes **no routes, permissions, forms, or
user‑facing UI**: it operates entirely inside the config import/export pipeline.
Install it, export your config, and plural labels appear as sequences in the YAML.
(For background, see the module's referenced core issue on plural label
serialization.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form and
nothing to click. It works automatically once enabled, described in "How to use it"
below.

## How to use it

There is nothing to configure — the transform runs automatically:

1. Enable the module.
2. Export your configuration (for example `drush config:export`). Any
   `plural_label` values now appear as readable YAML sequences instead of a single
   delimiter‑joined string.
3. Import as usual (`drush config:import`). The module implodes the sequence back
   into the form Drupal expects, so runtime behaviour is identical to before.
