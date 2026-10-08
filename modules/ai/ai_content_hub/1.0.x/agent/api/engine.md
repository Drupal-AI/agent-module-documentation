<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Hub — engine contract

The base module answers "is this content valid, and what does it look like?" — never "who is asking?".

**Extract** — read a reference entity's fields and current values into JSON (read-only).

**Hydrate**:
- `preview` — map payload onto a discarded copy of the reference entity, render a complete themed HTML document; nothing is saved.
- `create` — build a new entity of the bundle you name, map payload, save. One new entity.
- `override` — map payload onto an entity you name and save; id/author/publication status preserved; existing field values replaced, never merged.

No delete path exists. Every hydration validates first; a non-fitting payload raises an error carrying each violation and field, and writes nothing.

**Caller responsibilities (enforced nowhere in the engine):**
- Access — no path checks permission or current user. Authorize before calling.
- Publication status — engine never sets it.
- Bundle to create — take from a trusted route/form/config, never the payload.
- Field-level access — not enforced; a payload can write any field the target has.

For a ready-made UI with permissions and entity-access, enable `ai_content_hub_preview`; for AI authoring, enable `ai_content_hub_mcp`.
