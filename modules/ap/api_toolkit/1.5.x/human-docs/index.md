# API Toolkit — manual setup guide

**API Toolkit** (`api_toolkit`) is a small developer framework for building your
own API endpoints in Drupal. Instead of hand-writing routing and response
serialization every time, it gives you a structured way to define routes that
return serialized (JSON) responses. It builds on Drupal core's Serialization
module and ships an examples submodule so you can see the pattern in action.

This is developer plumbing, not a ready-made feature — there is no settings page
and nothing to click. You enable it, then write code (or copy the examples) to
define your endpoints. If you just want a general-purpose REST/JSON:API surface,
core's own web-services modules may be a better fit; API Toolkit is for
purpose-built, custom endpoints.

**Important security note:** the toolkit gives you the plumbing, not the
authorization. **You own the access control** for every endpoint you build. Each
endpoint must define its own `_access`/`_permission` requirement and check
entity/field access before returning data. The module has no access-control role
of its own, so an endpoint you forget to gate is an endpoint anyone can call.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the examples submodule.

## How to use it

Once enabled, define your endpoints in a custom module using the toolkit's
helpers, returning serialized responses in the structured form it provides. Turn
on the **API Toolkit Examples** (`api_toolkit_examples`) submodule to study
working sample endpoints, then remove it once you no longer need the reference.

Because there is no configuration form, the only setup steps are installation and
whatever code you write on top of it. Whenever you add an endpoint, add its access
check in the same breath — that responsibility sits entirely with you.
