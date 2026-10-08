<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Components overview

Seven SDCs live under `components/<id>/<id>.component.yml` (+ `.twig`, optional `.css`/`.js`/README/`*.story.yml`). Reference each as `generic_components:<id>`. All are `status: experimental`. No config, routes, or services — these are pure render components. Props are validated against the schemas below by Drupal's SDC layer.

Quick reference:

| Component (id) | group | slots | props |
|---|---|---|---|
| `generic_html_tag` | Other | — | `tag` |
| `generic_html_wrapper` | Other | `content` | `tag` |
| `generic_spacer` | Layout | — | `size`, `direction` |
| `conditional_wrapper` | Utilities | `before`, `content` (maxItems 1), `after` | `tag` |
| `field_range` | Utilities | `content` | `limit`, `offset`, `order` |
| `comment` | Snippets | `content` | `comment_author_id`, `content_author_id` |
| `comment_links` | Snippets | — | `last_comment_timestamp`, `node_field_name`, `link` |

---

## generic_html_tag
Renders a single self-closing/void element (`<hr/>`, `<br/>`, `<img/>`, …). Template: `{% if tag %}<{{ tag }}{{ attributes }}/>{% endif %}` — nothing renders unless `tag` is set.
- **props:** `tag` (string, pattern `^[a-zA-Z0-9-]+$`; letters/digits/dash only). No default.
- Description warns it should only be a void element (closing tags are not emitted).

```twig
{{ include('generic_components:generic_html_tag', { tag: 'hr', attributes: { class: ['rule'] } }) }}
```

## generic_html_wrapper
Wraps a `content` slot in a configurable element. Template: `<{{ tag|default('div') }}{{ attributes }}>{{ content }}</{{ tag|default('div') }}>`.
- **props:** `tag` (string, pattern `^[a-zA-Z0-9-]+$`, effective default `div`).
- **slots:** `content` — inner render content.
- Ships `generic_html_wrapper.default.story.yml` (iterates a tag list: a, p, b, h2/h3, article, aside, nav, section, header, footer, div, span, blockquote, figure, details).

```twig
{% embed 'generic_components:generic_html_wrapper' with { tag: 'section' } %}
  {% block content %}…{% endblock %}
{% endembed %}
```

## generic_spacer
An empty spacing div. Template adds classes `db-generics db-spacer db-spacer-<direction>` and inline `style="--size: <size>; position: relative;"`; `generic_spacer.css` maps `--size` to width/height per direction.
- **props:**
  - `size` (string enum, default `16px`): `8px`,`16px`,`24px`,`32px`,`40px`,`48px`,`56px`,`64px`,`72px`,`80px`,`88px`,`96px`,`104px`,`112px`,`120px`,`128px`,`136px`,`144px`,`152px`,`160px`.
  - `direction` (string enum, default `vertical`): `vertical`, `horizontal`, `both`.
- Ships `generic_spacer.default.story.yml` (previews all sizes × directions).

```twig
{{ include('generic_components:generic_spacer', { size: '48px', direction: 'vertical' }) }}
```

## conditional_wrapper
(New in 1.1.x.) Wraps content in an *optional* tag, and renders the whole block only when the `content` slot has something attached. Detection is by attachment, not rendered emptiness — an attached-but-blank field still shows the wrapper. Template guards on `{% if content %}`, then emits the tag only `{% if tag %}`, around `{{ before }}{{ content }}{{ after }}`.
- **props:** `tag` (string, pattern `^[a-zA-Z0-9-]+$`; must be a closable tag — open and close tags are both emitted). No default; if unset, slots render without a wrapping element.
- **slots:** `before`, `content` (maxItems 1), `after`. `before`/`after` are hidden unless `content` is attached.

```twig
{% embed 'generic_components:conditional_wrapper' with { tag: 'aside' } %}
  {% block content %}{{ field_related }}{% endblock %}
{% endembed %}
```

## field_range
Displays only a selected range of a multivalued field's items. Template renders the `content` slot as-is when `limit == 0`; otherwise, if the slot is a sequence with `content[0]` defined, it optionally reorders then `slice(offset, limit, true)`.
- **props:**
  - `limit` (integer, default `0`, minimum 0): number of items to show; `0` = all.
  - `offset` (integer, default `0`, minimum 0): items to skip from the start (only when `limit` set).
  - `order` (string enum, default `default`): `default`, `reverse`, `random` (only when `limit` set). `reverse` uses `|reverse(true)`; `random` assigns per-key random weights and sorts.
