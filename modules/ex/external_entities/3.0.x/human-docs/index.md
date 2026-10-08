# External Entities — manual setup guide

**External Entities** (`external_entities`) lets remote data — a REST API, a SQL
database, or another system — be **used inside Drupal as if it were native
content**, without importing or copying it. You define an *external entity type*,
tell it where the data lives and how to read it, and map the source's fields to
Drupal fields. From then on those remote records behave like ordinary entities:
they can be rendered with view modes, referenced from other content, listed and
filtered in Views, given path aliases, and more — while the data itself stays in
its source of truth. If the source supports writing, you can even create, edit, and
delete remote records through Drupal.

Under the hood it's a plugin framework. **Storage clients** define where data comes
from (a REST endpoint, a database, and others via add-on plugins). **Field mappers**
and **property mappers** describe how each external field becomes a Drupal field —
the module ships simple and JSONPath mappers for pulling values out of API
responses. Because everything is a plugin, the system is extensible for unusual
sources and shapes of data.

A family of submodules extends it: **xnttsql** adds a SQL database storage client,
**xntt_views** provides native Views support, **xntt_file_field** adds File/Image
field support, **external_entities_pathauto** brings Pathauto integration,
**external_entities_drupalorg** is a ready-made example against the Drupal.org API,
and **xntt_example_d7import** is a worked import example.

Because this module reaches out to remote systems, treat it as an integration with
real security implications: any credentials the source needs are secrets (store
them via the Key module or environment variables, never in exported config), prefer
HTTPS, make sure the source is trusted, and — if a source URL is ever
request-derived — be mindful of server-side request forgery (SSRF). Also make sure
external-entity access is configured so sensitive remote data isn't exposed more
broadly than you intend.

> **Version note:** this is release **3.0.0-rc2** (a release candidate). Version 3
> introduces API changes versus version 2 but adds native Views and File/Image
> support.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — define an external entity type, choose
   a storage client, and map fields.

## Where it lives in the admin menu

You build external entity types under **Structure → External entity types**,
guarded by the **`administer external entity types`** permission. Once a type is
defined, its records appear and behave like entities throughout the site (Views,
references, view modes).
