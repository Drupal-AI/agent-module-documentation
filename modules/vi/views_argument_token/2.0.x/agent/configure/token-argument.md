# Configure the Token argument default

There is **no admin settings page** (`configure` is null). The plugin is configured per view,
on a single contextual filter.

## In the Views UI

1. Edit a view → *Advanced → Contextual filters* → add or edit an argument.
2. Under **When the filter value is NOT available**, choose *Provide default value*.
3. Set **Type** to **Token**.
4. Fill the **Token** field with a token string, e.g. `[node:field_tags]` or
   `[current-user:uid]`. The embedded token-tree link ("Browse available tokens") lists
   available tokens (provided by the Token module).
5. To match a multi-value contextual filter, enable *Allow multiple values* on the filter
   (bottom of the form) and, if the source is a field, tick **Get fields raw values**.

## Option keys (config schema `views.argument_default.token`)

Stored under the display's `arguments.<id>.default_argument_options`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `argument` | string | `''` | The token string to resolve (e.g. `[node:field_category]`). |
| `process` | int (0/1) | `0` | "Get fields raw values" — replace field tokens with the stored raw value (e.g. entity-reference target ID) instead of the token module's rendered value. Only meaningful for field tokens. |
| `and_or` | string | `+` | How multiple field values are joined: `+` = OR, `,` = AND. Only used when `process` is on. |
| `all_option` | int (0/1) | `1` (TRUE) | Send the literal `all` when the resolved value is empty. Requires the filter's "all" exception argument to be enabled to have effect. |
| `debug` | int (0/1) | `0` | Print the resolved argument as a status message (build-time debugging). |

Also set on the argument itself: `default_argument_type: token`.

## Where it lives / drush

The choice is part of the view, so it is in `views.view.<view_id>` config:

```
drush config:get views.view.<view_id> \
  display.<display_id>.display_options.arguments.<arg_id>.default_argument_type
# => token
drush config:get views.view.<view_id> \
  display.<display_id>.display_options.arguments.<arg_id>.default_argument_options
# => { argument: '[node:field_tags]', process: 0, and_or: '+', all_option: true, debug: 0 }
```

There is no global config object and no `config/install` file; export/import the whole view to
deploy the setting.
