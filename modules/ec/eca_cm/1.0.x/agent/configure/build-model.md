<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Building a model (routes & workflow)

All routes live under `/admin/config/workflow/eca/` and require the **`administer eca`**
permission (defined by ECA, not eca_cm). Controllers are on `CoreModeller`.

## Routes

| Route | Path | Purpose |
|---|---|---|
| `eca_cm.add` | `/admin/config/workflow/eca/add/core` | Create a new classic (core-modeller) model. |
| `eca_cm.event.add` | `…/eca/{eca}/event/add/{eca_event_plugin}` | Add an event to a model. |
| `eca_cm.event.edit` | `…/eca/{eca}/event/{eca_event_id}/edit` | Edit an event. |
| `eca_cm.event.delete` | `…/eca/{eca}/event/{eca_event_id}/delete` | Delete an event. |
| `eca_cm.condition.add/edit/delete` | `…/eca/{eca}/condition/…` | Manage conditions. |
| `eca_cm.action.add/edit/delete` | `…/eca/{eca}/action/…` | Manage actions. |

The main ECA collection (`/admin/config/workflow/eca`) lists models (ECA's `EcaListForm`);
eca_cm adds the "Add new Classic model" local action and per-component add links via its
menu/local-action derivers.

## Workflow (from README)

1. **Create the model** at `/admin/config/workflow/eca/add/core` (gives an `eca.eca.<id>` entity
   with `modeller: core`).
2. **Add an event** — the trigger (e.g. an entity is saved).
3. **Add an action** (and optionally a **condition**).
4. **Connect components**: open the event and add the action/condition as a **successor** at the
   bottom of its form. Successor wiring is what defines the execution chain — add each further
   action as a successor of the preceding component.
5. **Save** to persist. Nothing is applied until you save.

## Enable / disable a model

Models are config entities with a `status` flag; toggle from the ECA list, or:

```bash
drush php:eval '$e=\Drupal::entityTypeManager()->getStorage("eca")->load("my_model"); $e->setStatus(TRUE)->save();'
```

## Optional integrations

- **Select2** (`drupal/select2`): upgrades the event/condition/action plugin selectors.
- **Token** (`drupal/token`): adds a token browser when configuring components.

> eca_cm has no settings page (`configure = null`) and adds no config of its own — the only
> persistent artifacts are the ECA `eca.eca.*` model entities you build.
