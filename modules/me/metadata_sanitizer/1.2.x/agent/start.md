<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Metadata Sanitizer — agent index

**Strips metadata (EXIF, GPS, device, author) from uploaded files using exiftool** — prevents hidden-data PII
leaks from user uploads. Depends on core `file`. Submodules: `metadata_sanitizer_ai_agents`,
`metadata_sanitizer_tool_api`. Drush + permissions. Version **1.2.0**. Core `^10.3||^11`.

**Privacy/security-positive**, implemented **safely**: invokes exiftool via Symfony `Process` with **array
args** (`['exiftool','-all=',…,$path]`) — no shell interpretation, **no command injection** from paths
(verified). Requires the **exiftool binary**; configurable preserve-tags. No access role beyond permission.
