<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# "Auphonic Normalize Audio" field rule

`src/Plugin/AiInterpolatorFieldRules/NormalizeAudio.php` — an **AI Interpolator field rule** plugin.

Annotation:

```php
@AiInterpolatorFieldRule(
  id = "ai_interpolator_auphonic_normalize_audio",
  title = @Translation("Auphonic Normalize Audio"),
  field_rule = "file",
  target = "file",
)
```

Extends `Drupal\ai_interpolator\PluginInterfaces\...AiInterpolatorFieldRule`, implements
`AiInterpolatorFieldRuleInterface` and `ContainerFactoryPluginInterface`. Injected services (via
`create()`): `auphonic.api`, `token`, `entity_type.manager`, `file_system`, `current_user`, `http_client`.

## Install & enable

```bash
drush en ai_interpolator_auphonic -y
```

Requires the `ai_interpolator` and `auphonic` modules; configure the Auphonic account on the parent module
first (`/admin/config/auphonic/settings`). Add the rule to a **file** field via the AI Interpolator UI on a
target file field, choosing a **base** file field as the audio source.

## Contract flags

- `allowedInputs()` → `['file']`; `field_rule`/`target` = `file`.
- `needsPrompt()` = FALSE, `advancedMode()` = FALSE, `placeholderText()` = "", `tokens()` = `[]`.

## `generate($entity, $fieldDefinition, $interpolatorConfig)`

- `$tries = 10`.
- For each item in `$entity->{$interpolatorConfig['base_field']}` that has an `->entity`:
  - `startProduction($fileEntity)` on `auphonic.api` (called with only the file — preset/title/options
    default; the account/preset config governs processing).
  - If a `data.uuid` came back, poll: `while status != 3 && tries > 0 { sleep(5); getProduction(uuid); }`.
  - If `data.output_files[0].download_url` exists, append value
    `['uri' => download_url, 'title' => output filename]`.
- Returns the array of values.

## `verifyValue($entity, $value, $fieldDefinition)`

Returns TRUE only if `$value['uri']` passes `FILTER_VALIDATE_URL`; else FALSE (invalid results are dropped).

## `storeValues($entity, $values, $fieldDefinition)`

1. Reads the **target field's** settings: destination = `token->replace($config['uri_scheme'] . '://' .
   rtrim($config['file_directory'], '/'))`.
2. `fileSystem->prepareDirectory($filePath, CREATE_DIRECTORY)`.
3. For each value: `$destination = $filePath . '/' . str_replace('.mp3', '.auphonic.mp3', $value['title'])`,
   then `auphonic.api::downloadProduction($value['uri'], $destination)` (streams the file to disk).
4. On HTTP `200`: creates a `file` entity (`uri`, `filename`, `filemime` via `mime_content_type()`, `uid` =
   current user, `status = File::STATUS_PERMANENT`), saves it, collects it.
5. `$entity->set($fieldDefinition->getName(), $fileEntities)` — replaces the target field's value with the
   downloaded, normalized files.

## Notes

- Blocking + slow: up to `10 × 5s` polling per file, plus upload/download; drive it from a queue/cron rather
  than an interactive request for real audio.
- The processed file is renamed with a `.auphonic.mp3` suffix and stored per the target field's own
  scheme/directory settings.
- `download_url` and output `filename` originate from the authenticated Auphonic API response, and
  `downloadProduction()` resolves them back against the fixed `auphonic.com` host.
