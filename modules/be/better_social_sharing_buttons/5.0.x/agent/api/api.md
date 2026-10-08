# API — block plugin, service & alter hooks

## Block plugin
- Class: `Drupal\better_social_sharing_buttons\Plugin\Block\SocialSharingButtonsBlock`
- Id: `social_sharing_buttons_block` (admin_label "Better Social Sharing Buttons").
- `build()` resolves the current page URL + title, reads either the block-instance config or
  falls back to `better_social_sharing_buttons.settings`, and returns:
  ```php
  ['#theme' => 'better_social_sharing_buttons', '#items' => $items]
  ```
  `$items` keys: `page_url`, `description`, `title`, `width`, `radius`, `facebook_app_id`,
  `print_css`, `iconset`, `services`, `base_url`.

## Service
- Service id: `better_social_sharing_buttons.service`
  (class `…\Service\BetterSocialSharingButtonsService`, interface
  `BetterSocialSharingButtonsServiceInterface`). Autowired. Helper used by the field/paragraph
  rendering; the block itself reads config directly.

## Theme hook
- `better_social_sharing_buttons` — template
  `templates/better-social-sharing-buttons.html.twig`, which includes one partial per network
  from `templates/partials/<network>.html.twig`. Override in your theme to change markup.

## Alter hooks (declared in `better_social_sharing_buttons.api.php`)
Implement these to modify the buttons before render:

```php
/** Alter the items array for the BLOCK. */
function hook_better_social_sharing_buttons_block_items_alter(array &$items, \Drupal\Core\Block\BlockPluginInterface $block) {
  // e.g. force a title / append a UTM param
  $items['title'] = \Drupal\Component\Utility\UrlHelper::encodePath('Custom share title');
}

/** Alter the items array for the NODE field. */
function hook_better_social_sharing_buttons_node_items_alter(array &$items, \Drupal\node\NodeInterface $node) {
  // e.g. swap the shared URL for a canonical/campaign URL
}
```
The block invokes `hook_better_social_sharing_buttons_block_items_alter` via
`moduleHandler->alter()` at the end of `build()`.

## No Drush / no custom plugin types / no permissions
This module adds no Drush commands, defines no plugin manager, and declares no permissions of
its own (the settings form uses core `administer site configuration`). The per-node submodule
adds one permission — see the submodule docs.
