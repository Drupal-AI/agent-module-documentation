# Theme rules (configure)

There is **no module settings page**. All configuration is a set of `theme_rule` config entities
managed through the entity UI. A theme rule = one target theme + an ordered set of core Condition
plugins; the enabled rule with the lowest weight whose conditions all match wins.

## Admin UI

- Tab: **Appearance → Theme rules** — local task `theme_rule.rules` on `system.themes_page`
  (`/admin/appearance/theme-rules`), route `entity.theme_rule.collection` (`_entity_list: theme_rule`).
  Rendered by `ThemeRuleListBuilder` (a `DraggableListBuilder`): columns Rule name / Theme / Status /
  Conditions, drag-and-drop reordering, operations Edit / Delete / Enable|Disable.
- Add: action link `theme_rule.rule_add` → route `theme_rule.rule_add` (`/…/add`,
  `_entity_form: theme_rule.add`). Core also auto-generates `entity.theme_rule.add_form` at the same
  path from the entity `add-form` link.
- Edit / Delete: `entity.theme_rule.edit_form` (`/…/manage/{theme_rule}`),
  `entity.theme_rule.delete_form` (`…/delete`, core `EntityDeleteForm`).
- Enable / Disable: `entity.theme_rule.enable` / `entity.theme_rule.disable`
  (`/…/manage/{theme_rule}/{enable|disable}`) → `ThemeRuleStatusController::toggleStatus`. These flip
  `status` and redirect back to the collection. They are GET routes but declare
  `_csrf_token: 'TRUE'`, so the operation links carry a CSRF token.

Every route requires the core `administer themes` permission (also the entity `admin_permission`).

## The config entity — `theme_rule.rule.<id>`

Schema `theme_rule.rule.*` (`config/schema/theme_rule.schema.yml`), `config_export` on
`Entity\ThemeRule`:

| Key | Type | Meaning |
|---|---|---|
| `id` | string | Machine name (`machine_name` element, must be unique). |
| `label` | label | Human name. |
| `status` | boolean | Entity `status`; a disabled rule is skipped during negotiation. |
| `theme` | string | Machine name of the theme to activate. Options come from `theme_handler->listInfo()` (installed themes only). |
| `weight` | integer | Sort order (`#type weight`, delta 10). **Lower weight = evaluated first = higher priority.** |
| `conditions` | sequence | Condition plugin configs, keyed by condition id; each validated against `condition.plugin.[id]`. |

Example (`theme_rule.rule.marketing.yml`): switch to the `claro` theme on `/campaign*` for
authenticated users.

```yaml
id: marketing
label: 'Marketing pages'
status: true
theme: claro
weight: -10
conditions:
  request_path:
    id: request_path
    negate: false
    pages: "/campaign\n/campaign/*"
  user_role:
    id: user_role
    roles:
      authenticated: authenticated
    negate: false
    context_mapping:
      user: '@user.current_user_context:current_user'
```

## Conditions offered on the form

`ThemeRuleForm::buildConditions()` (`src/Form/ThemeRuleForm.php`) lists every Condition plugin that
`plugin.manager.condition->getFilteredDefinitions('theme_rule', <contexts>, ['theme_rule' => $entity])`
returns, each in its own vertical tab. So the available conditions are whatever `Condition` plugins
the site has — typically **`request_path`** (Pages), **`user_role`** (Roles), the node-type / entity
bundle condition (Content types), **`language`**, plus any contrib/custom one (e.g. the
`route_condition` module). Two are pruned by `theme_rule_plugin_filter_condition__theme_rule_alter()`:

- `current_theme` is always removed (a rule must not key off the theme it is about to set).
- `language` is removed unless the site is multilingual.

The form copies BlockForm's presentation tweaks for the core conditions when present: relabels
`node_type` → “Content types”, `user_role` → “Roles”, `request_path` → “Pages” and turns its
`negate` into radios (“Show for the listed pages” / “Hide for the listed pages”); `negate` is forced
to a `value` element for `node_type`, `user_role`, `language`. Each condition stores its own
`negate` boolean and (context-aware ones) a `context_mapping`.

## Ordering & the “ignored rule” rules

- Reorder by weight via drag-and-drop on the collection; the topmost matching rule wins.
- A **disabled** rule (`status: false`) is skipped.
- A rule with **no conditions** is skipped (an empty rule would otherwise match every page).
  Both facts are surfaced in the list builder’s on-page “Usage” help.

## Create a rule from code

```php
use Drupal\theme_rule\Entity\ThemeRule;

ThemeRule::create([
  'id' => 'partner_area',
  'label' => 'Partner area',
  'status' => TRUE,
  'theme' => 'my_partner_theme',
  'weight' => -20,
  'conditions' => [
    'request_path' => [
      'id' => 'request_path',
      'pages' => "/partner\n/partner/*",
      'negate' => FALSE,
    ],
  ],
])->save();
```

Saving recalculates dependencies: the chosen `theme` and each condition’s provider module are added
to the entity’s config dependencies (see [../api/negotiation.md](../api/negotiation.md)).
