# Configure Rabbit Hole behaviors

There is **no central admin form**. Rabbit Hole injects a **"Rabbit Hole settings"** vertical
tab into entity-type/bundle edit forms (and, when enabled, individual entity edit forms) via
`hook_form_alter()` in `rabbit_hole.module` / `FormManglerService`. Which entity types get the
tab depends on which submodule is enabled (`rh_node` → nodes, `rh_media` → media, etc.).

## Settings (config entity `rabbit_hole.behavior_settings.*`)

Stored as `BehaviorSettings` config entities (schema `config/schema/behavior_settings.schema.yml`):

| Key | Meaning |
|---|---|
| `action` | Behavior plugin id: `display_page`, `access_denied`, `page_not_found`, `page_redirect` |
| `allow_override` | If true, individual entities may override the bundle default |
| `redirect` | Redirect target path/URL (supports tokens); used by `page_redirect` |
| `redirect_code` | HTTP code: 301, 302, 303, 304, 305, 307 |
| `redirect_fallback_action` | Action to use when the redirect target is empty/invalid |
| `entity_type_id`, `entity_id` | The entity type + bundle the setting applies to |

Default install config: `rabbit_hole.behavior_settings.default` and `.default_bundle`.

## Where it applies

- **Bundle level** — set the default action on a content type / vocabulary / media type form.
- **Entity level** — if `allow_override` is on, each entity's edit form exposes `rh_action`
  and (for redirects) `rh_redirect`, `rh_redirect_response`, `rh_redirect_fallback_action`
  base fields.

Read/write programmatically through the `rabbit_hole.behavior_settings_manager` service
(`BehaviorSettingsManager`). See [../api/services.md](../api/services.md).
