# Key per language — manual setup guide

**Key per language** (`key_per_language`) is a provider for the
[Key](https://www.drupal.org/project/key) module that lets a single Key entity
resolve to a **different secret depending on the site's active language**. If your
multilingual site needs a different third‑party credential per market — say a
different API key for your French site than for your German one — this provider lets
you hide that behind one logical key.

The way it works is neat: you create the individual language‑specific keys in the
Key module as usual, then create one **special key** that uses the "Key per
Language" provider and map each configured language to one of those keys. At runtime,
when any code asks the Key module for that key's value, this provider looks up the
language of the current request and returns the mapped key's value for it. Callers
never have to know there are multiple keys behind it.

Because it deals with secrets, follow the Key module's secure‑storage guidance for
every underlying key: source each per‑language value securely (environment/Key
providers), and never commit raw secret values. The module supports Drupal 8.9
through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it with
   the Key module.
2. [Configuration](configuration/index.md) — create the per‑language keys and the
   special resolving key, step by step.

## Where it lives in the admin menu

Key per language adds no page of its own. You create and manage keys from the Key
module's **Manage keys** page at **Configuration → System → Keys**
(`/admin/config/system/keys`); the per‑language behaviour is a **key provider** you
choose when adding a key.
