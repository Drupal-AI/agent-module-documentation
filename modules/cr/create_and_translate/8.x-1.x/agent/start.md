<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create and translate (create_and_translate) — agent index

Adds a second submit button, **"Save and translate"**, to node and taxonomy-term add/edit forms so
that saving lands the editor on the entity's translation-overview tab instead of the saved entity.
The whole feature is one `hook_form_alter()` in `create_and_translate.module`: on a fixed list of
five routed forms (`node.add`, `entity.node.edit_form`, `entity.node.content_translation_add`,
`entity.taxonomy_term.add_form`, `entity.taxonomy_term.edit_form`) whose form object is a
`ContentEntityFormInterface` and whose entity `isTranslatable()`, it clones the existing `submit`
action into a new `create_and_translate` action button and appends the `create_and_translate_submit`
callback. That callback runs after core saves the entity and, keyed off the button id
`edit-create-and-translate`, sets a redirect to `internal:/node/{nid}/translations` (when the form
has an `nid` value) or `internal:/taxonomy/term/{tid}/translations` (when it has a `tid`).

A single supporting service, the outbound path processor `create_and_translate.path_processor`,
strips the `destination` query argument from generated URLs when that destination points at
`admin/content`, so core's post-save "return to content list" destination does not override the
translate redirect. There is no config UI, no settings, no external service, and no API keys — the
module is purely a form/redirect ergonomic tweak on top of core Content Translation.

- **Install, the button/redirect mechanism, the path processor, and operating notes** →
  [behavior/save-and-translate.md](behavior/save-and-translate.md)

- **Depends on:** `content_translation`, `language`, `node`, `taxonomy` (all core). The `taxonomy`
  dep is broader than the feature strictly needs and is pulled onto sites that do not use taxonomy.
- **Core:** `^8 || ^9 || ^10 || ^11` (four majors — verify on the target core; surface is tiny).
- **Package:** none declared in info.yml. Installed/enabled at **8.x-1.5**.
- **Configure route / settings page:** none (`configure` null). D7 had a per-content-type settings
  form and permissions; the D8+ line has neither.
- **Permissions:** none provided. **Drush:** none. **Plugin types:** none. **Config schema:** none.
- **No security surface.**

## Key facts (real machine names)
- **Hook:** `create_and_translate_form_alter(&$form, FormStateInterface $form_state)` —
  `create_and_translate.module:21`. Reads the current path via the `path.current` service and
  resolves it with `Url::fromUserInput()`; only acts on routed URLs whose route is in the five-name
  list above.
- **Added form element:** `$form['actions']['create_and_translate']` (a clone of `['submit']`),
  `#value` = `t('Save and translate')`, button id `edit-create-and-translate`.
- **Submit callback:** `create_and_translate_submit(array &$form, FormStateInterface $form_state)` —
  `create_and_translate.module:65`. Redirects to `internal:/node/{nid}/translations` or
  `internal:/taxonomy/term/{tid}/translations` using `$form_state->getValue('nid')` /
  `getValue('tid')`. Both targets are internal (Content Translation's `entity.*.content_translation_overview`
  tab); core enforces access on the destination.
- **Service:** `create_and_translate.path_processor` →
  `Drupal\create_and_translate\PathProcessor\CreateAndTranslatePathProcessor`
  (`src/PathProcessor/CreateAndTranslatePathProcessor.php`), tagged `path_processor_outbound`
  priority `-10`, implements `OutboundPathProcessorInterface`. `processOutbound()` unsets
  `$options['query']['destination']` when `stripos($destination, 'admin/content') > 0`.
- **Routes / permissions / plugins / config keys / drush:** none of its own.
