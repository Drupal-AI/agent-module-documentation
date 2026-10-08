<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling the Insert View filter

The module has **no configure route and no settings**. The only thing to configure is *which
text formats run the filter*.

## UI

*Configuration → Content authoring → Text formats and editors*
(`/admin/config/content/formats`) → **Configure** a format → tick **Insert View** under
*Enabled filters* → Save.

## Config

Enabling writes into the `filter.format.<format_id>` config entity:

```yaml
# filter.format.iv_editorial
filters:
  insert_view:
    id: insert_view
    provider: insert_view
    status: true
    weight: 10
    settings: {  }
```

The plugin declares no settings, so `settings` stays empty. Read it back with:

```bash
drush cget filter.format.basic_html filters.insert_view
```

Scriptable:

```php
$format = \Drupal::entityTypeManager()->getStorage('filter_format')->load('basic_html');
$format->setFilterConfig('insert_view', ['status' => TRUE, 'weight' => 10]);
$format->save();
```

To find every format that has it on:

```php
foreach (\Drupal::entityTypeManager()->getStorage('filter_format')->loadMultiple() as $id => $f) {
  $c = $f->filters('insert_view')->getConfiguration();
  if (!empty($c['status'])) { print "$id weight={$c['weight']}\n"; }
}
```

## Filter weight matters

`insert_view` is `TYPE_TRANSFORM_IRREVERSIBLE`. Put it **before** filters that would mangle the
tag or escape the produced markup, and after nothing in particular. In practice: give it a
weight lower than *Convert line breaks into HTML* so `[view:…]` on its own line is not wrapped
in `<p>`, and be careful with *Limit allowed HTML tags* — since the replacement happens at
filter time, a restrictive HTML filter running afterwards can strip the view's markup.

## Security

The README's warning is real: the filter renders **any** view display named in the tag.
`InsertView::build()` only checks `$view->access($display_id)`, so every view display —
including the `default` display, which is often not access-restricted — becomes reachable to
anyone who can author text in a format with this filter enabled.

- Grant the filter only on formats restricted to trusted roles.
- Or create a separate format (e.g. `iv_editorial`) with the filter, and give it to editors only.
- Audit `$view->access()` settings on every display, not just page displays.

## Performance

The filter creates a **placeholder** per tag, so the surrounding text can still be cached while
the view itself is rendered (and cached) separately. The processed result declares:

- cache tag: `insert_view`
- cache contexts: `url`, `user.permissions`

Invalidate every embedded view at once with
`\Drupal::service('cache_tags.invalidator')->invalidateTags(['insert_view']);`.
