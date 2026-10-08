# JSLD (JSON-LD) — manual setup guide

**JSLD** (`jsld`) is a developer‑oriented API for adding JSON‑LD structured data
(schema.org markup) to your site. Search engines use JSON‑LD to understand your
content and to power rich results — star ratings, event dates, organization
details, and so on. JSLD gives you a clean, organized way to attach that markup
where it belongs.

It's important to set expectations up front: JSLD does nothing on its own. It's a
framework, not a point‑and‑click configuration tool — it helps developers organize
and emit JSON‑LD data through a **plugin system**. You write small plugin classes
in a custom module, and JSLD takes care of placing their output on the right
pages.

There are two kinds of plugin:

- **Entity plugins** attach to a specific entity type and its bundle / view‑mode
  combinations. Use these when you need JSON‑LD on pages where a specific entity
  is presented — for example, an "Article" or a "News" node.
- **Path plugins** attach to specific pages by URL path (exact paths or patterns
  like `/info/*`). Use these when the markup belongs to a page rather than an
  entity — for example, an Organization block on your `/about` page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form.
Because JSLD is a developer API, the "setup" is writing plugins in your own custom
module, outlined in "How to use it" below.

## How to use it

The work happens in code, in a custom module:

1. **Choose the plugin type.** Use a `@JsldEntity` plugin to target an entity
   type/bundle/view‑mode, or a `@JsldPath` plugin to target one or more URL paths.
2. **Create the plugin class** in your custom module (for example under
   `src/Plugin/JsldEntity/` or `src/Plugin/JsldPath/`), with the appropriate
   annotation identifying where it applies.
3. **Build and return your JSON‑LD data** from the plugin. JSLD emits it into the
   page markup on the pages the annotation matched.

Refer to the module's own documentation and the examples in its `README` for the
exact annotation properties and method signatures.
