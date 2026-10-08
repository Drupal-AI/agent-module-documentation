<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Configure the Autocomplete Deluxe widget

The module has **no admin settings page**. You enable it per field by choosing the widget
**Autocomplete Deluxe** (plugin id `autocomplete_deluxe`) on *Structure → Content types →
Manage form display* for any `entity_reference` field (taxonomy term reference, node, user,
media, …). Settings are stored on the `entity_form_display` config entity component under
`content.<field_name>.type = autocomplete_deluxe` and `.settings`.

## Settings keys (config schema `field.widget.settings.autocomplete_deluxe`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `match_operator` | string | `CONTAINS` | Match mode: `STARTS_WITH` or `CONTAINS`. |
| `match_limit` | integer | `10` | Max suggestions shown; `0` = no limit. |
| `min_length` | integer | `0` | Characters typed before the suggestion list opens. |
| `size` | integer | `60` | Text input size. |
| `selection_handler` | string | `default` | Entity-reference selection handler (usually inherited from the field). |
| `autocomplete_route_name` | string | `autocomplete_deluxe.autocomplete` | Route serving matches. |
| `delimiter` | string | `''` | Extra character (besides Enter) that separates entered terms. |
| `new_terms` | boolean | `false` | Allow editors to create brand-new referenced entities (free tagging). |
| `not_found_message_allow` | boolean | `false` | Show a message when a typed term is not found. |
| `not_found_message` | label | `The term '@term' will be added` | That message text (`@term` token). |
| `no_empty_message` | label | `No terms could be found. Please type in order to add a new term.` | Placeholder shown when the box is empty. |

Only the subset you override needs to appear in `settings`; unset keys fall back to
`defaultSettings()` above. The widget declares `multiple_values = TRUE`, so a single box
holds all values of a multi-cardinality field.

## Set it via Drush / PHP (no UI)

Point an existing entity-reference field's form display at the widget. Example: the
`field_tags` reference on `node.article`, matching by prefix and allowing new terms.

```bash
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")
    ->load("node.article.default");
  $fd->setComponent("field_tags", [
    "type" => "autocomplete_deluxe",
    "weight" => 10,
    "settings" => [
      "match_operator" => "STARTS_WITH",
      "match_limit" => 10,
      "min_length" => 2,
      "new_terms" => TRUE,
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
  print $c["type"] . "\n";           // -> autocomplete_deluxe
  print json_encode($c["settings"]) . "\n";
'
```

In exported config the component appears in
`core.entity_form_display.node.article.default.yml`:

```yaml
content:
  field_tags:
    type: autocomplete_deluxe
    weight: 10
    settings:
      match_operator: STARTS_WITH
      match_limit: 10
      min_length: 2
      new_terms: true
    third_party_settings: {  }
```

Notes:
- The widget only appears in the *Manage form display* widget dropdown for
  **entity_reference** fields; it will not attach to text/number/etc. fields.
- `new_terms` (free tagging) only creates entities when the field's selection handler allows
  auto-create (e.g. a taxonomy term reference with an "Create referenced entities if they
  don't already exist" target). It relies on the field's own `handler_settings`.
