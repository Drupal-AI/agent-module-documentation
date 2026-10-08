# Configure Floating Block

**Route:** `floating_block.admin_settings` → `/admin/config/user-interface/floating-block`
**Permission:** `administer site configuration` (core; no module-specific permission)
**Form:** `Drupal\floating_block\Form\SettingsForm` (`floating_block_admin_settings_form`)

## Form fields

- **Floating block settings** (`blocks`, textarea) — one floating block per line.
- **Min width** (`min_width`, number) — viewport width in px below which floating is disabled.
  Set `0` to keep blocks floating at all screen sizes.

## Line syntax

```
selector|key=value,key=value,...
```

Examples (from `hook_help`):
- `#sidebar-left` — float the element matched by `#sidebar-left` (any valid jQuery/CSS selector).
- `#sidebar-left|padding_top=8,padding_bottom=4` — offset 8px from the top while floating, and
  4px from the bottom when near the end of the page.
- `#sidebar-left|container=#main` — keep the floating element constrained within `#main`.

Recognised option keys: `padding_top`, `padding_bottom`, `container` (parsed generically, so other
`key=value` pairs are stored and passed to JS too). The selector is the part before `|`.

**Validation:** `validateForm()` round-trips the textarea (text → array → text via the `floating_block`
helper) and errors on `blocks` if the result isn't idempotent — i.e. each line must match
`selector|k=v,k=v,...`. Newlines (`\r`, `\n`) are normalised during the comparison.

## Stored config

`floating_block.settings`:
```yaml
blocks:            # sequence; each item is a map of strings, always incl. 'selector'
  - selector: '#sidebar-left'
    padding_top: '8'
    container: '#main'
min_width: 850     # integer, or null / 0
```
`getEditableConfigNames()` returns `[]`; the form writes `floating_block.settings` directly with
`configFactory->getEditable()`.

## Drush / scripting

No Drush commands. To set programmatically:
```php
\Drupal::configFactory()->getEditable('floating_block.settings')
  ->set('blocks', [['selector' => '#sidebar-left', 'padding_top' => '8']])
  ->set('min_width', 850)
  ->save();
```
Front-end assets are attached by `hook_page_attachments()` only when `blocks` is a non-empty array,
so an empty `blocks` value effectively disables the feature site-wide.
