<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Text-format filter: LabelLinkFixFilter

`src/Plugin/Filter/LabelLinkFixFilter.php` — class `LabelLinkFixFilter extends FilterBase`.

## Plugin annotation

- id: `label_link_fix_filter`
- title: *"Fix CKEditor5 label/link nesting issue"*
- description: *"Repairs label wrapping split over links and cite."*
- type: `TYPE_TRANSFORM_IRREVERSIBLE`
- weight: `101` (runs late in the filter pipeline)
- provider: `ckeditor5_label_fix`
- settings: `{}` (no configurable settings, no settings form)

## Behavior — `process($text, $langcode)`

Runs a single `preg_replace_callback` over the input with the case-insensitive pattern:

```
#<label([^>]*)>([^<]*?)</label>\s*(<a[^>]+>[^<]+(?:<cite>[^<]+</cite>)?</a>[^<]*)<label[^>]*>(.*?)</label>#i
```

This matches the mangled shape CKEditor 5 produces — a `<label>` … `</label>`, then an `<a>` link
(optionally wrapping a `<cite>`), then a second `<label>` … `</label>`. The callback reassembles
the four captures into a single label:

```
'<label' . $label_attrs . '>' . $before_text . $link_html . $after_text . '</label>'
```

Returns `new FilterProcessResult($text)`. It only **rearranges text already captured from the
input**; it does not inject new markup or unescape content. Because it is
`TYPE_TRANSFORM_IRREVERSIBLE`, output is not shown back in the editor.

## Operating notes

- Enable this filter on the same text format as the plugin, under the format's *Filters* list.
- Filter ordering matters: it should run after the HTML-restricting filter so the reassembly
  operates on the sanitized, allowed tags. Its weight is 101; adjust the format's filter
  processing order if labels are still split.
- Together with the CKEditor 5 plugin ([editor-plugin.md](editor-plugin.md)), new edits keep
  labels intact in the model, while this filter repairs pre-existing mangled content on render.
