<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Usage Addons (entity_usage_addons) — agent index

Add-on to **Entity Usage**. Surfaces its tracking data through two integer field formatters plus one
helper service. Installed version **2.0.2**, version dir `2.0.x`. Core `^10 || ^11`.
Depends on `entity_usage:entity_usage`. License GPL-2.0-or-later.

No routes, no `*.permissions.yml`, no config page, no config schema. README is literally `# todo`.

## What it provides
- **Service** `entity_usage_addons.usage` → `Drupal\entity_usage_addons\Service\Usage`
  (`src/Service/Usage.php`). Args: `@entity_usage.usage`, `@entity_type.manager`,
  `@logger.factory`, `@current_user`. Methods: `getUsage`, `getUsageTotal`, `linkedUsage`,
  `detailedUsage`, and protected `getSourceEntityLink`.
- **Field formatter** `entity_usage_addons_formatter` — label "Entity Usage - Detailed"
  (`EntityUsageAddonsFormatter`). Lists referencing entities; collapses to a linked count above a
  configurable threshold. Settings: `max_expanded`, `show_fields` (id/entity/status/type),
  `show_header`.
- **Field formatter** `entity_usage_addons_formatter_count` — label "Entity Usage - Count"
  (`EntityUsageAddonsFormatterCount`). Always renders a linked total; no settings.

Both formatters target `integer` field types and extend `BaseFieldFileFormatterBase`; place them on
an entity's **ID** field via Manage display, or on an ID field in a View.

## Operate it
- Enable: `drush en entity_usage_addons` (pulls in `entity_usage`).
- Configure what is tracked in **Entity Usage**, not here. An empty list means "not tracked", not
  "unused".
- The count link targets route `entity.{entity_type}.entity_usage` (provided by Entity Usage) and is
  only rendered for users with the `access entity usage statistics` permission.

## Solution docs
- [Field formatters & the Usage service](fields/formatters.md) — settings, thresholds, access
  behaviour, and how each method builds its output.
