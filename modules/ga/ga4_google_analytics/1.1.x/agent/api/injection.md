<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the tracking snippet is injected

The module has no public API to call — it works entirely through two hooks in
`ga4_google_analytics.module`. This doc explains the mechanism so you can predict when the
`gtag.js` snippet appears.

## `hook_page_attachments()`

On every page render, `ga4_google_analytics_page_attachments()`:

1. Reads `ga4_google_analytics.config`. If `measurement_id` is empty, it does nothing.
2. Evaluates the **role** condition: the current user must hold at least one role in
   `ga4_access_roles`; if that list is empty, everyone passes.
3. Evaluates the **page** condition using core's `request_path` condition plugin, configured
   from `ga4_access_pages`. The snippet is added when `negate XOR condition->evaluate()` is true
   (i.e. "listed pages only" vs "everywhere except listed pages").
4. When both pass, it sanitises `scripts_custom_attributes` (regex allow-list of
   `async` / `type="…"` / `data-*="…"` / `crossorigin="anonymous"`, then `Xss::filter()`) and the
   Measurement ID (`Xss::filter()`), and appends an `html_head` render array themed by the
   `ga4_google_analytics` theme hook.

## `hook_theme()` / template

`hook_theme()` registers the `ga4_google_analytics` theme hook with variables `measurement_id`
and `script_attributes`. The template `templates/ga4-google-analytics.html.twig` emits the
standard Google tag:

```html
<script async {{ script_attributes|raw }} src="https://www.googletagmanager.com/gtag/js?id={{ measurement_id }}"></script>
<script {{ script_attributes|raw }}>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', '{{ measurement_id }}');
</script>
```

Override the snippet markup by overriding the `ga4_google_analytics` template in your theme.
There are no other extension points — no events, services, or plugins.
