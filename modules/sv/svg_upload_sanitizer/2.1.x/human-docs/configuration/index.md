# Configuration for developers

SVG Upload Sanitizer has **no configuration UI** and no settings — out of the box
it uses the default behaviour of the `enshrined/svg-sanitize` library, and for
most sites that is exactly what you want. This page is only relevant if you are a
developer who needs to change how the sanitiser behaves.

The module has no opinion about how the sanitiser is configured, but it exposes
the sanitiser as a Drupal service (`svg_upload_sanitizer.sanitizer.svg`) that you
can **decorate** to call the library's own configuration methods. For example, to
also remove references to remote files, add a service decorator in a custom module:

```yaml
# mymodule.services.yml
services:
  mymodule.sanitizer.svg:
    decorates: svg_upload_sanitizer.sanitizer.svg
    class: enshrined\svgSanitize\Sanitizer
    calls:
      - [removeRemoteReferences, [TRUE]]
```

Any method the `enshrined/svg-sanitize` `Sanitizer` class offers can be driven
this way through the decorator's `calls`. If you do not add a decorator, the
library's defaults apply and every uploaded SVG is still sanitised — you only need
this when you want to tighten or adjust the cleaning rules.
