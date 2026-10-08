<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable the `shortcode` filter on a text format

The module has **no configure route** (`configure: null`) of its own. Shortcode parsing is
turned on per **text format**, like any other filter.

## Where it's stored

Config entity: `filter.format.<format>`
Path within it:

```yaml
filters:
  shortcode:
    id: shortcode
    provider: shortcode
    status: true          # <-- turns bracket-tag parsing on for this format
    weight: 0              # ordering relative to other filters in the pipeline
    settings:
      quote: true           # per-shortcode-id enable/disable (keyed by plugin id, not token)
      button: true
      highlight: false
      col: true
      ...
  shortcode_corrector:      # optional 2nd filter, cleans up WYSIWYG <p>/<div> wrapping
    id: shortcode_corrector
    status: false
```

`settings` is validated by the schema `filter_settings.shortcode` — a `sequence` of `boolean`
values keyed by shortcode plugin **id**. Any shortcode plugin id absent from `settings` falls
back to its own `status` default (see the plugin's `@Shortcode(status = ...)` annotation,
default `TRUE`) via the settings-form default value, but an explicit entry always wins.

## Via the UI

1. Go to `/admin/config/content/formats/manage/<format>` for the target text format.
2. Under **Enabled filters**, tick **Shortcodes**.
3. Scroll to the **Shortcodes** settings section (grouped by "Shortcodes provided by
   `<module>`") and tick/untick individual shortcodes.
4. Optionally also enable **Shortcodes - html corrector** if editors use CKEditor/a WYSIWYG
   (it strips invalid `<p>` wrapping around block-level shortcode output).
5. **Save configuration**.

## Via drush php:eval (scriptable)

```php
use Drupal\filter\Entity\FilterFormat;

FilterFormat::create([
  'format' => 'my_format',
  'name' => 'My format',
  'filters' => [
    'shortcode' => [
      'status' => TRUE,
      'weight' => 0,
      'settings' => [
        'quote' => TRUE,
        'button' => TRUE,
        'highlight' => FALSE,
      ],
    ],
  ],
])->save();
```

To toggle on an existing format:

```php
$format = \Drupal::entityTypeManager()->getStorage('filter_format')->load('my_format');
$config = $format->filters('shortcode')->getConfiguration();
$config['status'] = TRUE;
$config['settings']['quote'] = TRUE;
$format->setFilterConfig('shortcode', $config)->save();
```

## Read it back

```bash
drush cget filter.format.my_format filters.shortcode
# status: true
# settings: {quote: true, button: true, highlight: false, ...}
```

Or in PHP: `$format->filters('shortcode')->getConfiguration()['settings']`.

## Notes for agents

- A shortcode plugin not enabled (its id missing/false in `settings`) is left as literal
  `[tag]...[/tag]` text in the rendered output — it is not stripped.
- `filters.shortcode.settings` keys are shortcode plugin **ids**, but what an editor types in
  the body field is the shortcode's **token** (defaults to id) — see
  [../plugins/shortcode-plugin.md](../plugins/shortcode-plugin.md) for the id/token distinction.
- Shortcode parsing runs during filter processing (rendering), not on save, so toggling a
  shortcode's enablement changes the output of already-saved content immediately.
