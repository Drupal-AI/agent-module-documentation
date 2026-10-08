<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `Base Entity Usage` Views field and the "Usage" operations link

## The Views field

- Plugin `BaseEntityUsageField` in
  `src/Plugin/views/field/BaseEntityUsageField.php`, annotated
  `@ViewsField("base_entity_usage_views_field")`, extending core `FieldPluginBase`.
- Registered by `hook_views_data()` (`entity_usage_explorer.module`): it adds a global,
  join-less field `base_entity_usage_views_field` under the **"Entity Usage"** group, titled
  *"Base Entity Usage"*, help *"Total count."*. Because the join is `#global`, the field can be
  added to any View whose rows expose an entity (`$row->_entity`).
- `query()` is a **no-op** (it overrides the parent so the field adds nothing to the SQL query);
  the count is computed at render time instead.
- `create()` injects the `entity_usage_explorer.usage` service.

### Adding it to a View

*Structure → Views → (your View) → Add → search "Base Entity Usage"* (group *Entity Usage*).
Then set the field's options:

| Option | Default | Meaning |
|---|---|---|
| `render_type` | `plain_text` | `plain_text` = show the count as text; `link` = show the count as a link to the entity's usage overview page. |
| `hide_alter_empty` | `FALSE` | Standard Views "hide if empty" behavior. |

`buildOptionsForm()` exposes `render_type` as a select ("Plain Text" / "Link to usage overview
page").

### How a row renders

`render(ResultRow $values)`:

1. reads `$entity = $values->_entity`, its id and entity-type id;
2. `count = UsageService::getEntityUsageCount($entity_type, $id)`;
3. if `render_type === 'link'` → a `#type => 'link'` render element whose `#title` is the count
   and `#url` is `Url::fromRoute('entity_usage_explorer.usage_page', {entity_type, entity_id})`;
   otherwise `#markup => $count`.

Because the count comes from the service (not a query column), the field works on any entity-based
View but computes the count per rendered row. It can be **exported as CSV / JSON / XML** with the
Views Data Export module.

## The "Usage" operations link

`hook_entity_operation()` (`entity_usage_explorer.module`) adds an operation to **every**
`ContentEntityInterface` row, but only when the current user has
`access entity usage dashboard`:

```php
$operations['entity_usage_explorer'] = [
  'title' => t('Usage'),
  'weight' => '100',
  'url' => Url::fromRoute('entity_usage_explorer.usage_page', [
    'entity_type' => $entity->getEntityTypeId(),
    'entity_id' => $entity->id(),
  ]),
];
```

So any admin listing that renders entity operations (content, media, users, etc.) gains a "Usage"
link straight to that entity's overview page.

## Operating notes

- The only permission involved anywhere in the module is **`access entity usage dashboard`**; it
  gates the route, the operations link, and therefore the Views field's link target.
- The Views field's `query()` no-op means it does not affect sorting/filtering — it is a computed
  display column only.
