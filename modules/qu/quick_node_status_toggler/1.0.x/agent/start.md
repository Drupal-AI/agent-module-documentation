<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Quick Node Status Toggler — agent index

**Adds a toggle switch in the content listing to publish/unpublish nodes** without opening them. Depends on core
`node`, `views`. Version **1.0.1**. Core `^9||^10||^11`.

Content-administration — **positive**: the route requires `administer nodes` and it **checks `$node->access('update')`**
before `setPublished()`+`save()` (can't toggle nodes you can't update). No broader access role.
