<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the HTML Purifier filter

There is no module-level settings page. You configure it (a) per text format and (b) via one global
config object for the cache path.

## Enable per text format

**Configuration → Content authoring → Text formats and editors**
(`admin/config/content/formats`) → edit a format → check **HTML Purifier** under *Enabled filters* →
open its settings vertical tab.

Stored in the format's own config entity:

```yaml
# filter.format.<format_id>  →  filters.htmlpurifier
status: true
weight: 100                 # see "Filter order" below — keep it last
settings:
  htmlpurifier_configuration: |    # schema: filter_settings.htmlpurifier
    HTML:
      Allowed: 'p,br,strong,em,a[href],ul,ol,li'
    URI:
      AllowedSchemes:
        http: true
        https: true
        mailto: true
```

- **Empty `htmlpurifier_configuration`** → the filter uses `HTMLPurifier_Config::createDefault()`
  (a permissive but safe whitelist). The settings-form textarea is pre-filled with the full default
  directive set (minus the `Cache` namespace) as a starting point.
- The YAML is `Yaml::decode()`d and each `Namespace: { Key: value }` pair becomes
  `$purifier_config->set("Namespace.Key", value)`. Directive reference:
  http://htmlpurifier.org/live/configdoc/plain.html
- The **`Cache` namespace is silently dropped** if present — you cannot configure Purifier's cache
  from a text format (it's managed globally, below).
- Invalid directives are caught at save time: the form traps the library's `trigger_error()` output
  via a custom error handler and shows it as a validation error (deprecation notices are ignored).

## Filter order (important for security)

The filter is `TYPE_TRANSFORM_IRREVERSIBLE`. Like any sanitizer it must run **after** — i.e. have a
higher weight / sit lower in the *Filter processing order* list than — any filter that can inject or
re-introduce markup (e.g. "Convert line breaks", "Convert URLs into links", media/embed filters).
Placed too early, later filters could add unsanitized HTML. Enable it only on formats that accept
untrusted input; it is not on by default and adds nothing to a plain-text format.

## Global: serializer cache path

```yaml
# htmlpurifier.settings   (config/install ships cache_serializer_path: '')
cache_serializer_path: ''   # empty → [temp dir]/htmlpurifier
```

`HtmlPurifierFilter::process()` reads this, falls back to `file_system->getTempDirectory().'/htmlpurifier'`
when empty, and `prepareDirectory()`s it (create + make writable) each run, then sets
`Cache.SerializerPath`. Set an absolute, writable path for a stable/fast cache on multi-server sites:

```
drush cset htmlpurifier.settings cache_serializer_path /var/cache/htmlpurifier -y
```

## What it does NOT provide

No permissions, no plugin types to implement, no services to call, no Drush, no submodules. The only
moving parts are the one filter plugin and this one config object.
