<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AuphonicProvider — the `audio_to_audio` AI provider

`src/Plugin/AiProvider/AuphonicProvider.php`, attribute `#[AiProvider(id: 'auphonic', label: 'Auphonic')]`.
Extends `Drupal\ai\Base\AiProviderClientBase`, implements `ContainerFactoryPluginInterface` and
`Drupal\ai\OperationType\AudioToAudio\AudioToAudioInterface`. Grabs `auphonic.api` and
`entity_type.manager` in `create()`.

## Provider contract methods

- `getSupportedOperationTypes()` → `['audio_to_audio']`.
- `getConfig()` → immutable `provider_auphonic.settings`.
- `isUsable($op=NULL, $caps=[])` → FALSE if `password` config is empty; else, if an `$op` is given, TRUE
  only when it is in the supported types.
- `getConfiguredModels($op=NULL, $caps=[])` → calls `auphonic.api::getPresets()` and maps each
  `data[].uuid => data[].preset_name`. **Your Auphonic presets are the "models."**
- `getApiDefinition()` → `Yaml::parseFile(<module>/definitions/api_defaults.yml)`.
- `getModelSettings($model_id, $generalConfig=[])` → returns `$generalConfig` unchanged.
- `setAuthentication($authentication)` → forwards `['username']` / `['password']` to the client's
  `setUsername()` / `setPassword()` (note: here `password` is used as a literal, bypassing the Key lookup).

## `audioToAudio()` — the actual operation

`audioToAudio(string|array|AudioToAudioInput $input, string $model_id, array $tags = [])`:

1. Normalize input:
   - `AudioToAudioInput`: writes `getAudioFile()->getBinary()` to a temp file; **requires**
     `$this->configuration['title']` (else `AiBadRequestException('Title is required for Auphonic')`);
     `$options = $this->configuration`.
   - raw array: `generateTemporaryFile($input['audio_binary'], 'audio.mp3')`, `title = $input['title']`,
     `options = $input['options'] ?? []`.
2. `startProduction($audio_input, $model_id, $title, $options)` — `$model_id` is the preset uuid.
3. **Poll**: up to `20` tries, `sleep(5)` each, `getProduction(uuid)` until `data.status == 3`.
4. Requires `data.output_files[0].download_url` (else `AiBadRequestException('No download url found …')`).
5. `downloadProduction(download_url)` → `getBody()->getContents()` = binary.
6. Returns `new AudioToAudioOutput([new AudioFile($binary, 'audio/'.format, filename)], $response['filename'], metadata)`.

Blocking call: worst case ~100s of polling in-request plus upload/download; run it out of a normal web
request (queue/cron) for real files.

## Temporary files

`generateTemporaryFile($binary, $filename)` saves the binary to `fileSystem->getTempDirectory().'/'.$filename`
with `FileExists::Replace`, creates a `file` entity with `status = 0` (temporary), saves it, and tracks it in
`$temporaryFiles`. The plugin **destructor** deletes every tracked temporary file when the plugin object is
destroyed.

## Notes

- `getClient()` returns the raw `AuphonicApi` for advanced callers.
- The docblock mentions "Mistral" in `isUsable()` — copy-paste leftover; behavior is as described.
- Config key `title` (default "My Audio Project") comes from `definitions/api_defaults.yml`'s
  `audio_to_audio.configuration`.
