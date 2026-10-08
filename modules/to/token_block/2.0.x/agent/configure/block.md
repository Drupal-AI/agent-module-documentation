# Configure a Token Block

No dedicated settings page (`configure` null). Everything happens in core **Block Layout**
(`admin/structure/block`):

1. **Place block** in a region → search for **Token Block** (category "Token Block").
2. In the block config form, fill the **Body** field (`#type => text_format`, format forced to
   `full_html`). A "Browse available tokens" link (`token_tree_link`) is shown.
3. Save. The body is stored in the block config entity.

## Where settings live

```
block.block.<id>:
  settings:
    id: token_block
    body:
      value: '…text with [tokens]…'
      format: full_html      # stored but NOT applied at render (see below)
```

Config schema: `block.settings.token_block` (`body` is `type: text_format`).

## Render behavior (`TokenBlock::build()`)

```php
$description = $this->token->replace($this->configuration['body']['value']);
return ['#markup' => $description];
```

- The stored **value** is token-replaced with the core `token` service, then returned as
  `#markup`.
- **The selected text format's filters are not run.** Despite the form using
  `#type => text_format` / `full_html`, only `body['value']` is used; the format is ignored.
- `#markup` is auto-sanitized by `Xss::filterAdmin()` (Drupal render pipeline) — this strips
  `<script>`, event-handler attributes, etc., but permits a broad admin HTML tag set.

### Markup / token output responsibility

Whoever configures the block controls raw admin HTML that is emitted with only
`Xss::filterAdmin()` applied (not a text-format filter). Treat placing/editing a Token Block
as an admin-trust operation (it is gated by core's **Administer blocks** permission). Do not
embed unfiltered untrusted token values (e.g. user-supplied field tokens) expecting the text
format to sanitize them — it will not; only `filterAdmin` runs. This is by-design behavior of
the module, not a configuration option.

## Cache metadata

`TokenBlock` overrides:
- `getCacheContexts()` → merges `url.path`, `url.query_args`, `languages`, `route` (block
  re-renders per URL/language/route).
- `getCacheTags()` → when the current route has a `node` parameter, merges `node:<id>` so a
  block using node tokens is invalidated when that node changes.

## Set one with Drush (example)

```php
// drush php:eval
$b = \Drupal::entityTypeManager()->getStorage('block')->create([
  'id' => 'token_copyright', 'plugin' => 'token_block', 'region' => 'footer',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'settings' => ['id' => 'token_block', 'label' => 'Copyright',
    'body' => ['value' => 'Copyright [date:custom:Y] [site:name]', 'format' => 'full_html']],
]);
$b->save();
```
