# Configure Noopener Filter

Two separate switches. Turn on either or both.

## 1. Text-format filter (WYSIWYG / CKEditor content)

The filter plugin `filter_noopener` (label "Add noopener to all links", type
`TYPE_HTML_RESTRICTOR`) rewrites rendered body markup: for every `<a>` whose `target` is
exactly `_blank`, it adds `noopener` to `rel` (prepended to any existing value).

Enable it per text format:

- UI: *Configuration → Content authoring → Text formats and editors*
  (`/admin/config/content/formats`) → **Configure** a format → under **Enabled filters**
  tick **Add noopener to all links** → **Save configuration**.
- Config: the format's `filter.format.<id>.yml` gains a `filters.filter_noopener` entry
  with `status: true`. Enable via drush:

```bash
drush php:eval '
  $fmt = \Drupal::configFactory()->getEditable("filter.format.full_html");
  $filters = $fmt->get("filters");
  $filters["filter_noopener"] = ["id"=>"filter_noopener","provider"=>"noopener_filter","status"=>true,"weight"=>20,"settings"=>[]];
  $fmt->set("filters", $filters)->save();
'
```

Scope: only the editor markup passed through that text format. A link without
`target="_blank"` is left untouched; only `noopener` is added (never `noreferrer`).

## 2. Global link-alter flag (Drupal-generated links)

Independently, `hook_link_alter()` can add `noopener` to links built by Drupal's link
generator (`#type => 'link'`, `Link::toRenderable()`, menu links, etc.) that carry
`target=_blank`. This is **off by default** and controlled by one boolean config value.

- Config object: `noopener_filter.settings`, key `filter_links` (boolean, default falsey —
  the config object is only created once the settings form is saved).
- Settings form route: `noopener_filter.settings` → `/admin/config/noopener-filter/settings`
  (a single "Filter links" checkbox). Menu link lives under *Configuration → Content*.
- Permission gating that form: `administer noopener filter`.

Enable via drush:

```bash
drush cset noopener_filter.settings filter_links 1 -y
# disable:
drush cset noopener_filter.settings filter_links 0 -y
# read current value:
drush cget noopener_filter.settings filter_links
```

There is no config schema shipped for `noopener_filter.settings`, so `drush cset` may warn
about a missing schema — the value is still written and read by `hook_link_alter()`.

## Notes
- The two mechanisms are independent: enabling the filter on a format does **not** require
  the `filter_links` flag, and vice-versa.
- No field type, no plugin type, no Drush commands, no module dependencies.
