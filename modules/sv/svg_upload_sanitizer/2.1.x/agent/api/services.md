# Services and configuring the sanitiser (API)

All services are declared in `svg_upload_sanitizer.services.yml`. All classes are `@internal`.

| Service id | Class | Arguments |
|---|---|---|
| `svg_upload_sanitizer.sanitizer.svg` | `enshrined\svgSanitize\Sanitizer` | (none) |
| `svg_upload_sanitizer.helper.sanitizer` | `Helper\SanitizerHelper` | `@file_system`, `@svg_upload_sanitizer.sanitizer.svg` (calls `setLogger`) |
| `svg_upload_sanitizer.helper.file` | `Helper\FileHelper` | `@file_system` (calls `setLogger`) |
| `logger.channel.svg_upload_sanitizer` | logger channel | channel name `svg_upload_sanitizer` |

## The sanitiser — `svg_upload_sanitizer.sanitizer.svg`

This is the raw `enshrined\svgSanitize\Sanitizer` object (library `enshrined/svg-sanitize`, installed
`0.22.0`). It is an **allow-list** cleaner: it parses the SVG as XML with external-entity loading
disabled (XXE protection), keeps only whitelisted elements/attributes, and drops everything else. By
default this removes `<script>`, `<foreignObject>`, all `on*` event handlers, and `javascript:` /
non-image `data:` values in `href` / `xlink:href`. The module uses the library's **default
configuration** (`removeRemoteReferences = false`, `minifyXML = false`, `removeXMLTag = false`).

### Configuring the clean — decorate the service

The module exposes no settings form. The intended way to change sanitiser behaviour is a
[service decorator](https://symfony.com/doc/current/service_container/service_decoration.html) that
calls the library's setters. Example (from the README) that also strips remote references such as
`<image xlink:href="https://…">`:

```yaml
# mymodule.services.yml
services:
  mymodule.sanitizer.svg:
    decorates: svg_upload_sanitizer.sanitizer.svg
    class: enshrined\svgSanitize\Sanitizer
    calls:
      - [removeRemoteReferences, [TRUE]]
```

Other setter calls you can add the same way (library methods on `enshrined\svgSanitize\Sanitizer`):

- `minify(TRUE)` — minify the output XML.
- `removeXMLTag(TRUE)` — drop the leading `<?xml … ?>` declaration.
- `setAllowedTags($tagObject)` / `setAllowedAttrs($attrObject)` — replace the allow-list entirely
  (implement `enshrined\svgSanitize\data\TagInterface` / `AttributeInterface`).
- `setAllowedTags` / `setAllowedAttrs` are how you would add or remove specific tags/attributes.

After changing services YAML, rebuild the container (`ddev drush cr`).

## `SanitizerHelper` — `svg_upload_sanitizer.helper.sanitizer`

`Helper\SanitizerHelper::sanitize(FileInterface $file): bool` — the method the hook calls. Runs only
for `image/svg+xml` files; reads the file, runs it through the sanitiser service, writes the result
back in place. Returns `TRUE` on success, `FALSE` when skipped (wrong MIME, unresolved path, missing or
empty file), and throws `\Exception` if the write-back fails. See
[../hooks/file-insert.md](../hooks/file-insert.md). You can call it directly to sanitise an existing
managed file:

```php
$ok = \Drupal::service('svg_upload_sanitizer.helper.sanitizer')->sanitize($file);
```

## `FileHelper` — `svg_upload_sanitizer.helper.file`

`Helper\FileHelper::updateSize(FileInterface $file): bool` — resolves the file path, reads the current
byte size with `filesize()`, calls `$file->setSize()` and `$file->save()`. Called by the hook after a
successful sanitise so the entity's stored size matches the rewritten file. Errors are logged to the
`svg_upload_sanitizer` channel; it returns `FALSE` only when the path/size cannot be read.
