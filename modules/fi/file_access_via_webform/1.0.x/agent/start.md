<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Access via Webform — agent index

A **token-gated file download tied to a webform**. Depends on `webform`, core `file`. Version **1.0.3**. Core
`^10||^11.0`.

Forms/file-delivery — **sound (defense-in-depth)**: access requires **both** a file-id-bound token AND the user's
core `$file->access('download'/'view')` (AND-combined — token can't grant beyond core access). Use `private://`
for restricted files. No broader access role.
