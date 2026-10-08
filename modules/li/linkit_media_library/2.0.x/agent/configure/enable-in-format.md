<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable media linking in a text format

Three things must line up: a **Linkit profile with a media matcher**, a **text format** with the
Linkit filter and the Linkit CKEditor 5 extension, and (if HTML is restricted) the `target`
attribute allowed on `<a>`.

## 1. Linkit profile with an `entity:media` matcher

Profiles are `linkit.linkit_profile.<id>` config entities. The matchers are keyed by UUID:

```yaml
# linkit.linkit_profile.default
label: Default
id: default
matchers:
  556010a3-…:
    id: 'entity:node'
    uuid: 556010a3-…
    settings: { metadata: '…', bundles: {}, group_by_bundle: false, substitution_type: canonical, limit: 100 }
    weight: 0
  9c1f…:
    id: 'entity:media'
    uuid: 9c1f…
    settings: { metadata: '…', bundles: { document: document }, substitution_type: media, limit: 100 }
    weight: 1
```

Add one programmatically (this is what the module's `hook_install()` does for `default`):

```php
$profile = \Drupal::entityTypeManager()->getStorage('linkit_profile')->load('default');
$matcher = \Drupal::service('plugin.manager.linkit.matcher')->createInstance('entity:media');
$profile->addMatcher($matcher->getConfiguration());
$profile->save();
```

Restrict which media types the library offers by setting the matcher's `settings.bundles`
(e.g. `['document' => 'document']`). Leave it empty to offer **all** media types —
`getDynamicPluginConfig()` then loads every `media_type` id.

The matcher's `settings.substitution_type` becomes the `data-entity-substitution` attribute on the
inserted link (default `media` when unset).

> On a site where the module's `hook_install()` never ran (e.g. it was enabled without install
> hooks), `linkit.linkit_profile.default` will have **no** `entity:media` matcher and the button
> will not appear. Check with `drush cget linkit.linkit_profile.default matchers`.

## 2. Text format + editor

For the format (e.g. `full_html`):

```bash
# the "Linkit URL converter" filter must be enabled
drush cget filter.format.full_html filters.linkit
# the Linkit CKEditor 5 extension must be enabled and pointed at a profile
drush cget editor.editor.full_html settings.plugins.linkit_extension
```

Programmatically:

```php
$format = \Drupal::entityTypeManager()->getStorage('filter_format')->load('full_html');
$format->setFilterConfig('linkit', ['status' => TRUE, 'weight' => 0, 'settings' => []]);
$format->save();

$editor = \Drupal::entityTypeManager()->getStorage('editor')->load('full_html');
$settings = $editor->getSettings();
$settings['plugins']['linkit_extension'] = ['linkit_enabled' => TRUE, 'linkit_profile' => 'default'];
$editor->setSettings($settings)->save();
```

Via the UI (*Configuration → Content authoring → Text formats and editors → Full HTML*):

1. Under **CKEditor 5 plugin settings → Drupal link**, tick **Linkit enabled** and pick a profile.
2. Under **Enabled filters**, tick **Linkit URL converter**.
3. Save.

The `link` button must of course be in the toolbar — the media-library button lives *inside* the
link balloon/dialog, not on the toolbar.

## 3. Allowed HTML (`filter_html` formats only)

`linkit_media_library.ckeditor5.yml` declares the elements
`<a aria-label title class id target="_blank" rel>`. If the format uses *Limit allowed HTML tags*,
`target` must be permitted on `<a>` or the `target="_blank"` the module adds will be stripped.

## Reading the current state

```bash
drush cget linkit.linkit_profile.default
drush cget editor.editor.full_html settings.plugins.linkit_extension
drush cget filter.format.full_html filters.linkit
```

Find every profile that has a media matcher:

```bash
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("linkit_profile")->loadMultiple() as $p) {
  foreach ($p->getMatchers() as $m) {
    if ($m->getPluginId() === "entity:media") { print $p->id() . " has entity:media\n"; }
  }
}'
```

## What is not configurable

The dialog title ("Add or select media"), height (75%) and dialog class
(`media-library-widget-modal`) are fixed in `linkit_media_library.ckeditor5.yml`, as is the
`target="_blank"` on inserted links (hard-coded in the opener).
