<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permanent Media File Delete — agent index

**Permanently deletes the underlying file when a media item's file is replaced/removed** (extends Media File
Delete; avoid orphans). Depends on core `file`, `media_file_delete`. Version **1.0.0**. Core `^10||^11`.

Media/file-management — runs on media edit ops; **permanently deletes** the old file (irreversible; relies on
Media File Delete usage checks — beware shared files). No access role.
