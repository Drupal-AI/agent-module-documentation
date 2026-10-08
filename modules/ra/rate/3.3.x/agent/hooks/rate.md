<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Invited hooks (`rate.api.php`)

Implement these in a custom module to customize voting behavior.

## `hook_rate_vote_data_alter(array &$vote_data, $entity_type, $entity_bundle, $entity_id, $rate_widget, RateWidget $settings, $user_id)`
Alter the vote array **before** it is written to VotingAPI storage — e.g. change
`$vote_data['value_type']` or write a custom `votingapi_vote` column.

## `hook_rate_widget_options_alter(array &$options, $entity_type, $entity_bundle, $entity_id, $rate_widget, RateWidget $settings, $user_id)`
Override a widget's options (each `['value','label','class']`) right before the widget form is
built — e.g. relabel or restyle buttons per context.

## `hook_rate_can_vote(&$can_vote, Vote $vote, $entity, AccountProxy $account)`
Add custom eligibility rules; set `$can_vote = FALSE` to forbid a vote (e.g. only allow voting
on the `article` bundle).

## `hook_rate_templates()`
Return an array of template definition objects keyed by template name; each has `value_type`,
`options`, `customizable`, `translate`, `template_title`. Use it to add a new widget style or
modify an existing one.

## `hook_rate_value_column(&$value_column, $entity_type, $entity_bundle, $entity_id, $rate_widget, $user_id)`
Return an alternative `votingapi_vote` column to read the rate value from when results are
computed (default `value`).

Example:

```php
function mymodule_rate_can_vote(&$can_vote, \Drupal\votingapi\Entity\Vote $vote, $entity, $account) {
  if ($entity->bundle() !== 'article') {
    $can_vote = FALSE;
  }
}
```
