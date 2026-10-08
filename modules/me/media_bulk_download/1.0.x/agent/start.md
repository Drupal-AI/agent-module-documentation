<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Bulk Download — agent index

**Bulk-downloads selected media as a single archive**. Depends on core `media`. Provides the `download bulk
media` permission. Version **1.0.0**. Core `^10.3||^11`.

Media — download endpoint serves the file from the **user's own private tempstore** (not a request-supplied id
→ no id-tampering), deletes after send. Grant the permission to trusted roles. No broader access role.
