<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Access Conditions lets site builders define reusable "access models" — named sets of core Condition plugins combined with AND/OR logic — and evaluate them anywhere via an `access_conditions.access_checker` service.

Use it when you want centrally-managed, reusable visibility rules (by role, path, request, custom context) that other modules or field groups can reference, instead of duplicating condition config on every block/field.

- Ships an `access_model` configuration entity managed at `/admin/config/system/access-models`.
- Each model holds one or more Condition plugin instances with a logic operator.
- Provides `AccessChecker::checkAccess()` returning TRUE/FALSE with cacheability metadata.
- Honors a `bypass access conditions access` permission.
- Submodule `access_conditions_entity` adds an `access_model` reference field type/widget/formatter.

---

Install and configure:

- Enable `drush en access_conditions` (and `access_conditions_entity` for the field type).
- Grant `administer access models` to trusted site builders only; `bypass access conditions access` to roles that should ignore all models.
- Create a model at `/admin/config/system/access-models`.
- Add conditions to the model (add/edit/delete condition routes are permission-gated).
- Reference the model from a consumer (field group, commerce pane, custom code).

---

- Define an access model, then add core Condition plugins (Request path, User role, etc.).
- Choose the access logic (`and`/`or`) via `getAccessLogic()`.
- Call `\Drupal::service('access_conditions.access_checker')->checkAccess($model)` to evaluate.
- The checker applies runtime context mappings before resolving conditions.
- `bypass access conditions access` short-circuits evaluation to TRUE.
- Cache contexts/tags/max-age are collected on the checker and should be merged into consumer render arrays.
- Consumers hide content by setting `#access = FALSE` when no model grants access.
- Models are exportable config, so rules move cleanly between environments.
- The submodule's `AccessModelItem` field type stores references to models on entities.
- Use the autocomplete widget to attach models to entity displays.
- Multiple models can be attached; access is granted if any one passes (OR across models in the consumers).
- Authored by pcambra/facine; conditions reuse core's `ConditionAccessResolverTrait`.
- Pair with `access_conditions_commerce` for checkout-pane visibility.
- Pair with `access_conditions_field_group` for field-group visibility.
- Keep condition config minimal for cacheability.
- Test models as anonymous and authenticated users.
