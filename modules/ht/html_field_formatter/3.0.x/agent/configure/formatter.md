# Configure the HTML field formatter

No global settings. You enable it per field on an entity bundle's **Manage display** tab
(`admin/structure/…/display`) by setting the field's *Format* to **HTML**. Source:
`src/Plugin/Field/FieldFormatter/HtmlFormatter.php`.

## Where it applies

`@FieldFormatter(id = "html", field_types = { text, text_long, text_with_summary, string, string_long })`.
Only fields of those types offer "HTML" in the Format dropdown.

## The one setting: `allowed_tags`

- Formatter settings form shows a single textarea, **Allowed tags** ("one tag per line").
- Stored in the `entity_view_display` component: `content.<field>.settings.allowed_tags` (a single
  string; the module splits it on `\r\n` and strips `<`/`>`). Default: `[]` (empty).
- Settings summary shows `Allowed tags: <list>` when set.

## Rendering behaviour (the important part)

`viewElements()` branches on whether allowed tags are set:

| `allowed_tags` | Render array | Result |
|---|---|---|
| **empty (default)** | `$elements[$delta] = ['#children' => $value]` | Value emitted **verbatim, no escaping/filtering**. |
| non-empty | `['#markup' => $value, '#allowed_tags' => [...]]` | Core runs `Xss::filter($value, $allowed_tags)` — only listed tags survive. |

So the default is a raw passthrough. Provide an `allowed_tags` whitelist to get sanitized output.

## Protecting against XSS (required — this is by design)

This formatter emits the field value as HTML **on purpose** — that is the module's whole job.
With the default empty `allowed_tags`, the value is rendered verbatim via `#children` with **no
escaping and no `Xss::filter`**, so any markup in the field (including `<script>`) reaches the
page as-is. That is expected behaviour, not a module bug — but it means **XSS protection is the
integrator's responsibility**. When wiring this formatter, you MUST ensure one of:

- **Only apply the `html` format to fields whose content comes from trusted roles.** Anyone who
  can edit a field displayed with the empty-`allowed_tags` HTML formatter can inject stored
  script that runs for every viewer of the entity — treat "edit this field" as equivalent to a
  raw-HTML / full-HTML-format capability and gate the field/role accordingly.
- **Or set an `allowed_tags` whitelist** (as in the Drush example below), which switches
  rendering to `#markup` + `#allowed_tags` so core `Xss::filter()` strips every unlisted tag —
  the safe choice when the field may be edited by lower-privileged/untrusted roles.

Do not point this formatter at a field populated from untrusted input (imports, webforms, user
profiles, remote feeds) without an `allowed_tags` whitelist.

## Set the formatter with Drush (example)

```php
// drush php:eval — render node.article field_embed as HTML, restricted to a safe tag subset.
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_embed', [
  'type' => 'html',
  'region' => 'content',
  'settings' => ['allowed_tags' => "p\r\na\r\nstrong\r\nem"],
])->save();
```

Leave `settings.allowed_tags` as `''` (or omit) for fully unfiltered output.
