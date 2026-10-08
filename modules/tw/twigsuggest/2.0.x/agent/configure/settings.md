# Twig Template Suggester — settings, variable & service

There is **no admin form and no `configure` route**. The module is on as soon as it is enabled;
the only knob is a single flag, plus the `base_path` variable it exposes and one helper service.

## The one setting: `alternate_ds_suggestions`

Config key **`twigsuggest.settings:alternate_ds_suggestions`** (boolean). It gates the optional
Display Suite layout-suggestion fix in `twigsuggest_theme_suggestions_layout_alter()` — when TRUE,
DS layout suggestions like `onecol` are rewritten to the double-underscore form so a
`layout--onecol.html.twig`-style override resolves. **Default: off** (the hook returns early). No
`config/install` ships, so the config object does not exist until something sets it.

Recommended (per the code comment) in `settings.php`:

```php
$config['twigsuggest.settings']['alternate_ds_suggestions'] = TRUE;
```

Or as normal DB config:

```bash
drush cset twigsuggest.settings alternate_ds_suggestions 1 -y
drush cget twigsuggest.settings alternate_ds_suggestions
```

```php
\Drupal::configFactory()->getEditable('twigsuggest.settings')
  ->set('alternate_ds_suggestions', TRUE)->save();
```

Read at runtime as `\Drupal::config('twigsuggest.settings')->get('alternate_ds_suggestions')`.

## `base_path` variable

`twigsuggest_preprocess()` sets `base_path` on **every** template (via global `hook_preprocess`).
Use it to build root-relative asset URLs, e.g.
`<img src="{{ base_path ~ directory }}/images/icon.svg">`.

## Module weight

`twigsuggest_install()` sets the module weight to **100** so its `hook_theme_suggestions_*` run
after other modules and its suggestions take precedence.

## Helper service

Service id **`twigsuggest.helper_functions`** → `Drupal\twigsuggest\Utils\HelperFunctions`.

```php
$node = \Drupal::service('twigsuggest.helper_functions')->getCurrentNode();
```

`getCurrentNode()` returns the current `Node` (or FALSE) resolving across
`entity.node.canonical`, `entity.node.revision`, and `entity.node.preview` routes. It backs the
`page__node__<type>` / `html__node__<type>` suggestions.
