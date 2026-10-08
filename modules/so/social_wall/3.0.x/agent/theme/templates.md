# Theme hooks & templates

`social_wall_theme()` (in `social_wall.module`) registers three theme hooks, each taking a single
`elements` variable. CSS library `social_wall/social_wall.styles` (`css/social_wall.css`) is attached
by the wall wrapper template.

| Theme hook | Template | Rendered by |
| --- | --- | --- |
| `social_wall__block` | `templates/social-wall--block.html.twig` | `SocialWallBlock::build()` (the wall wrapper) |
| `social_network_twitter_block` | `templates/social-network-twitter-block.html.twig` | `TwitterSocialNetwork::render()` |
| `social_network_instagram_block` | `templates/social-network-instagram-block.html.twig` | `InstagramSocialNetwork::render()` |

## Wrapper — `social-wall--block.html.twig`

Attaches the CSS library, then a `<ul class="wrapper">` iterating `elements` (one `<li>` per network
build, already weight-sorted by the block).

## Per-post variables

Twitter `#elements` items: `body_text`, `creation_timestamp` (unix), `post_url`. Instagram
`#elements` items: `caption`, `creation_timestamp`, `post_url`, `image_url` (a base64 `data:` URI).
Templates print `{{ post.creation_timestamp|format_date('short') }}`, the post text/caption, and a
`See post` link (`target="_blank"`).

## Overriding

Override any of the three templates from your theme (e.g. copy `social-wall--block.html.twig` into your
theme and clear cache), per the module README. To change the connectors' markup structure, override
`social-network-twitter-block.html.twig` / `social-network-instagram-block.html.twig`. A custom
connector should register and use its own theme hook (see
[../plugins/social-network.md](../plugins/social-network.md)).

Note: post text/caption reaching the templates has already been passed through `Xss::filter()` in the
connector (`body_text` as a plain string; `caption` as a `#markup` render element), so it is filtered
rather than emitted raw.