- **slots:** `content` — should be a multivalued field.

```twig
{% embed 'generic_components:field_range' with { limit: 3, offset: 0, order: 'reverse' } %}
  {% block content %}{{ content.field_images }}{% endblock %}
{% endembed %}
```

## comment
Drupal-specific wrapper that reconstructs the comment markup/classes/JS that `CommentViewBuilder`/`template_preprocess_comment()` normally inject but which are lost when comments render through Display Builder. Template coerces both id props to strings, builds a class list, and emits `<div{{ attributes.addClass(classes) }}>{{ content }}</div>`.
- **props (both string):**
  - `comment_author_id` — token source `[comment:author:uid]`; `not yet assigned` (or `0`) for anonymous.
  - `content_author_id` — token source `[comment:entity:author:uid]`; drives the `by-author` class.
- **slots:** `content` — the rendered comment body (must include the required `data-comment-timestamp` markup, see below).
- **classes applied:** `comment`, `js-comment` (always); `by-anonymous` when `comment_author_id == 'not yet assigned'`; `by-author` when `comment_author_id == content_author_id`.
- **CSS** (`comment.css`): hides `.comment-author` unless `.by-author`; provides `.indented` threading margins (LTR/RTL).
- **libraries** (`libraryOverrides.dependencies`): `core/drupal`, `core/once`, `core/drupalSettings`, `ui_suite_bootstrap/indented`.
- **"new" indicator:** `comment.js` (`Drupal.behaviors.commentNewIndicator`) replaces `history/drupal.comment-new-indicator`. It returns immediately for anonymous users (`drupalSettings.user.uid === 0`), finds `[data-comment-timestamp]` elements newer than 30 days, resolves node IDs from the nearest `[data-history-node-id]` ancestor, uses embedded `drupalSettings.history.lastReadTimestamps` when complete or else POSTs to `history/get_node_read_timestamps`, and marks unread comments with a `new` label/class. Requires a hidden badge such as `class="hidden" data-comment-timestamp="[comment:changed:raw]"` inside the content slot.

## comment_links
Renders the "X new comments" link for a node's comment field in Display Builder full-page view, where core's teaser-only `HistoryCommentLinkBuilder` never runs. Template picks tag `span`, or `a` when a `link` is given (setting `href` + a translated `title`), sets `data-history-node-last-comment-timestamp` and `data-history-node-field-name`, and starts hidden (`class="hidden"`).
- **props:**
  - `last_comment_timestamp` (string) — token source `[node:comment:last_comment_timestamp]`.
  - `node_field_name` (string) — machine name of the comment field (e.g. `comment`, `field_comments`).
  - `link` (`$ref: ui-patterns://url`) — canonical entity URL used as the initial href; leave empty for no link.
- **Runtime dependency caveat:** the `ui-patterns://url` `$ref` is resolved by the UI Patterns (`ui_patterns`) module. Although `ui_patterns` is declared only under composer `require-dev` and is *not* listed in `generic_components.info.yml`, this `$ref` makes it an effective **runtime** requirement: with `generic_components` enabled but `ui_patterns` absent, core SDC discovery cannot resolve the reference and throws `InvalidComponentException` on every request, taking the whole site down. Install/enable `drupal/ui_patterns` (^2) alongside this module, or the `comment_links` component's schema will break page rendering.
- **libraries** (`libraryOverrides.dependencies`): `core/drupal`, `core/once`, `core/drupalSettings` (core's `history/drupal.node-new-comments-link` is intentionally not loaded).
- **behavior:** `comment_links.js` (`Drupal.behaviors.commentLinksNewComments`) returns for anonymous users, filters placeholders newer than 30 days, resolves node IDs from `[data-history-node-id]`, fetches read timestamps (embedded or via `history/get_node_read_timestamps`), then POSTs to `comments/render_new_comments_node_links` to fill the count/link and unhide the `<a>`; elements with no new comments are removed. It bypasses `Drupal.history.fetchTimestamps()` whose embedded-data short-circuit would skip missing nodes.
