# Print button block (`printjs_block`)

`Drupal\printjs\Plugin\Block\PrintJsBlock` — a `#[Block]` with id **`printjs_block`**, admin label
**"Print button"**, category **"Print"**. Place it via *Block layout*
(`/admin/structure/block`) in any region; `build()` delegates to
`print.js`'s `getBtnPrintjs($config['printText'], $config)`, so the block renders the same button as
the service, using the block's own stored configuration (not the global settings object).

## Per-block configuration (`blockForm`/`blockSubmit`)

Stored under `block.settings.printjs_block` (the module's only config schema). Keys:

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `printjs_id` | textfield | `#print` | Selector of the content to print (id/class/text). |
| `printText` | textfield (required) | `Print` | Button label. |
| `auto_print` | checkbox | `FALSE` | Click the button automatically on page load (`data-autoprint`). |
| `print_parent_selector` | checkbox | `FALSE` | Print the parent of the matched element. |
| `local` | checkbox | `FALSE` | Use the local `printjs/printjs.local` library instead of the CDN. |

`defaultConfiguration()` seeds `printjs_id` from the current configuration or `#print`. Note the
block form has `printText` and `auto_print` that the global settings form lacks, but omits
`btn_selector_print` (which only the global settings form sets, applied to all buttons via
`drupalSettings`).

## Access

`blockAccess(AccountInterface $account)` returns
`AccessResult::allowedIfHasPermission($account, 'access content')` — the button shows to anyone who
can view site content. It is a presentational print trigger with no data of its own; the printed
output is whatever is already in the visitor's DOM.
