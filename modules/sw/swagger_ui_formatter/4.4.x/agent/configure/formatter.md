# Configure the Swagger UI formatters

No global settings page (`configure` null). Choose **Swagger UI** as the formatter on an
entity's **Manage display** tab (`admin/structure/…/display`) for a File or Link field, then
open the formatter cog. (The Swagger UI JS library must be installed first — see
[../api/library-discovery.md](../api/library-discovery.md).)

## The two formatters

| Formatter id | Label | Field type | Spec URL source |
|---|---|---|---|
| `swagger_ui_file` | Swagger UI | `file` | Absolute URL of the referenced managed file (`FileUrlGenerator::generateAbsoluteString`), access-checked per file. |
| `swagger_ui_link` | Swagger UI | `link` | The link item's URL (`$item->getUrl()->toString()`). |

Both are `final` classes using `SwaggerUIFormatterTrait`; the file formatter extends
`FileFormatterBase`, the link formatter `FormatterBase`.

## Settings (defaults from `SwaggerUIFormatterTrait::addDefaultSettings()`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `validator` | string | `default` | `none` / `default` (swagger.io online validator) / `custom`. |
| `validator_url` | string | `''` | Custom validator endpoint; only used when `validator` = `custom`. |
| `doc_expansion` | string | `list` | Initial expansion: `none` / `list` (tags only) / `full` (tags + operations). |
| `show_top_bar` | bool | `false` | Show Swagger UI top bar. |
| `sort_tags_by_name` | bool | `false` | Order tag groups alphabetically. |
| `supported_submit_methods` | array | all of `get,put,post,delete,options,head,patch` | HTTP methods that get the **Try it out** console. Empty = Try it out disabled (docs still show). |

Schema: `field.formatter.settings.swagger_ui_file` and `…swagger_ui_link`, both extending
`field_formatter_settings_swagger_ui_base`.

## Where settings are stored

```
core.entity_view_display.<entity>.<bundle>.<view_mode>:
  content:
    <field_name>:
      type: swagger_ui_file        # or swagger_ui_link
      settings:
        validator: default
        validator_url: ''
        doc_expansion: list
        show_top_bar: false
        sort_tags_by_name: false
        supported_submit_methods: [get, put, post, delete, options, head, patch]
```

## How it renders (`SwaggerUIFormatterTrait::buildRenderArray()`)

- Bails with a status-message error if the library integration isn't registered ("The Swagger
  UI library is missing, incorrectly defined or not supported"), or per-item if a file URL
  can't be built ("Could not create URL to file.").
- Per delta emits `#theme => swagger_ui_field_item` and attaches library
  `swagger_ui_formatter/swagger_ui_formatter.swagger_ui_integration` plus
  `drupalSettings.swaggerUIFormatter["<field_name>-<delta>"]` with keys `oauth2RedirectUrl`,
  `swaggerFile`, `validator`, `validatorUrl`, `docExpansion`, `showTopBar`, `sortTagsByName`,
  `supportedSubmitMethods`.
- `oauth2RedirectUrl` = `<scheme+host>/<library_dir>/dist/oauth2-redirect.html`.
- Cacheability from the library-discovery service is merged onto the element.

## Notes

- The `validator: default` setting sends the spec to swagger.io's **online** validator badge
  by default; set to `none` for internal/private specs you don't want validated off-site.
- File-field specs are access-checked (`getEntitiesToView`) — a user without access to the
  file entity won't get a rendered widget.
