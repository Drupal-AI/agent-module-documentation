<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YouTube Plus — settings & API key

## Where the key lives

A single Google API key is stored in the config object **`youtube_plus.settings`** under the key
**`api_key`**. Schema `config/schema/youtube_plus.schema.yml`:

- `api_key` — `string`
- `channels` — a `sequence` of mappings (`channel_id: string`, `type: bool`). This is legacy/unused
  by the current code path (channels are stored as `youtube_plus_channel` config entities, not in
  this sequence); the default config `config/optional/youtube_plus.settings.yml` ships
  `api_key: ""` and an empty `channels`.

## Setting it — `SettingsForm`

`src/Form/SettingsForm.php` (`extends FormBase`, form id **`ytp_settings`**), route
**`youtube_plus.settings`** at `/admin/config/services/youtube_plus/settings`, permission
**`administer site configuration`**, and the module's declared `configure` link.

- `buildForm()` renders one required field `api_key` (`#type => textfield`) whose default value is
  the currently stored key; the description links to
  `https://console.developers.google.com/apis/credentials`.
- `validateForm()` rejects a key containing a space (`strpos(... ' ')`).
- `submitForm()` writes `$config->getEditable('youtube_plus.settings')->set('api_key', $key)->save()`
  and redirects to the channel list (`entity.youtube_plus_channel.list`).

The key is consumed in `YouTubePlusUtils::__construct()` via
`$this->client->setDeveloperKey($config->get('api_key'))` on a `Google_Client`. The Google API
account must have the **YouTube Data API v3** enabled or every import fails with the "Did you enable
the Youtube Data API?" message.

## Notes

- The form uses `getEditable()` directly rather than `ConfigFormBase`/`config()`; there is no
  `config('youtube_plus.settings')` dependency tracking beyond the raw object.
- `ChannelForm` also reads `youtube_plus.settings:api_key` and blocks adding a channel (and shows a
  warning linking here) until a key is set.
