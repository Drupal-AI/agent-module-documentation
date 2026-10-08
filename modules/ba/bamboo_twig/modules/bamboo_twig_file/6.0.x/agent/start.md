<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bamboo Twig - File — agent index

Twig helpers for files: build an absolute file URL from a stream URI, and guess a file extension
from a MIME type. Submodule of **bamboo_twig**; no config, permissions or Drush.

- **The function + filter, signatures and examples** → [theming/file.md](theming/file.md)

`bamboo_file_url_absolute(uri)` (function) · `... | bamboo_file_extension_guesser` (filter).
Service `bamboo_twig_file.twig.file`. Enable: `drush en bamboo_twig_file -y`.
