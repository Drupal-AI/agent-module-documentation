# Swagger UI Field Formatter — manual setup guide

**Swagger UI Field Formatter** (`swagger_ui_formatter`) renders an OpenAPI / Swagger
specification (a JSON or YAML file) as an interactive
[Swagger UI](https://swagger.io/tools/swagger-ui/) API-documentation widget right on
your Drupal pages. Instead of linking to a raw spec file, visitors get browsable,
expandable endpoint docs — and, optionally, a live **"Try it out"** console for
selected HTTP methods.

It provides two field formatters, both labelled **Swagger UI**: one for **File**
fields (upload the spec as a managed file) and one for **Link** fields (point at a
spec hosted elsewhere by URL). You choose either on an entity's **Manage display**
tab, which makes it easy to publish versioned API docs as nodes or media and swap
specs without code changes — a ready-made developer portal on a Drupal site.

Per display you can control the spec **validator** (none, swagger.io's online
validator, or a custom one), the initial **doc expansion**, whether the **top bar**
shows, whether tags are **sorted by name**, and which HTTP methods get the "Try it
out" feature (trim it to GET only, or disable it entirely while still showing the
docs).

> **One setup prerequisite:** the Swagger UI JavaScript library is **not bundled**
> in the rendered output. You must make it available — either by installing a
> downloaded copy under `libraries/swagger-ui` (the default), or by switching to the
> npm assets bundled inside the module. The [Installation](installation/index.md)
> guide covers both.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and provide the Swagger UI JavaScript library.
2. [Configuration](configuration/index.md) — apply a Swagger UI formatter to a File
   or Link field and walk through every display setting.

## Where it lives in the admin menu

There is **no dedicated settings page**. You select the **Swagger UI** formatter per
field on an entity's **Manage display** tab, for example
**Structure → Content types → API → Manage display**. The detected library version
and path are reported on the **Status report** (**Reports → Status report**).
