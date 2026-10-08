# AI Content Hub — manual setup guide

**AI Content Hub** (`ai_content_hub`) is a content-authoring **engine**, not an AI
client. It does one job well: it reads an existing "reference" entity's field
structure and current values into structured JSON that an AI can author against,
and then it takes a returned JSON payload and hydrates it back into Drupal — as a
validated preview, a brand-new entity, or an overwrite of a named entity. The base
module ships **no AI of its own**: no API key, no prompt, no model choice, and no
dependency on the AI module. The actual writing happens outside the site.

Hydration has three modes. **Preview** maps the payload onto a throwaway copy of
the reference entity and renders a full themed HTML page — nothing is saved.
**Create** builds and saves a new entity of a bundle you name. **Override** maps
the payload onto an entity you name and saves it, keeping its id, author, and
publication status while replacing (not merging) field values. There is no delete
path, and every mode validates the payload against the target's fields first — a
payload that does not fit raises per-field errors and writes nothing.

Security is **deliberately the caller's responsibility**, and this is documented,
not accidental. On its own the engine checks no permissions, does not look at the
current user, and does not enforce field-level access — a payload can write any
field the target has. If you wire the raw engine into your own code, you must
authorize the request yourself and always take the bundle-to-create from a trusted
route, form, or config, never from the payload. For a ready-made experience, the
**AI Content Hub Preview** submodule adds a UI plus real permissions and
entity-access checks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   engine, and choose the submodule that matches how you'll drive it.

## How to use it

The base module is a **library** — it has no routes, forms, or permissions, so
enabling it alone does nothing visible. You use it in one of three ways:

- **Enable AI Content Hub Preview** (`ai_content_hub_preview`) for a UI with
  access control. It adds preview routes gated by `generate` / `publish` /
  `delete ai content hub previews` permissions and entity-access checks. Previews
  can be stored privately per account or as shareable entities with their own URL,
  and published into a real permanent node. Exposing a preview to anonymous
  visitors requires the separate `make ai content hub previews public` permission.
- **Enable AI Content Hub MCP** (`ai_content_hub_mcp`) to let an MCP client (such
  as Claude Code) do the authoring against the extracted JSON.
- **Write your own consumer** against the engine — in which case re-read the
  security contract above: you own authorization and the choice of target bundle.
