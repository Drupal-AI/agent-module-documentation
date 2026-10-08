<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Save-and-translate button + redirect (create_and_translate)

The whole module is two functions in `create_and_translate.module` plus one outbound path
processor. No config, no routes, no permissions, no external service. This page is the operational
detail behind [../start.md](../start.md).

## Install / enable

`drush en create_and_translate -y`. Core deps `content_translation`, `language`, `node`, `taxonomy`
must be present (all core). Nothing else to do — the button appears immediately on the relevant
forms. Uninstall is clean (functional test `testUninstallation` asserts this).

## Where the button appears

`create_and_translate_form_alter(&$form, FormStateInterface $form_state)`
(`create_and_translate.module:21`) fires on every form (`hook_form_alter`), but self-limits:

1. Resolves the current path with `\Drupal::service('path.current')->getPath()` →
   `Url::fromUserInput()`; returns early if `!$url->isRouted()`.
2. Acts only when `$url->getRouteName()` is one of exactly five routes:
   `node.add`, `entity.node.edit_form`, `entity.node.content_translation_add`,
   `entity.taxonomy_term.add_form`, `entity.taxonomy_term.edit_form`.
3. Requires the form object to be a `ContentEntityFormInterface` and the entity to be
   `$entity->isTranslatable()`. On a single-language site (nothing translatable) the button never
   appears.

When all pass it **clones** the existing submit action into a new action and re-labels it:

```php
$form['actions']['create_and_translate'] = $form['actions']['submit'];
$form['actions']['create_and_translate']['#value'] = t('Save and translate');
$form['actions']['create_and_translate']['#submit'][] = 'create_and_translate_submit';
```

Because it copies `['submit']`, the new button inherits core's validate/submit handlers (the entity
is really saved by core) and simply appends one extra submit callback. Rendered button id is
`edit-create-and-translate`.

## The redirect

`create_and_translate_submit(array &$form, FormStateInterface $form_state)`
(`create_and_translate.module:65`) runs after core's own submit handlers (entity already saved). It
guards on the triggering element id being `edit-create-and-translate`, then:

- if `$form_state->getValue('nid')` → `setRedirectUrl(Url::fromUri('internal:/node/{nid}/translations'))`
- if `$form_state->getValue('tid')` → `setRedirectUrl(Url::fromUri('internal:/taxonomy/term/{tid}/translations'))`

Both targets are internal core Content Translation overview tabs
(`entity.node.content_translation_overview` / `entity.taxonomy_term.content_translation_overview`);
core enforces access and existence on the destination, so this is a pure redirect, not an
access decision. Functional test `testButtonWorksAndRedirects` presses the button on `/node/add/test`
and asserts `addressEquals('/node/1/translations')`.

## Why the path processor exists

Core's entity forms often carry a `?destination=admin/content` query so that "Save" returns the
editor to the content list. That destination would override the module's translate redirect. The
service `create_and_translate.path_processor`
(`src/PathProcessor/CreateAndTranslatePathProcessor.php`), tagged `path_processor_outbound` at
priority `-10`, strips it:

```php
public function processOutbound($path, &$options = [], Request $request = NULL, BubbleableMetadata $bubbleable_metadata = NULL) {
  if (isset($options['query']['destination']) && stripos($options['query']['destination'], 'admin/content') > 0) {
    unset($options['query']['destination']);
  }
  return $path;
}
```

Note the `> 0` (not `!== FALSE`): it only unsets when `admin/content` appears at a non-zero
offset in the destination string. It never modifies `$path` itself.

## Operating notes

- Nothing to configure. The D7 branch had a per-content-type settings form and role permissions;
  the D8+ line (this one) has neither — `configure` is null, no `*.permissions.yml`.
- The `taxonomy` dependency is declared even though a site may only translate nodes; enabling this
  module pulls `taxonomy` in.
- Core range `^8 || ^9 || ^10 || ^11` spans four majors — verify the button renders on the target
  core, since it depends on core form-action array shape.
