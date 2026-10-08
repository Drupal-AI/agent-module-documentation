# Email template tokens (API)

The module defines three custom token types via `hook_token_info` and resolves them in `hook_tokens`.
They are the placeholders you put in the message templates on the settings form
([../configure/settings.md](../configure/settings.md)). Tokens are resolved with
`Token::replacePlain()` in the recipient's language. The settings form shows a `token_tree_link` per
type (`#global_types => FALSE`, so only these types are offered).

Use them as `[<type>:<token>]`, e.g. `[fns_topic:topic_url]`.

## `fns_topic` — new forum topic emails (`post_subject` / `post_message` / `post_dd_message`)

| Token | Resolves to |
|---|---|
| `user_name` | Subscriber's account label (`frequency->getOwner()->label()`). |
| `poster_name` | Topic author's label. |
| `forum_name` | The `forums` term label. |
| `topic_name` | The forum node title. |
| `topic_url` | `base_url` + optional `/langcode` + `/node/{nid}`. |
| `topic_url_alias` | Same, using the node's path alias (regenerates a Pathauto alias first if pathauto is enabled). |
| `topic_body` | Raw `node.body[0].value`. |
| `summary` | Raw `node.body[0].summary`. |
| `user_edit` | `base_url` + `/user/{uid}/edit` — the account edit page (where the user manages/removes subscriptions). |
| `system_email` | `system.site:mail`. |

## `fns_comment` — new comment emails (`comment_subject` / `comment_message` / `comment_dd_message`)

| Token | Resolves to |
|---|---|
| `user_name` | Subscriber's account label. |
| `poster_name` | Commenter's label. |
| `forum_name` | The `forums` term label. |
| `topic_name` | The commented forum node title. |
| `topic_url` | `base_url` + optional `/langcode` + `/node/{nid}`. |
| `topic_url_alias` | Node path-alias URL. |
| `comment_body` | Raw `comment.comment_body[0].value`. |
| `summary` | Raw comment-body summary (falls back to value). |
| `comment_url` | `…/node/{nid}#comment-{cid}`. |
| `comment_url_alias` | Alias URL + `#comment-{cid}`. |
| `user_edit` | Account edit page URL. |
| `system_email` | `system.site:mail`. |

## `fns_dd` — daily digest (`dd_subject` / `dd_header_message`)

| Token | Resolves to |
|---|---|
| `date` | The post date (`l, F j, Y`, or `l j F Y` for French), from `$data['date']`. |

## Notes for integrators

- `topic_url` / `user_edit` etc. are built from `Request::createFromGlobals()->getSchemeAndHttpHost()`
  captured when the topic/comment is saved — from the request that created the content, not a fixed
  base URL.
- `langcode` is appended only when the recipient's language differs from the site default.
- The `*_body` / `summary` tokens emit the field value as stored (no additional processing at the
  token layer); templates are otherwise plain text assembled by the module.
