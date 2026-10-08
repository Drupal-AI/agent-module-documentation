<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prepopulate — agent index

Fills form elements from the `edit[...]` query string: `/node/add/article?edit[title][widget][0][value]=Hi`.
**No settings form, no configure route (`configure: null`), no permissions, no Drush, no plugins,
no config schema.** Everything the module does lives in three places: the URL syntax, the
`prepopulate.populator` service, and one alter hook.

- **Write a prepopulate URL for a field / find the right `edit[...]` path** →
  [configure/url-syntax.md](configure/url-syntax.md)
- **Call the populator service yourself, and the exact whitelist / value rules** →
  [api/populate-service.md](api/populate-service.md)
- **Allow an element type that is not whitelisted** →
  [hooks/whitelist-alter.md](hooks/whitelist-alter.md)

Key facts:

- Trigger: `prepopulate_form_alter()` only acts when the request has an `edit` **query** parameter;
  it adds `prepopulate_after_build()` to `#after_build` and bails when `$form_state->isRebuilding()`.
- Whitelist (default 18 types): `container`, `date`, `datelist`, `datetime`, `entity_autocomplete`,
  `email`, `fieldset`, `inline_entity_form`, `language_select`, `machine_name`, `number`, `path`,
  `select`, `tel`, `textarea`, `text_format`, `textfield`, `url`. **`radios` and `checkboxes` are
  excluded on purpose** (a link must not be able to tick an admin checkbox).
- Submodule: `og_prepopulate` (needs `drupal/og`) — see
  [../../modules/og_prepopulate/2.5.x/agent/start.md](../../modules/og_prepopulate/2.5.x/agent/start.md).
