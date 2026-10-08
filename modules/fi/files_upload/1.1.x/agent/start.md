<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Files Upload — agent index

Provides a **file-upload system/UI** for uploading and managing files. Version **1.1.1**. Core
`^8.9||^9||^10||^11`.

**Security (upload):** safety rests on **server-side validation** — restrict allowed **extensions**, size
limits, store uploads non-web-executable (private FS for sensitive files), restrict who can upload. No access
role beyond that.
