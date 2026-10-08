<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform IBAN Field (webform_iban_field) — agent index

Adds an **IBAN element** to Webform. Submodule of
[iban_field](../../../../2.0.x/agent/start.md). No config, no permissions, no schema, no Drush.

Key facts:
- Info name is *IBAN Field Webform element*; declared dependency is `drupal:webform` (the shared
  IBAN validation comes from the parent module, so enable `iban_field` too).
- Two classes:
  - `src/Element/WebformIbanElement.php` — the **render element** (`#type`), defining the input and
    its validation;
  - `src/Plugin/WebformElement/WebformIbanElement.php` — the **Webform element plugin**, which is
    what makes it appear in *Add element* with a label and category and exposes its settings.
- Once enabled the element is available in every webform; there is nothing to configure globally.

```bash
drush en iban_field webform_iban_field -y
drush cr
# Confirm the element is registered:
drush php:eval '
print implode("\n", array_keys(\Drupal::service("plugin.manager.webform.element")->getDefinitions()));' | grep -i iban
```

Note: as with the parent module, validation happens at the **element** level — values injected via
the Webform API or an import are not re-validated.
