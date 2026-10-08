<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VBO Media Export — agent index

Adds a **Views Bulk Operations action to bulk-download media as a ZIP** (export/back up selected media).
Depends on core `file`, `views_bulk_operations`. Version **1.0.1**. Core `^10||^11`.

Content/media bulk-op — export bundles underlying files; ensure the action is available only to users who may
access the media (runs in the View/user's context). No access role of its own beyond VBO/View access.
