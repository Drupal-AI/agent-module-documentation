<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File MIME (filemime) — agent index

Feeds extra/override entries into the **extension→MIME-type map** core uses when guessing an
uploaded file's MIME type. Source of entries: a readable server `mime.types` file (config `file`)
and/or admin-typed lines (config `types`). Depends on core `file`. Config at
`/admin/config/media/filemime`. Version **2.0.2**. **Core `^11.2 || ^12` — Drupal 11.2+ only**
(the mechanism relies on a core event that did not exist earlier). No permission of its own, no
Drush, no plugin. Config is two strings, both empty on install.

## What it actually does (read the source, not the tagline)
- **Injection is via an event subscriber, not a decorated guesser.**
  `src/EventSubscriber/MimeTypeMapLoadedSubscriber.php` subscribes to core's
  `Drupal\Core\File\Event\MimeTypeMapLoadedEvent`. When core assembles its MIME map, the subscriber
  reads `filemime.settings`, parses the configured lines, and calls `$event->map->addMapping($type,
  $extension)` for each. It does **not** register its own `file.mime_type.guesser` or replace
  core's `ExtensionMimeTypeGuesser`; it mutates the map that guesser reads. (The class docblock says
  it calls `hook_file_mimetype_mapping_alter()` — that comment is stale; the real path is the
  event.)
- **Line format = standard `mime.types`.** `processMimeTypes()` splits each line on whitespace
  (`preg_split('/[\s]+/')`), treats a token starting with `#` as a comment (stops that line), takes
  token 0 as the MIME type and every later token as an extension mapped to it.
- **Two config keys, both plain strings** (`config/schema/filemime.schema.yml`):
  - `file` — a filesystem path; if `is_readable()` the file is read with `file()` and parsed.
  - `types` — a textarea of mapping lines, `explode("\n", …)` then parsed. Processed **after**
    `file`, so `types` **overrides** the file for the same extension.
- **Apply form re-stamps existing files.** `src/Form/FileMimeApplyForm.php` is a `ConfirmFormBase`
  that runs a batch over every `file_managed` row, but only for **local** stream schemes
  (`StreamWrapperInterface::LOCAL`); for each it re-runs `file.mime_type.guesser`->`guessMimeType()`
  and, if the result differs, `$file->setMimeType()` + `save()`, logging each change to the
  `filemime` channel. This makes a map change retroactive.
- **Config form uses `#config_target`.** `src/Form/FileMimeConfigForm.php` (`ConfigFormBase`) binds
  the `file` textfield and `types` textarea straight to `filemime.settings`, and shows whether the
  configured `file` path is currently readable.

## Access, surface, and integration facts
- **Both routes require core `administer site configuration`** (`filemime.routing.yml`): the
  settings form and the apply form. There is **no** `filemime.permissions.yml` and no module
  permission. Treat configuring this as an admin-trust operation.
- **Menu/tasks:** a config link under *Configuration → Media* (`filemime.links.menu.yml`) and two
  local tasks, *Configure* and *Apply* (`filemime.links.task.yml`).
- **Migration:** `migrations/filemime_settings.yml` maps D7 variables `filemime_file` /
  `filemime_types` into `filemime.settings`.
- **Uninstall restores core's map** (the subscriber simply stops adding entries).

## Why the recorded type matters (and the caveat that runs opposite to the module's purpose)
- The recorded type becomes the **`Content-Type` header on download**, deciding display-vs-download
  for a PDF, whether a font loads, whether a video plays. A wrong type is a file that "does not
  work" for reasons invisible from the Drupal UI.
- **MIME type is a claim, not a fact.** A rule forces a label onto bytes nobody inspected. A file
  recorded as `image/png` need not be a PNG. Anything downstream that trusts the recorded type
  rather than validating the bytes — an image processor, an inline viewer, a client app — is
  trusting the uploader. **Extension-based upload validation, not this map, is the real upload
  control**; this module changes the label, not the contents.

## Files
- `src/EventSubscriber/MimeTypeMapLoadedSubscriber.php` — the injection (event → `addMapping`).
- `src/Form/FileMimeConfigForm.php` — settings form (`file`, `types`; `#config_target`).
- `src/Form/FileMimeApplyForm.php` — confirm form + batch re-stamping `file_managed`.
- `filemime.services.yml` — registers the subscriber (autowired/autoconfigured).
- `filemime.routing.yml` — two routes, both `administer site configuration`.
- `config/schema/filemime.schema.yml`, `config/install/filemime.settings.yml` — schema + empty
  defaults.
- `migrations/filemime_settings.yml` — D7 variable → config migration.

## Solution types
- `agent/config/` — configuring the map, the `mime.types` file vs override lines, and running Apply.
