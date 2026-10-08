# Configure the Options limit handler

The feature is a WebformHandler plugin `options_limit`
(`Drupal\webform_options_limit\Plugin\WebformHandler\OptionsLimitWebformHandler`).

## Attach it
`/admin/structure/webform/manage/{webform}/handlers` → **Add handler** → *Options limit*.
Add one handler per options element you want to limit.

## Key settings (schema: `config/schema/webform_options_limit.schema.yml`)
- **element_key** — the select/checkboxes/radios element to limit.
- **limits** — per-option-value limit map; plus an optional overall **limit** (total).
- **limit_reached_message** / **limit_source_entity** — messaging and scope.
- **option_message**, **option_multiple_message** — templates shown per option.
- **option_none_action** — what to do with a reached option: `disable`, `remove`, or `none`.
- **option_message_display** — where the remaining/label text appears.
- **default_messages / label templates** — e.g. `{label} [{remaining} remaining]`.

## Summary report
`/admin/structure/webform/manage/{webform}/results/options-limit`
(route `entity.webform_options_limit.summary`; node variant
`entity.node.webform_options_limit.summary`) lists each option's limit, count, and remaining.

Handlers export with the webform config, so limits deploy across environments.
