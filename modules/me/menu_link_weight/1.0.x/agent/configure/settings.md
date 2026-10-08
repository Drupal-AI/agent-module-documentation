# Settings & the CSHS parent-selector override

## The one setting — `menu_link_weight.settings`

```yaml
menu_parent_form_selector: 'default'   # or 'cshs'
```

Schema `menu_link_weight.settings` (`config_object`, single string
`menu_parent_form_selector`). Form `\Drupal\menu_link_weight\Form\SettingsForm` at
`/admin/config/user-interface/menu-link-weight` (route `menu_link_weight.settings`, permission
**`administer site configuration`** — the module defines no permission of its own).

| Value | Effect |
|---|---|
| `default` (default) | Keep core's parent menu-link selector; you still get the tabledrag weight widget. |
| `cshs` | Use the **Client-side hierarchical select** parent picker — only takes effect if the `cshs` module is installed. |

Read / set:

```bash
drush cget menu_link_weight.settings menu_parent_form_selector
drush cset menu_link_weight.settings menu_parent_form_selector cshs -y
```

The settings form's validation blocks choosing `cshs` in the UI unless the `cshs` module is
enabled (it links to the project). Setting the value via config directly does not require it,
but the override below still only activates when `cshs` is present.

## The CSHS service override

`\Drupal\menu_link_weight\MenuLinkWeightServiceProvider::alter()` runs at container build:

```php
if ($settings['menu_parent_form_selector'] === 'cshs' && isset($modules['cshs'])) {
  $container->getDefinition('menu.parent_form_selector')
    ->setClass(CshsMenuParentFormSelector::class);
}
```

So core's `menu.parent_form_selector` service is replaced by
`\Drupal\menu_link_weight\MenuParentFormSelector\CshsMenuParentFormSelector` (which extends
core's `MenuParentFormSelector`) **only** when both conditions hold. If `cshs` is not enabled,
the setting can be `cshs` but the default selector is still used.

## Container rebuild on change

`\Drupal\menu_link_weight\EventSubscriber\ConfigSubscriber::onConfigSave()` calls
`$kernel->invalidateContainer()` whenever `menu_parent_form_selector` changes, so the service
swap (or its removal) is picked up on the next request without a manual rebuild.

## Requirements to actually use `cshs`

Install and enable Client-side hierarchical select:
`composer require drupal/cshs` then `drush en cshs -y`, then set the option to `cshs`.
