<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create and manage Theme Switcher rules

## Config entity shape

```yaml
# theme_switcher.rule.<id>
id: campaign_theme
label: 'Campaign pages'
status: true            # inactive rules are skipped entirely
weight: 0               # ascending; lowest weight is evaluated first
theme: olivero          # theme used on non-admin routes
admin_theme: ''         # theme used on admin routes ('' = rule does not apply there)
conjunction: and        # 'and' = all conditions pass, 'or' = at least one
visibility:             # keyed by condition plugin id
  request_path:
    id: request_path
    negate: false
    context_mapping: {  }
    pages: "/campaign\n/campaign/*"
```

Entity type: `theme_switcher_rule` (`Drupal\theme_switcher\Entity\ThemeSwitcherRule`,
`config_prefix: rule`, `admin_permission: administer site configuration`).
`config_export` = `uuid, id, label, weight, status, theme, admin_theme, conjunction, visibility`.
Schema: `theme_switcher.rule.*` in `config/schema/theme_switcher.schema.yml`; `visibility` is
a sequence of `condition.plugin.[id]`, so every condition validates against its own schema.

## Admin UI

| Purpose | Route | Path |
|---|---|---|
| List (entity list, drag-and-drop weights) | `theme_switcher.admin` | `/admin/config/system/theme_switcher` |
| Add | `entity.theme_switcher_rule.add_form` | `/admin/config/system/theme_switcher/add` |
| Edit | `entity.theme_switcher_rule.edit_form` | `/admin/config/system/theme_switcher/edit/{id}` |
| Delete | `entity.theme_switcher_rule.delete_form` | `/admin/config/system/theme_switcher/delete/{id}` |
| AJAX enable/disable | `theme_switcher.inline_action` | `/admin/config/theme_switcher/{op}/{id}` (`op` = `enable\|disable`, CSRF token required) |

The add/edit form (`ThemeSwitcherRuleForm`) renders every condition plugin returned by
`plugin.manager.condition->getFilteredDefinitions('theme_switcher_ui', …)` as a vertical tab,
after running `hook_available_conditions_alter()`. Theme selects list every installed theme
plus a `- None -` (`''`) option; **Theme** is required, **Admin Theme** is not. `weight` is
present but `#access: FALSE` — it is only changed by dragging rows on the list page.

## Create a rule with drush

```bash
drush php:eval '
use Drupal\theme_switcher\Entity\ThemeSwitcherRule;
ThemeSwitcherRule::create(["id" => "campaign_theme"])
  ->set("label", "Campaign pages")
  ->set("status", TRUE)
  ->set("weight", 0)
  ->set("theme", "olivero")
  ->set("admin_theme", "")
  ->set("conjunction", "and")
  ->set("visibility", [
    "request_path" => [
      "id" => "request_path", "negate" => FALSE,
      "context_mapping" => [], "pages" => "/campaign\n/campaign/*",
    ],
  ])->save();
'
```

Read it back:

```bash
drush cget theme_switcher.rule.campaign_theme
drush php:eval 'print implode(",", array_keys(\Drupal\theme_switcher\Entity\ThemeSwitcherRule::loadMultiple()));'
```

## Useful condition ids

| Condition id | Config keys | Notes |
|---|---|---|
| `request_path` | `pages` (newline-separated, `*` wildcard, `<front>`) | the most common rule |
| `entity_bundle:node` | `bundles: {article: article}` | needs a node context on the route |
| `user_role` | `roles: {editor: editor}` | |
| `language` | `langcodes: {de: de}`, `context_mapping` | hidden by this module on monolingual sites |
| `response_status` | `response_codes` | contrib/core depending on version |

Every condition also accepts `negate: true` ("all pages except…").

## Evaluation order (`ThemeSwitcherNegotiator`)

1. Load all rules with `->sort('weight', 'ASC')`.
2. Skip rules where `status()` is FALSE **or** both `theme` and `admin_theme` are empty.
3. For each context-aware condition, fetch runtime contexts; if a context is missing or has
   no value (`MissingValueContextException` / `ContextException`) the **whole rule is
   skipped** (`continue 2`) — this is why an `entity_bundle:node` rule simply does not apply
   on non-node routes.
4. `resolveConditions($conditions, $conjunction)`; if it does not return FALSE the rule matches.
5. Pick `admin_theme` when `router.admin_context->isAdminRoute()` is TRUE, else `theme`.
   If the picked value is empty the negotiator returns FALSE and evaluation stops there —
   **it does not fall through to the next rule.**

So: put the most specific rule at the lowest weight, and give a rule an `admin_theme` only
if you really want it to take over admin pages.

## Housekeeping hooks

`theme_switcher_user_role_delete()` and `theme_switcher_configurable_language_delete()`
strip the deleted role / language out of every rule's `user_role` / `language` visibility
config and re-save the rules.
