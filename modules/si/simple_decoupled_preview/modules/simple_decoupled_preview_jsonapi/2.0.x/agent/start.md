<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Decoupled Preview JSON:API (simple_decoupled_preview_jsonapi) — agent index

Submodule of **simple_decoupled_preview**. Exposes node previews on JSON:API.
Version **2.0.1**. Core `^10.2 || ^11`. Depends on `node`, `jsonapi` (both core).

A **hard dependency** of the parent — enabled with it, not chosen separately.

**Why it exists:** JSON:API serves *saved* entities; a preview is not one. This makes the
in-progress node fetchable so the front end's preview route can request it with the same client,
includes and field mapping it uses for published content.

**Primary review item for any decoupled preview deployment, and it lives here:** this endpoint
serves **unpublished, unsaved** content by design. The front end's credentials must be scoped and
secret, and the preview resource's access must be inspected rather than assumed to follow
JSON:API's normal entity access.