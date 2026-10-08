# The `webform_entity_handler` handler plugin

`@WebformHandler(id = "webform_entity_handler", label="Entity", category="External",
cardinality=CARDINALITY_UNLIMITED, results=RESULTS_PROCESSED, submission=SUBMISSION_OPTIONAL,
tokens=TRUE)`. Class `WebformEntityHandler extends WebformHandlerBase`.

## Settings (config schema `webform.handler.webform_entity_handler`)

| Key | Type | Meaning |
|---|---|---|
| `operation` | string | `_default` = create a new entity. `input:<element_key>` = update the entity whose ID is in that submission element. Any other literal = update that custom/token entity ID. |
| `skip_if_exists` | bool | If the entity is found (by ID or properties), do nothing. |
| `entity_type_id` | string | Target as `<entity_type>:<bundle>`, e.g. `node:article`, `user:user`, `taxonomy_term:tags`. Only content entity types are offered. |
| `entity_properties` | text (YAML) | Optional property→value map used with `loadByProperties()` to find an existing entity when you have no ID. Tokens supported. |
| `entity_values` | sequence | The field mapping: `entity_values[<field_name>][<property_name>] = <value>` (see mapping syntax). |
| `entity_revision` | bool | Create a new revision on save (only shown/used for revisionable entity types). |
| `states` | sequence | Submission states that trigger the handler: `draft_created`, `draft_updated`, `converted`, `completed` (default), `updated`, `deleted`. |

Default configuration: `operation=_default`, `skip_if_exists=NULL`, `entity_properties=''`,
`entity_type_id=NULL`, `entity_values=[]`, `entity_revision=FALSE`, `states=['completed']`.

## Mapping syntax (values inside `entity_values`)

Each mapped property value is one of:
- `input:<element_key>` — copy the value of that submission element. Composite sub-elements use
  `input:<parent>|<child>` (pipe-separated key path).
- `_null_` — set the property to NULL.
- any other string — used literally, then **token-replaced** against the submission
  (`[webform_submission:values:...]`, `[current-user:uid]`, …).
- On multi-value fields, a per-field `webform_entity_handler_append` flag appends instead of
  overwriting (`$entity->get($field)->appendItem(...)`).

## Runtime behavior (`postSave()`)

1. Runs only if the submission's current state is in `states` (results-disabled webforms force
   `completed`).
2. Resolves `entity_values` (input lookups, `_null_`, token replace), then adds the bundle key.
3. Determines `entity_id` from `operation`; if set (or `entity_properties` is set) it loads the
   entity — first by ID, else by `loadByProperties()` on the token-replaced YAML map.
4. If found and `skip_if_exists` → return. If found with a different bundle → deletes and recreates
   preserving `id`/`uuid` (and back-fills unset fields from the previous entity). Otherwise sets
   the mapped fields (append or override).
5. If still empty → `storage->create($data)`.
6. Sets a new revision if configured & revisionable, then `$entity->save()`.
7. Logs "@type %title has been created/updated." to the `webform_submission` log (if the webform
   logs submissions) or the `webform_entity_handler` logger.
8. For `input:` update operations, writes the saved entity's ID back into that submission element
   and re-saves the submission.

Exceptions are caught and logged; the user sees a generic "There was a problem…" message.
