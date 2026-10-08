<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Big Pipe Paragraphs (big_pipe_paragraphs) — agent index

Defers rendering of selected **paragraphs** in an `entity_reference_revisions` field to **BigPipe
lazy-builder placeholders**, so the page shell ships first and those paragraphs stream in after.
No entities, no permissions, no schema, no Drush. Package `Custom`. Version **1.0.2**. Core
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

Dependencies (info.yml): core **`big_pipe`**, core **`dynamic_page_cache`**, contrib
**`paragraphs`**, contrib **`preprocess`** (the plugin host). Composer: `drupal/preprocess ^2.0`,
`drupal/paragraphs ^1.6`.

## What it actually provides

- One **service** `big_pipe_paragraphs.lazy_builder` → class `LazyParagraphBuilder`
  (`src/LazyParagraphBuilder.php`), a `TrustedCallbackInterface`. Its `lazyBuild($paragraphId,
  $viewMode)` is the `#lazy_builder` callback; plus config helpers `bundleEnabled()`,
  `getOffset()`, `getSkipBundles()`.
- One **Preprocess plugin** `big_pipe_paragraphs.lazy_builder` (annotation `@Preprocess`, hook
  `field`) → `src/Plugin/Preprocess/LazyBuilder.php`. It rewrites qualifying field items into
  `#lazy_builder` + `#create_placeholder => TRUE`.
- One **route/form**: `big_pipe_paragraphs.settings` at `/admin/config/system/big-pipe-paragraphs`
  (`_permission: administer site configuration`, `_admin_route: TRUE`), form
  `Form\SettingsForm`; menu link under *Configuration → System*.
- One **config object**: `big_pipe_paragraphs.settings` (key `entity_type`). `config/install`
  ships it empty; there is **no `config/schema/`** in this project.

## How the mechanism fits together

`LazyBuilder::preprocess()` (field preprocess) fires for every field render. It bails unless
`#field_type === 'entity_reference_revisions'` and the storage `target_type === 'paragraph'`,
and unless the host entity's (type, field, bundle) is enabled in config. For each item at
`delta >= offset` whose paragraph bundle is not in `skip_bundles`, it replaces `$item['content']`
with `['#lazy_builder' => ['big_pipe_paragraphs.lazy_builder:lazyBuild', [$paragraph->id(),
$view_mode]], '#create_placeholder' => TRUE]`. BigPipe/Dynamic Page Cache then render the
placeholder out-of-band via `lazyBuild()`, which loads the paragraph by id and renders it with the
`paragraph` view builder.

## Solution docs

- **Settings form, config object & keys, route/permission** →
  [config/settings.md](config/settings.md)
- **The Preprocess plugin + the lazy-builder service (mechanism, offset/skip logic, view modes,
  gotchas)** → [plugins/lazy_builder.md](plugins/lazy_builder.md)
