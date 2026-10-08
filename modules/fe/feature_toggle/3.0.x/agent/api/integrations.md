<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consume a feature flag

Ways the module lets you gate things on a feature's status.

## Block visibility — Condition plugin `feature_toggle`

`Drupal\feature_toggle\Plugin\Condition\FeatureToggle` (`#[Condition(id: "feature_toggle")]`).
On a block's *Visibility* tab, "Feature Toggle" shows a checkbox list of features. Config:
`features` (array of selected feature names). Evaluation:

- No features selected and not negated → **TRUE** (always).
- Otherwise TRUE if **any** selected feature is enabled (`array_intersect` with enabled features).
- Adds cache tags `feature_toggle:<name>` for each selected feature.

## Views access plugins

Add under a view display's *Access* setting (options: `feature_name` + expected `status`):

| Plugin id | Title | Grants access when |
|---|---|---|
| `feature_toggle_feature` | Feature (Unrestricted) | the chosen feature matches the chosen status |
| `feature_toggle_perm_feature` | Permission + Feature | user has the permission **and** feature matches |
| `feature_toggle_role_feature` | Role + Feature | user has a role **and** feature matches |

(`PermissionFeature` extends core `Permission`; `RoleFeature` extends core `Role`; both mix in
`ViewsFeatureAccessTrait`.)

## Route access requirement `_feature_toggle`

Guard any route by adding the requirement (access checker `access_check.feature_toggle`, tag
`_feature_toggle`):

```yaml
my_module.secret:
  path: '/secret'
  defaults:
    _controller: '\Drupal\my_module\Controller\Secret::view'
    _title: 'Secret'
  requirements:
    _feature_toggle: 'beta_checkout.1'   # 'feature.value'; value optional, defaults to 1
```

`FeatureToggleAccessCheck::access()` parses `feature.value` (value defaults to `1`) and allows the
route only when `getStatus(feature) == value`, adding the `feature_toggle:<feature>` cache tag.

## Twig function

```twig
{% if feature_toggle_status('beta_checkout') %}
  {# new UI #}
{% endif %}
```

`feature_toggle_status(string $name): bool` (from `Template\TwigExtension`).

## JavaScript / drupalSettings

`hook_page_attachments()` (`FeatureToggleHooks::pageAttachments()`) puts the list of enabled
feature names on every page:

```js
const enabled = drupalSettings.feature_toggle.enabled; // e.g. ['beta_checkout']
```
