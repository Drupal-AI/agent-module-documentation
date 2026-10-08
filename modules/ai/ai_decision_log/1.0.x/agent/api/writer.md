<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ai Decision Log — writer service

```php
$writer = \Drupal::service('ai_decision_log.writer');
$writer->...  // create and persist an ai_decision entity
```

The `ai_decision` content entity captures: title, summary, context, decision, alternatives, related, source, author. Related entity / config / module references are stored as structured text.

`DecisionLogWriter` applies a `SECRET_PATTERN` regex that strips api-key / access-key / secret / token / password / bearer / client-secret / private-key values from decision text before it is persisted, so decision bodies passed from other modules cannot accidentally store credentials.

Intended consumer: **AI Policy Gateway** mirrors each policy decision into this log for audit. The module is otherwise standalone (no hard sibling-module dependency, no paid provider).
