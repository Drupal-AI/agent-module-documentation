# Permissions

| Permission | Machine name | Grants |
|---|---|---|
| Generate media images with AI | `generate image with ai` | Shows the "Generate Image with AI" option (the `image_source` select and the whole generate UI) on media image add forms. |

Defined in `ai_media_image.permissions.yml`. Checked in `hook_form_alter`
(`$current_user->hasPermission('generate image with ai')`) before the AI elements are added — a
user without it sees the unmodified upload form. There is no separate "save" permission: any user
who can open the altered media add form and holds this permission can generate and save.

Each generation is a real call to the configured AI provider (billable at the provider), so treat
this as a spend-authorizing grant, not only an editorial one.

The **settings form** at `/admin/config/ai/ai_media_image` is instead gated by the AI module's
`administer ai` permission (see `configure/settings.md`).
