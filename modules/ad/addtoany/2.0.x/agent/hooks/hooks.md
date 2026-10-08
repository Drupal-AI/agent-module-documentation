# Hooks

Declared in `addtoany.api.php`.

### `hook_addtoany_entity_types_alter(array &$types)`
Alter the list of entity types the AddToAny pseudo-field is offered for. By default AddToAny
targets node, media and comment; use this to add others.

```php
function mymodule_addtoany_entity_types_alter(array &$types) {
  $types[] = 'taxonomy_term';
}
```

## Helper functions (in `addtoany.module`)
Not formal hooks, but callable for custom rendering:
- `addtoany_create_entity_data(ContentEntityInterface $entity, $config = NULL)` — build the
  AddToAny share data (url/title/html) for a given entity.
- `addtoany_create_data($url = NULL, $title = NULL, $config = NULL)` — build share markup for an
  arbitrary URL/title.
