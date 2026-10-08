<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Block: Local Video (vlsuite_block_local_video) — agent index

Nested submodule of **vlsuite_block**. **Self-hosted video** component, using `vlsuite_media`'s
local video type. Version **2.3.3**. Core `^10.3 || ^11`.

Right for short clips where a third-party player is unacceptable (no tracking, no branding, no
external requests). Wrong for long video or large audiences — serving video well needs adaptive
bitrate the site probably lacks.

**Three things to plan:** autoplay must be **muted** (browsers block unmuted autoplay anyway);
**captions are a requirement**, not an enhancement; and check actual **file sizes** — a 40MB
background loop is a slow page for everyone.