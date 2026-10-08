<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FileToText — extract file text via Apache Tika

Class `Drupal\entity_to_text_tika\Extractor\FileToText`
(`modules/entity_to_text_tika/src/Extractor/FileToText.php`), service id
**`entity_to_text_tika.extractor.file_to_text`**. Constructor args
(`entity_to_text_tika.services.yml`): `@settings`, `@file_system`, `@logger.factory`,
`@event_dispatcher`. Wraps the `vaites/php-apache-tika` `Client`.

## Connection settings (settings.php)

Read via `Settings::get('entity_to_text_tika.connection')`:

```php
$settings['entity_to_text_tika.connection']['host'] = 'tika';
$settings['entity_to_text_tika.connection']['port'] = '9998';
```

There is no config form — the connection is defined only in `settings.php`. If `host`/`port` are not both
set, `fromFileToText()` returns `''` without calling Tika.

## Methods

- `fromFileToText(File $file, string $langcode = 'eng'): string`
  1. Reads the connection settings; returns `''` if not configured.
  2. `getClient($host, $port)` builds a Tika **web client** (`Client::make(...)`, timeout 60s) and calls
     `setOCRLanguage($langcode)`.
  3. Dispatches `PreProcessFileEvent` (`EntityToTextTikaEvents::PRE_PROCESS_FILE`) so subscribers can swap
     the client or file; then uses the (possibly altered) client + file.
  4. Resolves the file's real path via `file_system->realpath($file->getFileUri())` and calls
     `$web_client->getText($absolute_path)`.
  5. On any `\Exception`, logs a `notice` to the `entity_to_text` channel (fid, path, message) and returns
     `''`.
- `getClient(?string $param1, int|string|null $param2, array $options = [], bool $check = TRUE): Client`
  — lazily builds and caches the client (timeout 60s).
- `setClient(Client $client): void` — inject a pre-built client (used in tests / advanced setups).

## PreProcessFileEvent

`Drupal\entity_to_text_tika\Event\PreProcessFileEvent` (`src/Event/PreProcessFileEvent.php`) carries the
`Client` and `File`; getters `getClient()` / `getFile()`. Event name constant
`EntityToTextTikaEvents::PRE_PROCESS_FILE = 'entity_to_text_tika.preprocess_file'`
(`src/Event/EntityToTextTikaEvents.php`). Subscribe to tune client options (headers, timeout, etc.) or
substitute the file before OCR.

## Usage

```php
$file = $file_item->entity;
$body = \Drupal::service('entity_to_text_tika.extractor.file_to_text')
  ->fromFileToText($file, 'eng+fra');
```

## Notes

- Uses the Tika **web** client (HTTP to the configured host/port); intended for an internal/trusted Tika
  server reachable from the web container.
- No access checks on `$file`; the caller supplies the file to process.
