# Preferences dialog block

`Drupal\simple_klaro\Plugin\Block\PreferencesDialog` — a block that renders a link which re-opens
the Klaro consent dialog after the visitor has already made a choice.

- **Plugin id:** `simple_klaro_preferences_dialog`
- **Admin label:** "Simple Klaro preferences dialog"
- **Base class:** `BlockBase` (implements `ContainerFactoryPluginInterface`)
- **Services injected:** `config.factory`, `plugin.manager.condition`, `renderer`

## Output

`build()` returns:

```php
'#markup' => '<a href="#" id="klaro-preferences">' . $config->get('preferences') . '</a>'
```

i.e. an anchor with **id `klaro-preferences`** whose text is the `preferences` label from
`simple_klaro.settings`. The build is cache-tagged on that config (`addCacheableDependency`), so it
updates when the label changes.

You do not need this block to get a re-open trigger: `js/klaro.drupal.js` binds a click handler to
**any** element matching `#klaro-preferences` or `.klaro-preferences` and calls
`klaro.show(drupalSettings.klaroConfig)`. So a custom themed button works by giving it that id or
class — the block is just a ready-made one.

## Access (`blockAccess()`)

Returns `AccessResult::forbidden()` when any of these hold, otherwise defers to the parent:

1. `enabled` is false in `simple_klaro.settings`.
2. The account has `bypass simple klaro`.
3. `exclude_paths` is set and the core `request_path` condition matches the current path.

So the block never shows where the consent manager itself is not active.

## Placing it

Place like any block (Block layout UI, or a `block` config entity) in a region such as the footer.
There is no block configuration form beyond the standard visibility settings; the link label comes
from the module's settings, not per-block.
