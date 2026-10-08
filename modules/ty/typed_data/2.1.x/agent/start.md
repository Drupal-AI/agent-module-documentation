# typed_data — agent start

Developer infrastructure extending core's Typed Data API: property-path data fetching,
`{{ }}` placeholder resolution with filters, and pluggable form widgets. No UI, no
permissions, no config. Foundation for Rules. Core-only dependency.

- Services: data fetcher + placeholder resolver → [api/services.md](api/services.md)
- Plugin types it defines (DataFilter, TypedDataFormWidget) + how to add one → [plugins/plugin-types.md](plugins/plugin-types.md)
- Drush commands (list entities/contexts/datatypes/filters/widgets) → [drush/commands.md](drush/commands.md)
