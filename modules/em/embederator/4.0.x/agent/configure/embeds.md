# Configuring embeds

## Two entity types

- **`embederator_type`** — config entity, the *bundle*. Admin UI: `/admin/structure/embederator_type`
  (perm `administer embederator types`). Config name `embederator.embederator_type.<id>`.
  Exported keys: `id`, `label`, `description`, `use_ssi`, `embed_markup`, `embed_url`, `wrapper_class`.
  - `embed_markup`: mapping `{ value: <html>, format: <text_format_id> }` — a `text_format` widget on
    the form. Holds the shared markup skeleton with tokens.
  - `use_ssi` (bool): when true the bundle ignores `embed_markup` and instead fetches `embed_url`
    server-side.
  - `wrapper_class`: class(es) added to the template wrapper.
- **`embederator`** — content entity, fieldable, one *instance*. Admin list
  `/admin/content/embederator` (perm `edit embederator entity`). Base fields: `label`, `embed_id`
  (string), `user_id` (owner, auto-set to current user). Add more fields via Field UI
  (`field_ui_base_route` = the bundle edit form) to expose more tokens.

## Tokens

Inside `embed_markup.value` or `embed_url`, reference instance fields as `[embederator:<field>]`, e.g.
`[embederator:embed_id]`. At render, `EmbederatorRender::getEmbedMarkup()` /`getSsiMarkup()` calls
`Token::replace($pattern, ['embederator' => $entity])`. Token replacement runs with sanitize on by
default, so field values are HTML-escaped before insertion. The bundle markup itself is NOT filtered —
see the render note below.

## Render pipeline (what actually reaches the browser)

`EmbederatorRender::generateElement($markup)` always returns:

```php
['#type' => 'processed_text', '#text' => $markup, '#format' => 'full_html']
```

So regardless of the text format stored on the bundle, the final markup is rendered as **full_html**
(no filtering). SSI bundles fetch `embed_url` with the `http_client` and inline the response body the
same way.

## Field formatter `embederator_default`

Applicable only to the `embed_id` base field (`isApplicable()` checks provider `embederator` + field
name `embed_id`). Settings (schema `field.formatter.settings.embederator_default`):

| Setting | Effect |
|---|---|
| `loadstyle` | `''` direct render; `lazy` JS swaps markup in after load; `noquery` lazy unless the request has query params; `iframe` render through the lazyload controller in a resizing iframe |
| `initial_height` | iframe proxy initial height (default 500), only for `loadstyle=iframe` |
| `append_unique_id` | run `EmbederatorUtilities::uniquify()` to suffix form input DOM IDs with a `uniqid()` (avoids collisions when the same embed appears twice) |
| `nullify_cache` | set `#cache['max-age'] = 0` on the field output |

Lazy/iframe markup carries `data-embederator-*` attributes and attaches `embederator/lazyload` or
`embederator/iframe` JS; the iframe `src` is `/embederator/lazyload/{id}/{urlencoded-settings-json}`
with outer-page query params appended.

## Templates

- `embederator.html.twig` (base), `embederator--<BUNDLE>.html.twig` (per-bundle override).
  `hook_theme_suggestions_embederator_alter()` adds the bundle suggestion.
- Entity add landing: `embederator-add-list.html.twig`.

## Routes (all `_admin_route` except canonical/lazyload)

- `/admin/content/embederator` (list), `/admin/content/embederator/add[/type]` (add),
  `/admin/content/embederator/{id}/edit|delete`.
- `/admin/structure/embederator_type[...]` — bundle CRUD (`administer embederator types`).
- `/embederator/{embederator}` canonical view; `/embederator/lazyload/{embederator}/{settings_json}`
  ajax/iframe render — both require `_entity_access: embederator.view`.
