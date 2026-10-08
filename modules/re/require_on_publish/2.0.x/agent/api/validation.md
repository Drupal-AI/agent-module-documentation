<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enforcement: the `require_on_publish` constraint

Enforcement is a standard Symfony/Drupal **entity-level validation constraint**, not a form
handler — so it fires on any `$entity->validate()`, including programmatic saves and REST.

## Wiring

`hook_entity_type_alter()` adds the constraint to **every** entity type whose class implements
`\Drupal\Core\Entity\EntityPublishedInterface`:

```php
$entity_types[$type]->addConstraint('require_on_publish');
```

- Constraint plugin: `@Constraint(id="require_on_publish")` →
  `Plugin/Validation/Constraint/RequireOnPublish` (message
  `@field_label field is required when publishing.`).
- Validator: `RequireOnPublishValidator` (services: `module_handler`, `request_stack`,
  `messenger`).

## Validator logic (`validate()`)

For the entity being validated, `is_published = $entity->isPublished()` (for a `paragraph`, the
parent/host publish status is used instead). Then for each field with a `FieldConfig`:

1. If the field is a **boolean** and its value is truthy → skip (considered filled).
   Otherwise if the field **is not empty** → skip.
2. If the field's third-party setting `require_on_publish.require_on_publish` is not TRUE → skip.
3. If `is_published` is TRUE → add a violation at the field path
   (`<label> field is required when publishing.`) — this blocks the save.
4. Else (unpublished) → if `warn_on_empty` is TRUE, add a **warning message** via messenger
   (non-blocking); otherwise skip.

## Consequences for an agent

- To test the effect in code: build a **published** entity with the flagged field empty and call
  `$entity->validate()`; expect a violation whose property path is the field name. An
  **unpublished** entity produces no violation (only a warning message if `warn_on_empty`).
- A boolean field counts as "filled" only when checked (truthy) — so a required-on-publish
  boolean effectively must be TRUE to publish.
- Because it is a constraint, it applies uniformly to node forms, Paragraphs, and API-driven
  saves; there is no separate per-form toggle.
