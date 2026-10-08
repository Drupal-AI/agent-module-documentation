<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Default Content Access (default_content_access) — agent index

Add-on that makes **Default Content** carry a node's **Content Access** per-node grant settings when
that node is exported or imported. Delivered entirely through two Drush commands — no UI, no config,
no permissions, no runtime hooks. Version **2.1.0**, core `^10 || ^11`, PHP `>=8.1`.

## Dependencies
- `default_content:default_content` (`^2.0`) — provides the base export/import Drush commands and exporter service.
- `content_access:content_access` (`^2.0`) — owns the `content_access` table this module reads/writes.

## What it provides
- **Drush commands** (`src/Drush/Commands/DefaultContentAccessCommands.php`, extends `default_content`'s
  `DefaultContentCommands`):
  - `default-content-access:export-module` (alias `dcaem`) — export a module's nodes + their access grants.
  - `default-content-access:import-module` (alias `dcaim`) — import them and `node_access_rebuild()`.
- No `*.services.yml`, `*.routing.yml`, `*.permissions.yml`, `*.install`, `config/**` or `*.module` file —
  command discovery is via Drush `#[CLI\Command]` attributes and the class `create()` factory.

## It does NOT decide access
This module only serializes/deserializes Content Access's stored settings. Access enforcement is entirely
Content Access + core node grants; import replaces `content_access` rows and rebuilds grants.

## Solution docs
- [Drush export/import commands](drush/export-import.md) — command names, arguments, file layout, data flow.
