<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `feature_toggle.permissions.yml` (both marked `restrict access: TRUE`).

| Permission | Gates |
|---|---|
| `administer feature_toggle` | Full control: add, edit, and delete features, plus toggle their status. Required for the add/edit/delete routes; on the toggle list it also enables the per-row Edit/Delete operations. |
| `modify feature_toggle status` | Toggle existing features on/off only (no create/edit/delete). |

## How the routes use them

- `/admin/config/system/feature_toggle` (the toggle list, `configure` route) requires
  `administer feature_toggle` **OR** `modify feature_toggle status`
  (routing requirement `administer feature_toggle+modify feature_toggle status`).
- `/admin/config/system/feature_toggle/add` requires `administer feature_toggle`.
- `…/{feature_name}/edit` and `…/{feature_name}/delete` use custom access
  (`FeatureForm::access` / `FeatureDeleteForm::access`), which also require
  `administer feature_toggle`.

Typical setup: give trusted editors `modify feature_toggle status` so they can flip features on the
list page, and reserve `administer feature_toggle` for site admins who define the feature set.

Note: these gate **administration** of the toggles. Gating actual site behaviour on a feature is
done with the Condition/Views-access/route `_feature_toggle`/Twig integrations — see
[api/integrations.md](../api/integrations.md).
