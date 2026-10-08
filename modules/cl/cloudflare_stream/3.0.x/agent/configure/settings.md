# Configure Cloudflare Stream

## Credentials — config object `cloudflare_stream.settings`
Set at `/admin/config/media/cloudflare-stream/settings` (route
`cloudflare_stream.admin_config.settings`, permission `administer cloudflare stream settings`).

| Key | Type | Notes |
|---|---|---|
| `api_token` | string | Cloudflare API token (Bearer). **Required.** Verified live on save against `https://api.cloudflare.com/client/v4/user/tokens/verify` — an invalid/inactive token blocks the form. |
| `account_id` | string | Cloudflare account id (used in the Stream API URL). Required. |
| `subdomain` | string | Customer subdomain, first label only (e.g. `customer-abc1234`); builds playback URLs. Required. |
| `debug_messages` | bool | If on, Cloudflare API error responses are shown to the user via Messenger (otherwise only logged to the `cloudflare_stream` channel). |

The submit handler strips all whitespace from token/account/subdomain before saving. Set via Drush:
```
drush cset cloudflare_stream.settings account_id "<id>" -y
drush cset cloudflare_stream.settings subdomain "customer-abc1234" -y
```

## Permissions (`cloudflare_stream.permissions.yml`)
- `access cloudflare stream config page` — reach the config landing page `/admin/config/media/cloudflare-stream`.
- `administer cloudflare stream settings` — edit the credentials form.

Both only reach the module's own admin config; neither grants content or upload rights (those follow
normal field/entity edit access). Video upload happens through the standard field widget on whatever
entity form carries a `cloudflarevideo` field, gated by that entity's edit access — there is no
separate upload route.

## Add a video field
1. On a content type: *Manage fields → Add field → Cloudflare Video* (`cloudflarevideo`).
2. Use the *Cloudflare Video* widget (`cloudflarevideo_default`, extends the core file widget).
3. On *Manage display* pick the video formatter (`cloudflarevideo_default`) and set:
   `controls`, `muted`, `autoplay`, `loop`, `width`, `height`; or the thumbnail formatter.

## Media type (optional)
Create a Media type with source **Cloudflare Stream** (source plugin `cloudflare_stream`). The source
creates its source field limited to extensions:
`mp4 mkv mov avi flv ts tsv tsa mpg mpeg m2p ps mxf lxf gxf 3gp webm mpg qt`, and wires the
`cloudflarevideo_default` formatter into the view display. Needed if you want the Sync submodule.

## Config schema (`config/schema/cloudflare_stream.schema.yml`)
- `cloudflare_stream.settings` (the four keys above).
- `field.formatter.settings.cloudflarevideo_default` — controls/muted/width/height/autoplay/loop.
- `field.storage_settings.cloudflarevideo` / `field.field_settings.cloudflarevideo` — inherit the
  core file field storage/field settings.
