# Brightcove hooks & entity behavior

The module does not define a public `*.api.php`; these are the hooks **it implements** (in
`brightcove.module`) — useful to know when extending or debugging.

| Hook | Behavior |
|---|---|
| `hook_cron` | Runs the Brightcove→Drupal sync queues, unless `brightcove.settings:disable_cron` is true. |
| `hook_entity_extra_field_info` | Adds pseudo-fields to Brightcove video/playlist displays. |
| `hook_ENTITY_TYPE_view` (`brightcove_video`, `brightcove_playlist`) | Renders the player / playlist embed on the entity view. |
| `hook_theme` | Registers Brightcove render templates (`templates/`). |
| `hook_theme_suggestions_brightcove_video_alter` | Adds template suggestions for videos. |
| `hook_entity_access` | **Forbids** update/delete of the `brightcove_video_tags` vocabulary and its terms (they are module-managed). |
| `hook_ENTITY_TYPE_delete` (`file`) | Cleans up `brightcove_video` poster/thumbnail references when a file is deleted. |

## Extension points

- Talk to Brightcove via `BrightcoveUtil::getCmsApi()/getDiApi()/getPmApi()` (see api/api.md) rather
  than re-authenticating.
- Alter sync/callback queue processing through the standard queue worker plugins the module enqueues.
- `brightcove.parameter_converter.subscription` and the `_brightcove_csrf_callback_access_check`
  access checker are services you can reuse/observe but not typical extension targets.

There are no plugin types for third parties to implement in this module (the `BrightcoveEntityType`
annotation is internal to the module's own entity definitions).
