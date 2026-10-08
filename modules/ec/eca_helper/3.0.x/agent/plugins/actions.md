# ECA Helper — actions & events

All actions are ECA action plugins in `src/Plugin/Action/`. Add them as steps in an ECA
model (Modeller UI). Ids below are the plugin ids; labels shown in the UI are prefixed
`ECA Helper: …`. Most extend `eca`'s `ConfigurableActionBase` and expose a token-name field
to store their result.

## HTTP / server / response

| Action id | Purpose |
|---|---|
| `eca_helper_http_request` | Outbound HTTP request via `http_client` (method, URL, headers, body, cookies given as YAML); result → token. Admin-configured; can reach any URL (SSRF-capable, but gated behind ECA admin config). |
| `eca_helper_server_variable` | Read a value from `$_SERVER`/`$_COOKIE`/`$_SESSION`/`$_ENV`/`$_GET`/`$_POST` into a token. |
| `eca_helper_header_set` / `eca_helper_header_remove` | Set / remove an HTTP response header. |
| `eca_helper_cookie_set` | Queue a response cookie (applied by the response subscriber via `CookieHelper`). |
| `eca_helper_header_footer_tag` | Append a `<script>`, `<style>` or `markup` (inline_template) fragment to page `header`/`top`/`bottom` (rendered by the `PageAttachmentAlter` service). |
| `eca_helper_route_get` | Get the current route name / parameters. |

## Form events (use inside `eca_form` events)

| Action id | Purpose |
|---|---|
| `eca_helper_form_field_get_value` / `eca_helper_form_field_set_value` | Get / set a form element value by key. |
| `eca_helper_form_add_class` | Add a CSS class to a form element. |
| `eca_helper_form_attach_library` | Attach a library to the form. |
| `eca_helper_form_dumper` | Dump the form array for debugging. |

## Preprocess / render variables (use inside the `eca_helper_preprocess_hook` event)

| Action id | Purpose |
|---|---|
| `eca_helper_preprocess_get_value` / `eca_helper_preprocess_set_value` | Get / set a template variable by key. |
| `eca_helper_preprocess_set_class_value` | Add a CSS class to a variable's attributes. |
| `eca_helper_preprocess_attach_library` | Attach a library from preprocess. |
| `eca_helper_preprocess_remove_item` | Remove an item from a variables array. |
| `eca_helper_preprocess_dumper` | Dump the preprocess variables. |

## Data / files / storage

| Action id | Purpose |
|---|---|
| `eca_helper_json_encode_decode` | JSON encode or decode a value. |
| `eca_helper_date_format_to_unix` | Convert a formatted date string to a Unix timestamp. |
| `eca_helper_keyvaluestore_write` | Write to Drupal's key/value store. |
| `eca_helper_third_partyS_setting` | Get/set an entity's third-party settings. |
| `eca_helper_file_exist` / `eca_helper_file_read` / `eca_helper_file_write` | Check existence / read / write a file. |
| `eca_helper_file_entity_create` | Create a `file` entity from a path/URI. |
| `eca_helper_dumper` | Dump arbitrary data. |
| `eca_helper_status_messages_alter` | Read/alter Drupal status messages (pairs with the `eca_helper` event). |

## Quick Action — `eca_helper_quick_action`

Lets a developer register ad-hoc callables **without** writing a plugin. Create
`DRUPAL_ROOT/sites/eca/EcaActions.php` defining a function `ECAQuickActions()` that returns
`id => ['label' => …, 'callback' => …]` (a function name or closure) or
`['label' => …, 'service' => 'some.service', 'callback' => 'method']`. Pick the id in the
action's *Action* select, pass *Arguments* as YAML, and store the return value in a token.
The file is `require_once`-d and the chosen callable is invoked via `call_user_func_array`.
(This runs server-provided PHP chosen by an ECA administrator — a deliberate developer
extension point, comparable to enabling a PHP snippet.)

## Custom ECA events (`src/Plugin/ECA/Event/`)

| Event id | Fires on | Notes |
|---|---|---|
| `eca_helper` → `status_messages` | Drupal status messages being rendered | Tokens `[event:type]`, `[event:message]`; READ+WRITE so a model can rewrite messages. Backed by the `messenger` service decorator. |
| `eca_helper_file_download` → `private_file` | `hook_file_download()` for `private://` files | Event carries the URI, the `file` entity and current user; the model sets an access result — Allowed → download proceeds, Forbidden → `-1` (deny), otherwise abstain. |
| `eca_helper_preprocess_hook` → `preprocess` | every `hook_preprocess($hook)` | Lets a model alter any template's variables. |
