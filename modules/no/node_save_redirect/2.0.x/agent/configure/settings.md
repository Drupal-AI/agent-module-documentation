# Node Save Redirect — configuration

## Where config lives
Third-party settings on each content type (`node.type.<bundle>`), namespace `node_save_redirect`:
```yaml
third_party_settings:
  node_save_redirect:
    save_type: 4            # redirect on CREATE (0..4)
    save_location: '/dashboard'
    save_destination: true  # ignore ?destination= on create
    edit_type: 1            # redirect on EDIT (0..4)
    edit_location: ''
    edit_destination: false
```
Schema `config/schema/node_save_redirect.schema.yml` (Choice-constrains `*_type` to 0–4).

## Redirect type values
- `0` Default (core behavior).
- `1` Return to the editing page (`node/<id>/edit`).
- `2` View the content (`node/<id>`).
- `3` Content overview (`admin/content`).
- `4` Custom location — uses `save_location` / `edit_location` (any valid Drupal path).

## The form (no separate config page)
`NodeSaveRedirectHooks::formNodeTypeEditFormAlter` (`#[Hook('form_node_type_edit_form_alter')]`) adds two `details` groups ("Redirect user after saving new content" / "…editing existing content") into `$form['submission']`, each with a `*_type` radios, a `*_location` textfield (visible only when type = `4` via `#states`), and a `*_destination` checkbox. An `#entity_builders` callback (`node_save_redirect_form_node_type_form_builder`) persists the values with `setThirdPartySetting()`.

## Redirect logic on node save
- `formNodeFormAlter` (`#[Hook('form_node_form_alter')]`) appends `node_save_redirect_form_node_form_submit` to every non-`preview` submit button's `#submit`.
- `formNodeFormSubmit`:
  1. Loads the node's content type; picks `edit_*` if the form operation is `edit`, else `save_*`.
  2. If the `*_destination` flag is set and the request has a `destination` query param, removes it.
  3. Switches on `*_type`: cases 1–3 build a fixed path, case 4 uses the configured location; each is passed through `\Drupal::pathValidator()->getUrlIfValid(...)` and applied via `$form_state->setRedirectUrl()`. An invalid custom path yields no valid Url (redirect effectively skipped).
- `node_save_redirect_module_implements_alter` moves this module's `form_alter` to run last so it can append its submit handler after others.
