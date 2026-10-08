<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the oEmbed provider & settings

## Config object

All persistent state is in `ckeditor_media_embed.settings` (schema type `config_object`):

| Key | Default | Meaning |
|---|---|---|
| `embed_provider` | `http://ckeditor.iframe.ly/api/oembed?url={url}&callback={callback}` | oEmbed endpoint template. `{url}` and `{callback}` tokens are substituted per request. |
| `ckeditor_version` | `''` | Pin the CKEditor version the downloaded plugin targets. Empty = parse core's `core.libraries.yml` `ckeditor5.version`. |
| `plugins_version_installed` | `''` | Version of the plugin JS last downloaded by `drush ckeditor_media_embed:install`. Written by the install command; used by `hook_requirements` to detect a mixed-version state. |

Read/write it:

```bash
drush cget ckeditor_media_embed.settings
drush cset ckeditor_media_embed.settings embed_provider '//noembed.com/embed?url={url}&callback={callback}' -y
```

## Settings form

- Route: `ckeditor_media_embed.ckeditor_media_embed_settings_form`
- Path: `/admin/config/media/ckeditor-media-embed/settings` (menu: *Configuration → Media*)
- Permission: `administer filters` (core; the module defines none of its own)
- The form exposes **only** `embed_provider` (the *Provider URL* textfield). It validates the
  URL with `UrlHelper::isValid()` after stripping the `{url}`/`{callback}` tokens; a leading
  `//` is treated as `http://` for validation.
- If the CKEditor plugin JS is **not** installed, `buildForm()` returns an empty form and shows
  the "run `drush ckeditor_media_embed:install`" warning instead of the provider field.

## Provider URL examples

| Service | Template |
|---|---|
| Iframely (default) | `//iframe.ly/api/oembed?url={url}&callback={callback}&api_key=MYTOKEN` |
| Noembed | `//noembed.com/embed?url={url}&callback={callback}` |
| embed.ly | `//api.embed.ly/1/oembed?url={url}&callback={callback}&key=MYTOKEN` |

Only **one** provider is active at a time; use a proxy (Iframely/Noembed) to cover many
services, or a single service's oEmbed endpoint to restrict embeds to it. Iframely over HTTPS
requires an account/API token.

## Two more things must be wired up (not on this form)

1. **The filter** `filter_ckeditor_media_embed` ("Convert Oembed tags to media embeds") must be
   enabled on the text format — otherwise stored `<oembed>` tags render as-is. See
   [../plugins/media-embed.md](../plugins/media-embed.md).
2. **The plugin JS** must be downloaded — see [../drush/commands.md](../drush/commands.md).
