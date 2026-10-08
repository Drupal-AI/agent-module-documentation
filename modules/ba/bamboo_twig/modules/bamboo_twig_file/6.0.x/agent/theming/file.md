<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File helpers

Class `File`, service `bamboo_twig_file.twig.file`.

- `bamboo_file_url_absolute(uri)` (function) → `file_url_generator->generateAbsoluteString(uri)`.
  Turns a stream URI (or shipped path) into an absolute web URL. If the string already starts with
  `http`, `https` or `/` it is returned unchanged; returns FALSE if no stream wrapper matches.
  ```twig
  <img src="{{ bamboo_file_url_absolute(node.field_image.entity.uri.value) }}">
  {# public://logo.png -> https://example.com/sites/default/files/logo.png #}
  ```
- `bamboo_file_extension_guesser` (filter) → best-guess extension for a MIME type (first match of
  `MimeTypes::getExtensions()`), or null.
  ```twig
  {{ 'image/png' | bamboo_file_extension_guesser }}   {# png #}
  {{ file.filemime.value | bamboo_file_extension_guesser }}
  ```
