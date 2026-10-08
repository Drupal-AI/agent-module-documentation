<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Enum Generator is a developer tool that turns a Drupal taxonomy vocabulary's terms into a ready-to-use PHP file — either a PHP 8.1 `enum` or a class with constants — so code can reference term ids by meaningful names instead of magic numbers. It uses `nette/php-generator` to build the file and returns it as a browser download.

---

An admin form at `/admin/structure/enum-generator/taxonomy` (permission `access enum generator`, restrict access) lets you pick a vocabulary, choose enum vs class constants, and choose a string or integer backing type. On submit it loads the vocabulary's terms (sorted by label), makes an UPPER_SNAKE case name from each term label (prefixing `_` if it starts with a digit), sets the term id as the value, adds a doc comment per case, wraps it in the chosen namespace, writes the result to `temporary://` and streams it back as a `text/plain` attachment. The requested namespace is validated to not start with a backslash.

Setup: enable the module (requires taxonomy), grant `access enum generator`, and use the form to generate a file per vocabulary. There is no runtime effect on the site — output is a downloaded source file for developers to drop into a module.

---

- Generate a PHP `enum` from a taxonomy vocabulary
- Generate a class-with-constants instead of an enum
- Choose string-backed enum cases (Drupal ids are strings)
- Choose integer-backed cases (ids cast to int)
- Set the target PHP namespace for the generated file
- Get UPPER_SNAKE case names from term labels
- Download the generated file as a `.php` attachment
- Reference term ids by name in custom code
- Regenerate after adding/renaming terms
- Restrict access with the `access enum generator` permission
- Add per-case doc comments referencing the source term
- Avoid magic taxonomy-id numbers in modules
- Generate a file per vocabulary as needed
- Drop the generated enum into a custom module
- Validate the target namespace on submit
- Handle term labels starting with a digit (prefixed `_`)
