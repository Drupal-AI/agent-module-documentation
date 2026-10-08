<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy term locks — agent index

Marks taxonomy terms as **locked** so only holders of **bypass taxonomy term lock** can edit/delete them. Version **1.0.0**. Core `^8 || ^9 || ^10`.

Permissions: `set taxonomy term lock`, `bypass taxonomy term lock` (restricted). Enforcement is **form-level only** (hook_form_alter + 403 in `TaxonomyTermLocksService::blockUnauthorizedAccess`); there is **no hook_entity_access**, so JSON:API/REST/VBO/programmatic term edits bypass the lock. Editorial guardrail, not a hard access boundary.
