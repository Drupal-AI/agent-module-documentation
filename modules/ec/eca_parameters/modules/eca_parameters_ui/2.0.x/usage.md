<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Parameters UI is the optional submodule of ECA Parameters that adds a web admin screen for managing the `eca` parameters collection — the parameters that ECA models read and write — at `/admin/config/workflow/eca/parameters`.

---

The submodule contains no PHP of its own: it wires the `parameters_ui` module's collection controller to an ECA-branded route and menu tab. Its route `entity.eca.parameters` (`eca_parameters_ui.routing.yml`) maps `/admin/config/workflow/eca/parameters` to `parameters_ui`'s `ParametersUiController::parametersCollectionForm` / `parametersCollectionTitle`, hard-coded to the `parameters_collection_id: eca` collection, guarded by the module's own permission **`administer eca parameters`** (declared `restrict access: true` in `eca_parameters_ui.permissions.yml`) and flagged `_parameters_ui: true`. A local task (`eca_parameters_ui.links.task.yml`) adds a **"Parameters"** tab (weight 150) under the ECA collection admin base route `entity.eca.collection`, so the screen appears alongside the other ECA administration tabs at `/admin/config/workflow/eca`. It depends on `eca_parameters`, `eca_ui (^2)` and `parameters_ui`; enabling it therefore pulls in the ECA UI and the Parameters UI. This is a purely administrative surface for trusted users who administer ECA.

---

- Manage the `eca` parameters collection through a web form instead of editing configuration by hand.
- Add, edit or remove ECA parameters at `/admin/config/workflow/eca/parameters`.
- Reach parameter management as a **Parameters** tab from the ECA admin area (`/admin/config/workflow/eca`).
- Define parameters that ECA *Get parameter* / *Set parameter* actions and conditions will read.
- Give a specific role the `administer eca parameters` permission to delegate parameter management.
- Review the current ECA parameters and their values in one place.
- Seed default parameter values before building ECA models that consume them.
- Keep ECA parameter management separate from the general Parameters (`global`) collection UI.
- Provide a discoverable UI for site builders who prefer not to use Drush or config sync.
- Enable only on sites that need human-managed ECA parameters, keeping the base module UI-free.
