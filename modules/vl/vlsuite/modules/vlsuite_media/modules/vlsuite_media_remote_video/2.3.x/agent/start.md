<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Media: Remote Video (vlsuite_media_remote_video) — agent index

Nested submodule of **vlsuite_media**. **Provider-hosted video** media type, on core's oEmbed
handling. Version **2.3.3**. Core `^10.3 || ^11`.

**Core's oEmbed provider allow-list is the security boundary** — it decides which third parties may
be embedded and whose scripts may run in a page. Review it rather than inheriting it.

**Privacy carries to every component rendering it:** the provider's script and cookies load for
every visitor reaching the page, before any interaction. EU-facing sites need consent gating — see
`vlsuite_block_remote_video`, `usercentrics`, `consent_mode`.