# wsdata_block — render a WSCall as a block

Submodule `wsdata_block` (depends on `wsdata`). Enable it, then place the **Wsdata Block**
(`@Block` id `wsdata_block`, category *wsdata*) via the Block Layout UI.

## Block config (`WSDataBlock`)

`blockForm()` embeds `WSDataService::wscallForm()`, so the block settings are:

| Setting | Stored in block config | Meaning |
|---|---|---|
| `wscall` | `configuration['wscall']` | Which WSCall to run. Changing it AJAX-refreshes the replacement fields. |
| `replacements` | `configuration['replacements']` | One textfield per `[name]` the call declares; saved as an array keyed by token. |
| `data` | `configuration['data']` | Request body/data passed to the call. |
| `returnToken` | `configuration['returnToken']` | The `$key` selector (`:`-delimited) applied to the decoded result. |

These are set by whoever places the block (permission `administer blocks`) — they are block
configuration, not request input.

## Render (`build()`)

```php
$result = $this->wsdata->call(
  $this->configuration['wscall'], NULL,
  $this->configuration['replacements'],
  $this->configuration['data'], [],
  $this->configuration['returnToken']
);
// Rendered as #markup (array results are print_r'd).
```

The decoded value is output as `#markup` inside `<div class="wsdata_block">`. Because the call
runs on every uncached render, cache the WSCall (a `get` HTTP call with an `expires`/max-age)
before putting the block on a busy page.
