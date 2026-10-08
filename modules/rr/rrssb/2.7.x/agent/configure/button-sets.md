# RRSSB button sets (the `rrssb_button_set` config entity)

The unit of configuration is a **button set**, a config entity of type `rrssb_button_set`
(config prefix `rrssb.button_set`, so objects are named `rrssb.button_set.<id>`). One set with id
`default` is installed with the module.

Admin UI: *Configuration → Content authoring → Ridiculously Responsive Social Sharing Buttons*
(`/admin/config/content/rrssb`, route `entity.rrssb_button_set.collection`). Add/edit/delete forms
are all gated by the **`administer rrssb`** permission (`restrict access: TRUE`).

## Exported shape (config_export keys)

```yaml
# rrssb.button_set.default
id: default
label: Default
follow: 0                 # 0 = share buttons, 1 = follow buttons
chosen:                   # which buttons, and their per-button settings
  email:     { enabled: true, weight: -20 }
  facebook:  { enabled: true, weight: -19 }
  linkedin:  { enabled: true, weight: -18 }
  twitter:   { enabled: true, weight: -17 }
  pinterest: { enabled: true, weight: -15 }
appearance:               # all nullable floats unless noted
  size: null
  shrink: null            # minimum size
  regrow: null            # extra-row size
  minRows: null
  maxRows: null
  prefixReserve: null     # prefix reserved width
  prefixHide: null        # prefix max width
  alignRight: false       # boolean, right-align the row
prefix: ''                # text shown before the buttons (translatable)
image_tokens: ''          # tokens used to find the share image
```

Per-button entries in `chosen` use schema `rrssb.button`: `label`, `enabled` (bool),
`username` (for follow links), `weight` (int).

## Create / edit a set with drush php:eval

```php
use Drupal\rrssb\Entity\RRSSBButtonSet;
$set = RRSSBButtonSet::create([
  'id' => 'compact',
  'label' => 'Compact',
  'follow' => 0,
  'chosen' => [
    'email'    => ['enabled' => TRUE, 'weight' => -20],
    'facebook' => ['enabled' => TRUE, 'weight' => -19],
  ],
  'appearance' => ['alignRight' => TRUE],
  'prefix' => 'Share:',
]);
$set->save();
```

Read back: `drush cget rrssb.button_set.compact` (or
`\Drupal::entityTypeManager()->getStorage('rrssb_button_set')->load('compact')`).

## Attach a set to a content type (no block needed)

`rrssb_form_node_type_form_alter()` adds an RRSSB **Button set** select to the content type edit
form; the choice is stored as a **third-party setting** on the node type:

```yaml
# node.type.<bundle>
third_party_settings:
  rrssb:
    button_set: compact
```

```php
$type = \Drupal::entityTypeManager()->getStorage('node_type')->load('article');
$type->setThirdPartySetting('rrssb', 'button_set', 'compact')->save();
```

Every node of that type then renders the chosen set automatically (via
`hook_ENTITY_TYPE_view` using `rrssb_get_buttons()`).

## Related

- Place a set as a block or a Views field, and the render helper/tokens → [../api/render-buttons.md](../api/render-buttons.md).
- Add or change the available buttons → [../hooks/buttons.md](../hooks/buttons.md).
