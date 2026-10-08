<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Devel — `droost_generate`

One MCP tool, `src/Plugin/Tool/Generate.php` (id `droost_generate`, extends
`Drupal\droost\Plugin\Tool\DestructiveToolBase`).

## Behaviour

Generates test data via `devel_generate`. Arguments:

- **`type`** — one of `content`, `user`, `term`, `vocabulary`, `menu`, `media`.
- **`num`** — how many to create.
- **`kill`** — delete existing items first.
- **`bundles`** — for `content`: the node types; for `term`: the vocabulary (**required**); for
  `media`: the media types (default all).

Returns the standard `{success, message, data}` envelope.

## Gating

As a `DestructiveToolBase`, `execute()` opens with
`requireCliTransport() ?? gate('allow_entity_write')`:

- **Disabled by default.** Requires `droost.settings.allow_entity_write` (or the master
  `allow_destructive`, which arms every write category).
- **CLI/STDIO only** — refused over the HTTP `/_mcp` endpoint even if the flag is on.

The tool description states the requirement explicitly ("Disabled by default; requires
droost.settings.allow_destructive"). This is the same gate model as the base module's write tools —
see the base `agent/tools/write-tools.md`.

## No other surface

`droost_devel` ships no routes, permissions, config, schema, or extra services — only this tool plus
`Hook/DroostDevelHooks`. It hard-depends on `devel_generate`.
