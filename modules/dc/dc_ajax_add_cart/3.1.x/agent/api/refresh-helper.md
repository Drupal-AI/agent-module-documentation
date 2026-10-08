<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RefreshPageElementsHelper service

Service id `dc_ajax_add_cart.refresh_page_elements_helper`, class
`Drupal\dc_ajax_add_cart\RefreshPageElementsHelper`. Builds an `AjaxResponse` that refreshes the
cart-related page regions. Reusable from any AJAX callback that needs the cart/messages to update.

Constructor args: `@theme.manager`, `@entity_type.manager`, `@plugin.manager.block`, `@renderer`.
It creates one internal `AjaxResponse` and its update methods are chainable (`return $this`).

## Methods

| Method | AJAX commands added |
|---|---|
| `updateFormBuildId(array $form)` | If `#build_id_old !== #build_id`, adds `UpdateBuildIdCommand`. |
| `updateStatusMessages()` | If a `system_messages_block` is placed for the active theme: `RemoveCommand('.messages__wrapper')` then `AppendCommand('.region-<block region>', <rendered #type status_messages>)`. |
| `updateCart()` | `ReplaceCommand('.cart--cart-block', <freshly built commerce_cart block>)`. |
| `updatePageElements(array $form)` | Convenience: runs `updateFormBuildId → updateStatusMessages → updateCart`. |
| `getResponse()` | Returns the accumulated `AjaxResponse`. |
| `getStatusMessagesBlockId()` | Returns the `system_messages_block` block id for the active theme, or NULL. |

## Usage

```php
/** @var \Drupal\dc_ajax_add_cart\RefreshPageElementsHelper $helper */
$helper = \Drupal::service('dc_ajax_add_cart.refresh_page_elements_helper');
return $helper->updatePageElements($form)->getResponse();
```

Or refresh just the cart block after some custom cart mutation:

```php
return $helper->updateCart()->getResponse();
```

## Notes / assumptions

- `updateCart()` targets the CSS selector `.cart--cart-block` — the placed **Cart** block must be
  present in the DOM for the replace to land.
- `updateStatusMessages()` is a no-op unless a **status messages** block is placed for the active
  theme; it appends into `.region-<region>` of that block.
- The cart block is rebuilt via the block manager (`commerce_cart` plugin), so it reflects the
  current session's cart.
