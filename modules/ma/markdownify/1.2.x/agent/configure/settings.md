# Configure Markdownify

Config object: **`markdownify.settings`** (schema in `config/schema/markdownify.schema.yml`).
Settings form `markdownify.settings` at `/admin/config/services/markdownify`, gated by the
`administer markdownify` permission. No setup is required out of the box — `node` and
`taxonomy_term` work immediately.

## The six ways to reach the Markdown of an entity

| Method | Example | Provided by |
|---|---|---|
| `.md` on canonical path | `/node/1.md` | dynamic route (`MarkdownifyEntityRoutes::routes`) |
| `/markdownify/` path prefix | `/markdownify/node/1` | `MarkdownifyPathProcessor` (inbound) |
| `_format` query param | `/node/1?_format=markdown` | `MarkdownRequestFormatRouteFilter` |
| `Accept` header | `/node/1` + `Accept: text/markdown` | `MarkdownifyNegotiationMiddleware` |
| `Content-Type` header | `/node/1` + `Content-Type: text/markdown` | route `_content_type_format` |
| `.md` on a **path alias** | `/blog/my-post.md` | submodule **markdownify_path** |

All resolve to the `markdownify` controller / entity route and return a `MarkdownResponse`
(`Content-Type: text/markdown; charset=utf-8`). Access is checked by the route requirements
`_entity_access: <type>.view` **and** `MarkdownifyEntityAccessCheck` (`_markdownify_entity_access`),
which requires the entity's normal `view` access **and** that the entity type/bundle/language is
enabled in `supported_entities`.

## Config keys

```yaml
supported_entities:            # which entity types are Markdownify-enabled
  node:
    bundles:
      default: true            # true = the "selected" list is EXCLUDED, all others INCLUDED
      selected: []             # bundle machine names
    languages:
      default: true            # same include/exclude semantics for langcodes
      selected: []
    view_modes:                # NEW in 1.2.x — per-bundle render view mode
      article: teaser          # bundle => view mode machine name; unset bundles use "full"
  taxonomy_term: { ... }
default_converter: league      # plugin id of the html_to_markdown_converter to use
noindex: true                  # add X-Robots-Tag: noindex to Markdown responses
converters:
  league:                      # per-converter plugin configuration (see plugins/converters.md)
    header_style: atx
    strip_tags: true
    list_item_style: '-'
    ...
```

**Include/exclude semantics (important):** for both `bundles` and `languages`, `default:
true` means "apply to everything **except** the `selected` list"; `default: false` means
"apply **only** to the `selected` list". So to enable Markdown for only Article nodes:

```php
$c = \Drupal::configFactory()->getEditable('markdownify.settings');
$c->set('supported_entities.node.bundles', ['default' => FALSE, 'selected' => ['article']])
  ->save();
```

The bundle/language/view-mode selection is edited through a dynamic form built by
`SupportedEntitiesConfigForm` (service `markdownify.supported_entities.config_form`).

## View mode per bundle (new in 1.2.x)

By default an entity is rendered through its `full` view mode before conversion. The `full`
mode often includes fields that are noise for AI consumers (related content, share blocks, CTAs).
On the settings form you can pick, per bundle, which view mode renders the Markdown
representation — it reuses Drupal's standard view modes (configure them under **Manage display**).
`MarkdownifyController::render()` reads
`supported_entities.<entity_type>.view_modes.<bundle>`; when unset it falls back to `full`,
keeping the default behavior unchanged.

## Reading / setting via drush

```bash
drush cget markdownify.settings default_converter        # -> league
drush cget markdownify.settings noindex                  # -> true
drush cget markdownify.settings supported_entities.node.bundles
drush cset markdownify.settings noindex 0 -y             # make Markdown indexable
```

After saving the form the router is rebuilt and the `rendered` cache tag is invalidated.

## Head link & token

Every HTML page of a supported entity gets `<link rel="alternate" type="text/markdown"
href="…​.md">` in `<head>` (`markdownify_page_attachments`). Supported entities also gain a
`markdownify` link template and a token `[<entity_type>:markdownify-url]` (see
[api/services.md](../api/services.md)).
