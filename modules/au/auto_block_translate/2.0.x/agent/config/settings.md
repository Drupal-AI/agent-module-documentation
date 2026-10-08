<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration (all inherited from Auto Node Translate)

This module ships **no `config/install`, no `config/schema`, no settings form of its own**. Its
`.info.yml` `configure:` key points at the parent module's settings route
**`auto_node_translate.settings`** (`/admin/config/auto_node_translate/config`).

## Install / enable

```
composer require drupal/auto_block_translate
drush en auto_block_translate -y
```

Pulls in `drupal/auto_node_translate:^3`; core `content_translation` and `auto_node_translate` are
hard dependencies (`.info.yml`). Enable/translate access needs core content-translation enabled and
the block bundle set translatable.

## What you configure (in the parent module)

All of the following live in the config object **`auto_node_translate.settings`**, edited on the
parent module's settings form — this module only reads from it:

- **`default_api`** — the active translation provider plugin id (id from
  `plugin.manager.auto_node_translate_provider`). The block form's `validateForm()` blocks a run if
  this is empty. Also written into each block's revision log.
- The provider's own credentials / endpoint / options (e.g. API key, region) — defined and stored by
  the parent provider plugin, not here.
- **Text field types** and **excluded fields** — read via `Translator::getTextFields()` and
  `Translator::getExcludeFields()`; they decide which block fields get translated vs copied/skipped.

## Permissions

No `*.permissions.yml` in this module. Auto-translation access is decided by
`AutoBlockTranslateAccessCheck` (see [../api/translate.md](../api/translate.md)): core
content-translation access, else the parent-defined permission **`auto translate block_content`**
(or the bundle-specific variant). Grant that permission to the roles that may auto-translate blocks.

## Operating it

1. Set `default_api` (and its credentials) on the parent settings page.
2. Make the custom block type translatable (core content translation).
3. Create/edit a block in a source language.
4. Open the block's **Automatic Translation** tab (or the "Auto Translate" operation), tick the
   target language(s), submit **Translate**.
5. The module writes/updates each selected translation as a new block revision.
