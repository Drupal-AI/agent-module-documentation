<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Entity Print (eca_entity_print) — agent index

Bridges **ECA** (Event-Condition-Action automation) to **Entity Print**. Provides **two configurable ECA
action plugins** that render an entity or a View to a PDF/document via Entity Print's print builder and save the
result as a **permanent private `file` entity**, exposing it to the model through a token. No routes,
permissions, services, config forms, hooks, or Drush of its own.

- Package `ECA`. License GPL-2.0-or-later. Version **2.0.1**. Core `^10.4 || ^11`, PHP `>=8.1`.
- Depends on modules **`eca`** (`^2 || ^3`) and **`entity_print`** (`^2`). Needs a working Entity Print
  engine (e.g. Dompdf/wkhtmltopdf) configured.

## Solution docs

- **The two action plugins — ids, config fields, execution flow, tokens, access, services** →
  [plugins/actions.md](plugins/actions.md)

## What it actually provides (from source)

- `PrintFileFromEntity` — action id **`eca_entity_print_print_file_from_entity`** (`type: entity`), label
  *"Print file document from entity"*, in `src/Plugin/Action/PrintFileFromEntity.php`. Extends ECA's
  `ConfigurableActionBase`.
- `PrintFileFromView` — action id **`eca_entity_print_print_file_from_view`** (no entity type), label
  *"Print file document from views output"*, in `src/Plugin/Action/PrintFileFromView.php`. **Subclasses**
  `PrintFileFromEntity` and reuses its `doExecute()`.
- Config schema for both action configs in `config/schema/eca_entity_print.schema.yml`
  (`action.configuration.eca_entity_print_print_file_from_entity` and `…_from_view`).
- Uses Entity Print services `entity_print.print_builder`, `plugin.manager.entity_print.print_engine`,
  `plugin.manager.entity_print.export_type`, plus core `access_manager` and ECA's token service.
