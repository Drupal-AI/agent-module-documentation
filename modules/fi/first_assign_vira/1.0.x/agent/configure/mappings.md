<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Auto Term — mappings & batch

## Settings
`/admin/config/system/eat` (`EatAdminSettingsForm`, `administer site configuration`). Stores `eat_item` in `eat.settings`: a list of items each with `#entity_type`, `#bundle`, and `#vocab` (one or more vocabulary ids).

## Runtime behaviour
`eat_form_alter()` matches `"{entity_type}_{bundle}_form"` / `..._edit_form` and appends `eat_form_submit`:
- **default op:** `Eat::addTerm($title,$entity_id,$vocab)` creates a term and inserts an `eat` row (etid/tid/vid). If a term with the same title already exists (`Eat::checkIfExists`), the existing tid is linked instead.
- **edit op:** the linked term's name is updated to the entity's new title.

## Bulk backfill
`/admin/config/system/eat/batch` (`BatchImport`) → `Eat::matchupEntitiesToSet()` creates terms for content that predates the config.
- Route permission is `access content` — effectively anonymous. It performs a data mutation (term creation) on submit; tighten to an admin permission if that matters for your site.

## Views
`EatFilters` (`Plugin/views/argument_default`) supplies the linked term id as a default contextual-filter argument.
