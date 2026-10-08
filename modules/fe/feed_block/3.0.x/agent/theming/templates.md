# Feed Block — theming

## Theme hook
`feed_block_rss_item` (registered in `FeedBlockHooks::theme()`), template
`templates/feed-block-rss-item.html.twig`. Variables: `date`, `url`, `title`, `description`.

Bundled template:
```twig
<em>{{ date }}</em><br />
<strong><a href="{{ url }}">{{ title }}</a></strong>
<div> {{ description }}</div>
<hr />
```
Twig auto-escapes `title` and `description`; `url` is printed in the `href` attribute.

## Override the item markup
Copy `feed-block-rss-item.html.twig` into your theme's `templates/` and adjust. Clear caches.

## Block-level template suggestion
`FeedBlockHooks::themeSuggestionsBlockAlter` adds a `block__feed_block` suggestion for any block
whose content entity is of bundle `feed_block`, so you can add
`block--feed-block.html.twig` to wrap the whole block.

## CSS
The module attaches a minimal `feed_block/feed_block` library (referenced from the block template
per help text). To drop it, remove the `attach_library('feed_block/feed_block')` call from your
overridden template or point it at your own library.

## Read More styling
`FeedBlockHooks::preprocessField` adds a `button` CSS class to the `field_read_more` link's
`<a>` tag on `feed_block` blocks.
