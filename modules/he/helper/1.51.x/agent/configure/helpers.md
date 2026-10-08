<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Helper's optional behavior "helpers" (`helper.settings`)

Helper has **no settings form** (`configure: null`). Its opt-in behaviors are stored in the
`helper.settings` config object under `enabled:` (a map of `<helper_key>: <value>`), read at
runtime by `_helper_is_enabled($key, $default)`.

## The toggles (shipped defaults)

| Key | Type | Default | Effect |
|---|---|---|---|
| `layout_builder_entity_operation` | bool | `true` | Add a layout operation link to overridable-layout entities |
| `layout_builder_entity_operation_default_overridden` | bool | `true` | Make that link the default when the layout is overridden |
| `layout_builder_inline_block_validation` | bool | `true` | Forbid inline blocks in default layouts |
| `core_hide_layout_providers` | array | `[]` | Hide layouts provided by these modules (e.g. `layout_discovery`) |
| `core_form_novalidate` | bool | `false` | Add `novalidate` to every form (disable HTML5 validation) |
| `core_text_textarea_widgets` | bool | `false` | Allow textarea widgets on `string`/`text` field types |
| `core_node_form_author_display_name` | bool | `true` | Show author display name (not username) on node forms (D11.2-) |
| `redirect_entity_4xx_to_edit` | bool | `false` | Redirect 403/404 entity views to the edit form if the user may edit |
| `media_oembed_iframe_title` | bool | `true` | Add a `title` attribute to oEmbed iframes (accessibility) |
| `core_entity_reference_hide_empty` | bool | `false` | Hide an entity-reference field with no selectable options |
| `tmgmt_hide_if_not_multilingual` | bool | `true` | Hide TMGMT admin until the site has >1 language |
| `menu_links_prefer_deepest` | bool | `false` | When selecting a menu link, match the deepest link |
| `menu_active_trail` | bool | (unset) | Override the menu active-trail service |

## Enable / disable a helper

The value lives at `helper.settings:enabled.<key>`:

```bash
# Turn a helper on:
drush cset helper.settings enabled.core_form_novalidate 1 -y
# Turn it off:
drush cset helper.settings enabled.core_form_novalidate 0 -y
# Read current state:
drush cget helper.settings enabled
```

Or in PHP:

```php
$config = \Drupal::configFactory()->getEditable('helper.settings');
$enabled = $config->get('enabled');
$enabled['redirect_entity_4xx_to_edit'] = TRUE;
$config->set('enabled', $enabled)->save();
```

Each toggle is validated by its own schema type `helper.helper.<key>` (see
`config/schema/helper.schema.yml`). Several toggles no-op unless their target module is present
(Layout Builder, TMGMT, Media oEmbed, etc.) or another contrib module already provides the feature.
