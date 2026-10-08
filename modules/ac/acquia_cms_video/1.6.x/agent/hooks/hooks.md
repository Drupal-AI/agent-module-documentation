# Hooks and install/update glue

All PHP in the module lives in `.module` and `.install`. There are no services, routes, or controllers.

## `acquia_cms_video_content_model_role_presave_alter(RoleInterface &$role)` — `.module`

Implements `hook_content_model_role_presave_alter()`, a **custom hook invoked by `acquia_cms_common`**
while it builds/presaves the distribution's content roles. It mutates the passed role in place:

- `content_author` → grants `create video media`, `edit own video media`, `delete own video media`
- `content_editor` → grants `edit any video media`, `delete any video media`

This is the mechanism that wires the Video permissions to editors without a config dependency. Integrators
implementing content roles outside Acquia CMS won't see this fire (nothing invokes the hook) and must
grant the permissions themselves.

## `acquia_cms_video_install($is_syncing)` — `.install`

`hook_install`. When **not** importing config (`!$is_syncing`), it calls
`_acquia_cms_common_editor_config_rewrite()` (a helper provided by `acquia_cms_common`) to rewrite the
site's text-editor/CKEditor configuration so the media-library video embed is available. During a config
sync it does nothing (config is already coming in).

## `acquia_cms_video_update_8001()` — `.install`

Runs only if `acquia_cms_site_studio` is enabled. Scans `config/pack_acquia_cms_video/*.yml` and, for each
enabled Site Studio template lacking `dependencies.enforced.module`, sets it to
`[acquia_cms_video, acquia_cms_site_studio]` so the templates are removed cleanly when either module is
uninstalled.

## `acquia_cms_video_update_8002()` — `.install`

Also gated on `acquia_cms_site_studio`. Deletes any config object in `config/pack_acquia_cms_video` that is
saved but has neither a `uuid` nor an `id` (invalid leftover data), logging each deletion to the
`acquia_cms_video` channel.

## Note on the Site Studio pack

`config/pack_acquia_cms_video/` holds a Cohesion component (`cpt_video_media`) and content templates
(`media_video_embedded` / `media_video_full` / `media_video_video_component`) plus an icon selection. These
install only in a Site Studio context; the update hooks above maintain them. They are not required for the
plain Video media type to work.
