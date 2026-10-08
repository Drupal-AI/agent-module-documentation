<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Files Handler — agent index

Ensures **orphaned files are deleted when a media entity is updated** (remove the replaced/old file vs
leaving orphans — tidy storage). Depends on core `file`, `media`. Version **1.0.x** (dev). Core
`^9.3||^10||^11`.

Media/file-lifecycle (positive housekeeping) — removes the prior file on update (confirm that's desired for
shared files). No access role.
