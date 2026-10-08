# Blocks

Two `BlockBase` plugins, both `ContainerFactoryPluginInterface`. Both suppress themselves on
admin routes (`router.admin_context->isAdminRoute()` returns `[]`) and both attach the
`whatsapp_bubble/main` library and the cache tag `config:whatsapp_bubble.config`.

| Plugin id | Class | Admin label | Theme hook |
|---|---|---|---|
| `whatsapp_bubble_block` | `Plugin\Block\WhatsappBubbleBlock` | Whatsapp Floating Bubble | `wab` |
| `whatsapp_button_block` | `Plugin\Block\WhatsappButtonBlock` | Whatsapp Button | `wab_button` |

## `whatsapp_bubble_block` (WhatsappBubbleBlock)

Renders the same floating bubble as the global auto-injection, but via block placement. Reads
everything from `whatsapp_bubble.config` (`alignment`, `valignment`, `phone_number`, `message`,
`is_inverse`); no per-block settings of its own. `message` is `urlencode()`d before theming.

`blockForm()` shows a warning `item` ("Potential duplicate bubble") **only when the global
`is_enabled` is TRUE**, linking to the settings form — because placing this block while global
injection is on renders two bubbles on the page. Disable global injection or don't place the block.

## `whatsapp_button_block` (WhatsappButtonBlock)

A labelled button variant (small text line above the word "WhatsApp"). Has its own instance settings.

`defaultConfiguration()`:

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `small_text` | string | `'Contact us via'` | Text shown above "WhatsApp" (`{{ small_text }}` in the template). |
| `override_phone` | boolean | `FALSE` | When checked, use this block's `phone_number` instead of the global one. |
| `phone_number` | string | `''` | Per-block destination number (only used when `override_phone` is TRUE and non-empty). |

Number resolution in `build()`:
```php
$number = $config->get('phone_number') ?: '';           // global default
if (!empty($this->configuration['override_phone']) && !empty($this->configuration['phone_number'])) {
  $number = $this->configuration['phone_number'];        // per-block override
}
```
So an empty override falls back to the global number. `blockForm()` shows the global number in
the field description and uses `#states` to reveal the phone field only when `override_phone` is checked.
Settings are persisted in `blockSubmit()`. Per-instance schema: `block.settings.whatsapp_button_block`
in `config/schema/whatsapp_bubble.schema.yml`.

Note: the button template (`wab-button.html.twig`) does **not** include the prefilled `message`
query — only the bubble (`wab.html.twig`) does. See [theme/rendering.md](../theme/rendering.md).

Placing blocks: use the block layout UI (`/admin/structure/block`) or a `block` config entity;
block visibility conditions decide where each appears.
