<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Moderation State Sync — agent index

Syncs **Content Moderation state between translations** of a node (keep draft/published/archived aligned across
languages). Depends on core `content_moderation`. Version **8.x-1.0-alpha5**. Core `^8||^9||^10||^11`.

Editorial-workflow/multilingual — moderation state governs publish/visibility, so syncing publishes/unpublishes
translations together (intended); follows Content Moderation access; no access role.
