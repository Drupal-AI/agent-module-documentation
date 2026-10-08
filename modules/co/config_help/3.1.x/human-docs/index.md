# Configurable Help — manual setup guide

**Configurable Help** (`config_help`) extends Drupal core's **Help Topics** system
so that site administrators — not just module developers — can create and edit help
topic pages through the admin UI. Normally, help topics are defined in code by
modules, themes, and install profiles and appear read-only on `/admin/help`. This
module adds a `config_help` **configuration entity**, letting you write your own
topics in the browser and have them appear seamlessly alongside the read-only ones.

Because your topics are stored as **configuration**, they behave like any other
site config: they can be **translated**, **exported**, and **imported** between
environments. That makes it a clean way to build a site-specific help system that
non-developers can maintain, while keeping the documentation versioned in your
config management workflow.

Each topic you create has an id, a label, a *top-level* flag (whether it shows on
the main Help page), a list of related-topic ids, and a body rendered through a
text format (default `help`). A topic-id autocomplete helps you wire up "related
topics" links. Only the topics **you create here** are editable — the plugin/YAML
topics that modules and themes provide stay read-only.

It requires core's **Help** (`help`) and **Filter** (`filter`) modules, provides
its own permission (`administer config help`), and supports Drupal 11.1+ and 12.
With core's **Configuration Translation** enabled, your topics become translatable.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Help and Filter.
2. [Configuration](configuration/index.md) — create, edit, and manage help topics,
   field by field.

## Where it lives in the admin menu

The topic collection — where you add, edit, and delete configurable help topics —
lives at **Configuration → Development → Configurable Help**
(`/admin/config/development/config-help`), gated by the *administer config help*
permission. The topics you publish there appear on the standard Help pages at
`/admin/help` alongside the read-only topics modules provide.
