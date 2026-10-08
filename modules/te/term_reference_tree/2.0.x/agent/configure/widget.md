<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Configure the Term Reference Tree widget

The module has **no admin settings page**. You enable it per field by choosing the widget
**Term reference tree** (plugin id `term_reference_tree`) on *Structure → Content types →
Manage form display* for an `entity_reference` field that targets taxonomy terms. Settings
are stored on the `entity_form_display` config entity component under
`content.<field_name>.type = term_reference_tree` and `.settings`.

## Settings keys (config schema `field.widget.settings.term_reference_tree`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `start_minimized` | boolean | `true` | Render the tree collapsed by default. |
| `leaves_only` | boolean | `false` | Only terms with no children are selectable. |
| `select_parents` | boolean | `false` | Auto-select ancestors of selected terms. **Unlimited cardinality only** (disabled/forced off otherwise). |
| `select_all` | boolean | `false` | Add a check/uncheck-all control. **Unlimited cardinality only.** |
| `cascading_selection` | integer | `0` | Cascade a parent toggle to children: `0` none, `1` select + deselect, `2` only on select, `3` only on deselect. **Unlimited cardinality only.** |
| `max_depth` | integer | `0` | Show terms only this many levels deep; `0` = unlimited. |

Only the subset you override needs to appear in `settings`; unset keys fall back to
`defaultSettings()` above. The widget declares `multiple_values = TRUE`, so one tree holds
all values of a multi-cardinality field. On a **single-value** field the tree renders as
radio buttons, and `select_parents` / `select_all` / `cascading_selection` are disabled
(they only apply when an unlimited number of values can be chosen).

## Set it via Drush / PHP (no UI)

Point an existing taxonomy term reference field's form display at the widget. Example: the
`field_tags` reference on `node.article`, collapsed by default with cascading select+deselect.

```bash
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")
    ->load("node.article.default");
  $fd->setComponent("field_tags", [
    "type" => "term_reference_tree",
    "weight" => 10,
    "settings" => [
      "start_minimized" => TRUE,
      "leaves_only" => FALSE,
      "cascading_selection" => 1,
      "max_depth" => 0,
    ],
  ])->save();
'
```

Read back which widget a field uses:

```bash
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")
    ->load("node.article.default");
  $c = $fd->getComponent("field_tags");
  print $c["type"] . "\n";              // -> term_reference_tree
  print json_encode($c["settings"]) . "\n";
'
```

In exported config the component appears in
`core.entity_form_display.node.article.default.yml`:

```yaml
content:
  field_tags:
    type: term_reference_tree
    weight: 10
    settings:
      start_minimized: true
      leaves_only: false
      select_parents: false
      select_all: false
      cascading_selection: 1
      max_depth: 0
    third_party_settings: {  }
```

## Display side (formatter)

To render the stored terms back as a nested tree, set the field's *Manage display*
component `type` to `term_reference_tree` (the formatter has no settings):

```bash
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")
    ->load("node.article.default");
  $vd->setComponent("field_tags", ["type" => "term_reference_tree", "weight" => 10])->save();
'
```

Notes:
- The widget/formatter only appear in the *Manage form/display* dropdowns for
  **entity_reference** fields; they will not attach to text/number/etc. fields.
- The tree is built from each target vocabulary in the field's `handler_settings`
  (`target_bundles`), so restrict a field's allowed vocabularies to control what the tree shows.
