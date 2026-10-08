# Entity Blueprint — manual setup guide

**Entity Blueprint** (`entity_blueprint`) is a **developer / AI-integration** module
that provides a clean, bidirectional JSON interface to Drupal entities. It serializes
any fieldable entity — nodes, blocks, paragraphs, even Layout Builder pages with
nested paragraphs and inline blocks — into JSON that an AI (or any external system)
can read and modify, then deserializes that JSON back into a valid Drupal entity with
full validation and structured error feedback.

The problem it solves is that Drupal's entity, field, and plugin APIs are too deep
and framework-specific for a language model to drive directly, while REST / JSON:API
serialize entities faithfully but offer no simplified, writable format and no
structured validation suitable for AI round-trips. Attempting direct manipulation
risks silently losing data in Layout Builder's opaque settings. Entity Blueprint sits
in the middle as the "entity abstraction layer": a stable JSON contract that other
systems — notably the AI-powered page building in Plus Suite — build on top of.

Its notable capabilities include full serialization with three modes (**full** field
values, **summary** tree-only structure, and **component** for a single UUID with
context), two-phase deserialization validation (cheap structural checks first, then
semantic checks of permissions, constraints, and reference resolution), targeted CRUD
on individual components, atomic batch operations with rollback, JSON schema
generation so an agent can learn an entity's shape before acting, opaque-data
protection that preserves Layout Builder internals by default, multilingual support,
and extensible field handlers registered as tagged services. It also has a "skills"
and context/guidance system for feeding AI on-demand, per-entity-type instructions.

The **base module is a pure data layer** — it has no configuration UI of its own. A
set of **optional, currently experimental submodules** build on top of it, most
notably **Entity Blueprint AI** (`entity_blueprint_ai`), which exposes all the
operations as function-call tools (each prefixed `eb_`) for the Drupal AI module and
adds its own admin settings form; others add config-entity support. The base module
works on Drupal 10.3–11 and has no module dependencies.

A data-handling note, since this is built for AI workflows: sending entity JSON to an
AI provider is **egress of your entity content**, which can be sensitive, and any
writes back from AI-produced JSON should respect entity/field access and validation —
never blindly apply AI output. The module has no access-control role itself; the
two-phase validation is there precisely so consumers can check permissions and
constraints before saving.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for the base module — it is a data/serialization
layer used by code and by its optional submodules. If you want AI tooling and its
settings form, enable the experimental **Entity Blueprint AI** submodule (see
Installation).

## Where it lives in the admin menu

The base module adds no admin page. Configuration surfaces only appear if you enable
optional submodules — for example the **Entity Blueprint AI** submodule adds a
settings form for choosing which entity types and bundles are exposed to AI tools.
