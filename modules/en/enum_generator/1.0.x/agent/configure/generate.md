<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generating an enum from a vocabulary

**Form:** `/admin/structure/enum-generator/taxonomy` (`access enum generator`).

Fields:
- **Namespace** — target namespace for the file (must NOT start with `\`; validated). Default `Drupal\my_module\Enum`.
- **Vocabulary** — the taxonomy vocabulary whose terms become cases/constants.
- **Generation Type** — `enum` (PHP 8.1 enum) or `const` (class with constants).
- **Backing Type** — `string` (default; Drupal term ids are strings) or `int` (ids cast to int).

On submit (`TaxonomyGeneratorForm`): terms are loaded via `loadByProperties(['vid' => $vid])` and sorted by label; the object is named `Studly(vocabLabel)Term`; each case name is `UPPER_SNAKE(term label)` (prefixed `_` if it begins with a digit) with the term id as value and a doc comment naming the term. The code is rendered by `nette/php-generator`, written to `temporary://<Name>.php`, and returned as a `BinaryFileResponse` (`text/plain`, `Content-Disposition: attachment`). Reload the page to generate another. The generated file is a developer artifact — drop it into a module; nothing is installed or changed on the site.
