<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Devel (droost_devel) — agent index

Small optional submodule of **Droost**: exposes `devel_generate` as one gated MCP tool. Version
1.0.0-rc1 (dir `1.0.x`). Core `^10.3 || ^11 || ^12`, PHP `^8.3`. Depends on `droost` and
`devel_generate`. Local development only.

## MCP tool

- **`droost_generate`** (`src/Plugin/Tool/Generate.php`, extends `DestructiveToolBase`,
  `readOnly: FALSE`) — generates test data via Devel Generate. Args: `type`
  (`content|user|term|vocabulary|menu|media`), `num` (how many), `kill` (delete existing first),
  `bundles` (node types for content; the vocabulary — required — for term; media types for media,
  default all). **Gated** by `allow_entity_write` (or master `allow_destructive`) and **CLI-only**
  (`requireCliTransport()`); disabled by default.

No routes, permissions, config, or services beyond `Hook/DroostDevelHooks`.

## Solution doc

- The generate tool, its arguments and gating → [tools/generate.md](tools/generate.md)
