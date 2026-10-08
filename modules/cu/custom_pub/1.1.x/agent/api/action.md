# Setting a custom publishing option programmatically & the Action plugin

Because each option is a plain boolean **base field on `node`** (named after the option id), you
set it like any node field:

```php
$node->set('archived', TRUE);   // 'archived' is the option's machine id
$node->save();
```

## Action plugin

`Drupal\custom_pub\Plugin\Action\SetCustomPublishOptionValue` — a configurable node Action:

```
@Action(
  id = "set_custom_publishing_option_value",
  label = "Set a custom publish option value on a node",
  type = "node"
)
```

Configuration keys: `option` (the custom publishing option id) and `value` (bool). Its `execute()`
does `$node->{$option} = (bool) $value; $node->save();`. Access requires update access on the node
and edit access on its `status` field. Use it from VBO/Views bulk operations or the content overview
to bulk-set an option. Config schema for the action:
`custom_pub.configuration.set_custom_publishing_option_value` (mapping of `option` string, `value`
boolean).

## Rules & migrate

- A Rules action `Drupal\custom_pub\Plugin\RulesAction\SetCustomPublishingOption` (if the Rules
  module is present).
- A Drupal 7 migrate source `Drupal\custom_pub\Plugin\migrate\source\d7\CustomPub` for importing
  legacy custom publishing options.

## Views

Each option field is exposed to Views as a boolean field/filter/sort automatically (it is a node
base field), so no extra Views plugin is needed — filter on `<option_id>` to build listings such as
an "Archived" or "Featured" content view.
