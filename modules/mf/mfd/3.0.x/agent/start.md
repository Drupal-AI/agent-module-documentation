<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multilanguage Form Display (mfd) - agent index

Adds other-language translatable field inputs to the node form; saves all translations in one submit.
Deps: `content_translation`, `language`, `locale` (+ composer `tribus-studio/versioncontrol`).

Key facts:
- Field plugins `src/Plugin/Field/**` provide the `multilingual_form_display` type/widget/formatter.
- `mfd.module` `hook_form_node_form_alter()` adds `mfd_form_submit` for users with `edit multilingual form`;
  it writes `<field>_<langcode>` values into each existing translation.
- Guard validators: block mfd field translatable, block adding to non-translatable bundle, block disabling
  translation while mfd field exists.
- Permissions: `edit multilingual form`, `show multilingual translate table`. Version dir `3.0.x`.
