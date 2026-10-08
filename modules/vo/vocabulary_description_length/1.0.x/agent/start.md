<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vocabulary Description Length — agent index

Renders the taxonomy **vocabulary** form's *Description* field as a `textarea` (multi-line)
instead of core's single-line `textfield`. That is the whole module: **no config, no schema,
no permissions, no services, no Drush, no configure route.**

- **The single hook + what it does / does not change (storage, front end)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Implements `hook_form_FORM_ID_alter()` for **`taxonomy_vocabulary_form`**, setting
  `$form['description']['#type'] = 'textarea'`.
- A vocabulary's description is stored (unchanged by this module) in the config object
  `taxonomy.vocabulary.<vid>` under the key `description` — an unlimited string in both cases.
- No effect on term descriptions or any other form.
