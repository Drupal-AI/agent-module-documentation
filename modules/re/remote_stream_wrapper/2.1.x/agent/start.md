<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Remote Stream Wrapper — agent index

Makes `http://` and `https://` real Drupal stream-wrapper schemes, so a managed `file` entity's
URI can *be* the remote URL and the bytes are never copied to local disk.

**Nothing to configure.** No settings form, no `configure` route (`configure: null`), no
permissions, no config schema, no plugin types, no Drush commands, no module dependencies.
Install requirement: PHP **cURL** (`hook_requirements()` blocks install without it).

- **Services, schemes, helper functions, creating remote file entities, read-only limits** →
  [api/stream-wrapper.md](api/stream-wrapper.md)
- **Image styles over remote originals: entity-class override, derivative URIs, routes** →
  [api/image-styles.md](api/image-styles.md)

Key facts:

- Services: `stream_wrapper.http` and `stream_wrapper.https` (both
  `Drupal\remote_stream_wrapper\StreamWrapper\HttpStreamWrapper`, tag `stream_wrapper`), plus
  `file.mime_type.guesser.http` (`HttpMimeTypeGuesser`, tag `mime_type_guesser`, **priority 10**).
- "Is this remote?" is decided by `instanceof RemoteStreamWrapperInterface`, exposed as the
  global functions `file_is_scheme_remote()`, `file_is_uri_remote()`, `file_is_wrapper_remote()`.
- The wrapper is **read-only**: `stream_open()` accepts only `r`/`rb`/`rt`, and
  `ReadOnlyPhpStreamWrapperTrait` makes writes/`unlink()`/`mkdir()`/`rename()` warn and return
  FALSE. `realpath()` returns FALSE; `getExternalUrl()` returns the URI unchanged.
- `hook_entity_type_alter()` re-classes `image_style` to
  `Drupal\remote_stream_wrapper\Entity\ImageStyle` — this is site-wide once the module is on.
