# Configure uniqueness rules

There is no dedicated admin page. The **"Unique Field restrictions"** fieldset is added to
three existing forms (requires `unique_field_perm_admin` for the node/term forms):

| Entity | Form | Config branch |
|---|---|---|
| Node | *Structure → Content types → edit* (`node_type_add_form` / `node_type_edit_form`) | `unique_field_settings.<node_type>` |
| Taxonomy term | *Structure → Taxonomy → edit vocabulary* (`taxonomy_vocabulary_form`) | `unique_field_taxonomy.<vocabulary>` |
| User | *Configuration → People → Account settings* (`user_admin_settings`) | `unique_field_user` |

## Settings per branch (config object `unique_field.settings`)

- `fields`: list of field machine names that must be unique. Node/term forms also offer
  `title`/`name`/`description`/`language` as pseudo-fields.
- `scope` (nodes & terms only):
  - nodes — `type` (default, same content type), `language`, `all` (all nodes), `node`
    (values unique within the single node's multivalue field).
  - terms — `vocabulary` (default), `language`, `all`, `term`.
- `comp`: `each` (default — every listed field must independently be unique) or `all` (the
  *combination* of listed field values must be unique). Users only have `fields` + `comp`.

Example config:

```yaml
# unique_field.settings
unique_field_settings:
  article:
    fields: { field_sku: field_sku, title: title }
    scope: type
    comp: each
unique_field_user:
  fields: { field_member_no: field_member_no }
  comp: each
```

## How validation runs

`hook_form_alter` appends a `#validate` handler to the node/term/user edit forms and a hidden
`unique_field_override` field. On non-AJAX submit the handler:
1. returns early if `unique_field_override == 1` (bypass) or no fields configured;
2. for each configured field present in `$form_state` values, runs a parameterised
   `db->select()` on the field's data table (`node__<field>`, `taxonomy_term__<field>`,
   `user__<field>`, or the base `title`/`name`/`description` column), applying the scope
   condition and excluding the current entity id (`<>`);
3. on a hit, `setErrorByName(...'has to be unique')` and rebuilds the form.

Field values are always passed as bound placeholders (`condition(..., 'IN')`); table/column
names come from admin-selected field machine names, not from request input.

## Override / bypass

If validation fails **and** the current user has `unique_field_perm_bypass`, instead of a hard
block they get a warning message with a link that JS-sets the hidden `unique_field_override` to
`1` and resubmits, skipping the check for that submission. Both `unique_field_perm_admin` and
`unique_field_perm_bypass` are declared `restrict access: TRUE` (grant to trusted roles only).

## Gotchas

- Only nodes, taxonomy terms and users are supported — not arbitrary content entities.
- A field hidden on the *Manage form display* isn't in the submitted values, so it is **not**
  validated (uniqueness is enforced only for fields the editor actually submits).
- `comp: all` combined with the single-node/single-term scope is rejected on save (an error is
  shown) since "each" is required there.
