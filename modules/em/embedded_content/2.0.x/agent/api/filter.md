<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `embedded_content` filter & the tag round trip

## The filter

Plugin `@Filter(id = "embedded_content", type = TYPE_TRANSFORM_REVERSIBLE, weight = 100)`
(`src/Plugin/Filter/EmbeddedContent.php`). Enable it on any CKEditor 5 text format
(`filter_format` → `filters.embedded_content.status: true`).

On output it loads the body HTML and finds `<embedded-content>` and `<embedded-content-inline>`
elements via XPath. For each:

1. Reads `data-plugin-id` and JSON-decodes `data-plugin-config`.
2. Creates the plugin instance via `plugin.manager.embedded_content`
   (`createInstance($plugin_id, $config)`).
3. Adds `$instance->getAttachments()`, calls `$instance->build()`, renders it in a render context,
   and merges bubbleable metadata (cache tags/contexts, attachments).
4. Replaces the tag with the rendered markup. On any error it prints a safe message naming the
   plugin id, so a broken/missing plugin doesn't fatal the page.

The result is a `FilterProcessResult` carrying the bubbleable metadata, so component cache and library
attachments propagate correctly.

## The stored tag

The CKEditor plugin inserts markup like:

```html
<embedded-content
  data-button-id="components"
  data-plugin-id="callout"
  data-plugin-config='{"text":"Hello"}'></embedded-content>
```

- `data-plugin-id` — which `embedded_content` plugin to render.
- `data-plugin-config` — JSON of that plugin's instance configuration (produced from the plugin's
  config form, after `massageFormValues()`).
- `data-button-id` — the button that inserted it.
- Block components use `<embedded-content>`; inline components (plugin `isInline() === TRUE`) use
  `<embedded-content-inline>`.

These elements are declared as allowed by the module's CKEditor 5 plugin, so editors never need raw
HTML permission. In CKEditor the tags are **upcast** to a live preview (rendered via the
`embedded_content.preview` controller) rather than shown as raw markup.

## Related services / routes

- `plugin.manager.embedded_content` — the plugin manager.
- `embedded_content.preview` (`/embedded-content/preview/{editor}`) — renders a plugin for the editor
  preview.
- `embedded_content.dialog` (`/embedded-content/dialog/{embedded_content_button}/{filter_format}`) —
  the insert/edit dialog form.
