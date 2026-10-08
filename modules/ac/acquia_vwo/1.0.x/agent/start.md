<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia VWO (acquia_vwo) — agent index

Integrates VWO (Visual Website Optimizer — A/B, split and multivariate testing) with **enhanced
data capture**. On every non-admin page it injects the VWO "smart code" as an inline `<script>` in
`html_head`, plus a second inline script exposing `window.VWO.data.acquia` — the current node's
Drupal metadata (title, content-type bundle, and taxonomy-term names read from admin-mapped
entity-reference fields) — so VWO experiments and reports can segment on what the CMS knows and the
testing tool otherwise cannot. Injection happens from `hook_page_attachments_alter()`
(`acquia_vwo.module`) through the `PageContext` service; a `VisibilityContext` decides whether to
attach by evaluating core condition plugins (request path, user role, node bundle) and a per-user
opt in/out preference.

All configuration is four tabbed forms under `/admin/config/system/acquia_vwo` (settings,
visibility, extract account id, field mapping), each writing to the single `acquia_vwo.settings`
config object. The account id must be numeric (or the placeholder `NONE`); the "Extract Account ID"
tab parses it out of a pasted VWO smart-code block.

- Depends on: `node`, `taxonomy` (info.yml). Core: `^9.2 || ^10 || ^11`. Package: `Statistics`.
- Settings page / configure route: `acquia_vwo.settings` (`/admin/config/system/acquia_vwo`).
- Permission: `administer acquia vwo` — gates all four routes.
- Provides config schema (`acquia_vwo.settings`). No drush. No plugin types. No fields, widgets or
  formatters of its own (it *reads* node entity-reference→taxonomy fields that you map).
- `hook_requirements()` raises an error if the older separate `vwo` contrib module is also enabled
  (the two are mutually exclusive).

## What you'd do → where

- **Set the VWO account id and snippet timeout, extract the id from a pasted smart-code block, map
  taxonomy fields to VWO segments, restrict which pages load the script, allow per-user opt
  in/out** → [configure/settings.md](configure/settings.md)
- **Understand the services, exactly how/where the inline script is built and attached, and the
  module hooks** → [api/services.md](api/services.md)

## Key facts (real machine names)

- Routes (all `_permission: administer acquia vwo`): `acquia_vwo.settings`
  (`/admin/config/system/acquia_vwo`), `acquia_vwo.settings.visibility` (`…/visibility`),
  `acquia_vwo.settings.vwoid` (`…/vwoid`), `acquia_vwo.settings.field_mapping` (`…/field_mapping`).
- Forms: `\Drupal\acquia_vwo\Form\SettingsForm` (id + timeout),
  `…\Form\VisibilityForm` (enabled + user_control + condition plugins),
  `…\Form\ExtractIDForm` (parse id from pasted smart code),
  `…\Form\FieldMappingForm` (map 3 segments to node taxonomy fields).
- Services: `acquia_vwo.service.context.page_context` (`PageContext`),
  `acquia_vwo.service.context.visibility_context` (`VisibilityContext`),
  `acquia_vwo.service.user.user_control` (`UserControl`),
  `acquia_vwo.service.helper.path_matcher` (`PathMatcher`),
  `acquia_vwo.service.condition.condition_resolver` (`ConditionResolver`).
- Permission: `administer acquia vwo`.
- Config object `acquia_vwo.settings` keys: `id`, `loading.timeout`, `visibility.enabled`
  (`off`/`on`), `visibility.user_control` (`nocontrol`/`optout`/`optin`), `visibility.conditions`
  (sequence of condition-plugin config), `field_mapping.content_section`,
  `field_mapping.content_keywords`, `field_mapping.persona`.
- Condition plugins evaluated (core, via `ConditionResolver`): `request_path`, `user_role`,
  `entity_bundle:node`.
- Library: `acquia_vwo/user_opt` (`js/user_opt.js`). VWO smart-code template: `js/vwo.js`
  (its body is concatenated into the inline head script by `PageContext`).
- Hooks: `hook_page_attachments_alter`, `hook_form_user_form_alter` (+ submit handler
  `acquia_vwo_form_user_form_alter_submit`), `hook_help`, `hook_requirements`.
- Per-user opt preference stored via the `user.data` service under module `acquia_vwo`, key
  `user_opt` (per uid; `0` = out, `1` = in).
