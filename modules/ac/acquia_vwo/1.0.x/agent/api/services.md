# Services, script injection & hooks (api)

No public API for other modules to call — the surface is five internal services wired in
`acquia_vwo.services.yml` plus four module hooks in `acquia_vwo.module`. There is no controller, no
route callback beyond the config forms, and no server-side HTTP call (all network traffic to VWO
happens client-side from the injected JavaScript).

## Services

| Service id | Class | Role |
|---|---|---|
| `acquia_vwo.service.context.page_context` | `Service\Context\PageContext` | Builds and attaches the VWO smart-code + `window.VWO.data.acquia` payload; adds config cache contexts/tags. Implements `CacheableDependencyInterface`. |
| `acquia_vwo.service.context.visibility_context` | `Service\Context\VisibilityContext` | `shouldAttach()` decides whether the script is added on the current request. |
| `acquia_vwo.service.user.user_control` | `Service\User\UserControl` | User edit-form checkbox, per-user opt storage, and the `acquiaVwoUserOptOut()` gate script. |
| `acquia_vwo.service.helper.path_matcher` | `Service\Helper\PathMatcher` | Case-insensitive path/alias matching helper (used for path-based visibility). |
| `acquia_vwo.service.condition.condition_resolver` | `Service\Condition\ConditionResolver` | Instantiates and evaluates core condition plugins for visibility. |

## Where the inline script is built

`PageContext::getJavaScriptTagRenderArray()` (`src/Service/Context/PageContext.php:192`):

1. Reads the body of the bundled template `js/vwo.js` with `file_get_contents()`.
2. Builds an inline snippet interpolating `account_id` (from `acquia_vwo.settings:id`),
   `version=2.1`, `settings_tolerance` (from `loading.timeout`) and the template body.
3. Appends a second statement setting `window.VWO.data.acquia = <json>`, where the JSON is
   `json_encode(getNodeData())` — `{drupal:{title, content_type, taxonomy:{…}}}` for the current
   node (empty when there is no node).
4. Returns a `#tag => script` render element (`data-cfasync=false`, `type=text/javascript`) whose
   `#value` is `Markup::create($script)`, keyed `acquia_vwo`, pushed onto
   `$page['#attached']['html_head']`.

`UserControl::addUserOptScript()` similarly attaches a small head script defining
`acquiaVwoUserOptOut()` (keyed `acquia_vwo_user_control`), plus `drupalSettings.user.vwo_user_opt`
and the `acquia_vwo/user_opt` library. This one is attached on **all** pages (including admin);
the VWO smart code itself is skipped on admin routes.

## `getNodeData()` shape

```js
window.VWO.data.acquia = {
  drupal: {
    title: "<node title>",
    content_type: "<bundle>",
    taxonomy: { content_section: ["…"], content_keywords: ["…"], persona: ["…"] }
  }
}
```
Term names are resolved through `entity.repository` translated to the current content language.

## Hooks (`acquia_vwo.module`)

| Hook | Behaviour |
|---|---|
| `hook_page_attachments_alter` | Always calls `UserControl::addUserOptScript()`; then returns early on admin routes (`router.admin_context`); otherwise calls `PageContext::populate()`. |
| `hook_form_user_form_alter` | Adds the "VWO" opt checkbox to the user edit form (via `UserControl::userFormAlter()`), with submit handler `acquia_vwo_form_user_form_alter_submit`. |
| `hook_help` | Renders help text on `help.page.acquia_vwo` and the settings routes (`acquia_vwo.help.inc`). |
| `hook_requirements` | Runtime error if the separate `vwo` module is also enabled. |

## Visibility evaluation

`VisibilityContext::shouldAttach()` → returns FALSE when `id` is empty, TRUE when
`visibility.enabled != 'on'`, else `ConditionResolver::evaluateConditions(visibility.conditions)`.
`ConditionResolver` merges a fixed mapping (`request_path`, `user_role` with the current-user
context, `entity_bundle:node` with the node route context) with stored condition config, builds a
`ConditionPluginCollection`, applies runtime contexts, and resolves them with logic `and`
(`ConditionAccessResolverTrait`).
