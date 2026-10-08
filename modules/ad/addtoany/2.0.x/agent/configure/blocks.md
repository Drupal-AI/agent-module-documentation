# Blocks

The module provides two block plugins (place via Admin → Structure → Block layout, or in code):

| Block plugin id | Class | Purpose |
|---|---|---|
| `addtoany_block` | `src/Plugin/Block/AddToAnyBlock.php` | A standalone share-buttons block. Config: `link_url` (uri), `link_title` (label), `buttons_size`, `addtoany_html`. |
| `addtoany_follow_block` | `src/Plugin/Block/AddToAnyFollowBlock.php` | A "follow us" block linking to your own social profiles. Config: `buttons_size`, `addtoany_html`. |

Block config schema is `block.settings.addtoany_block` / `block.settings.addtoany_follow_block`
(base type `addtoany.block_base_settings`). Each block lets you override the buttons HTML and
size independently of the global settings; the share block can point at an explicit URL/title
instead of the current page.

There is also a Views field (`src/Plugin/views/field/NodeAddToAnyShare.php`) to render a node's
share buttons as a column in a View.
