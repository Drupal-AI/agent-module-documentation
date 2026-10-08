<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Git Info — agent index

Exposes the deployed code's **Git branch/commit** via a **block** (`InfoBlock`) + **tokens** (reads `.git`
via `eiriksm/git-info` — no shell/user input, no injection). Provides permissions. Version **2.0.4**. Core
`^8||^9||^10||^11`.

**Security caveat: do NOT expose the commit/branch publicly** — the commit hash is version-fingerprinting
info that aids version-targeted attacks. Keep the block/tokens on admin/internal pages (or gate by
permission). No access role of its own.
