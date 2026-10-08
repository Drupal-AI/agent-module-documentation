# eca_views plugins

Requires core `views`. Registers into ECA Core managers. Config schema:
`config/schema/eca_views.schema.yml`.

**Events** (`ViewsEvent`, `ViewsEventDeriver`): tied to Views query execution.

**Actions** (`src/Plugin/Action`):
- `ViewsQuery` — execute a View's query and expose its results to the model.
- `ViewsSetFilter` — set/override an exposed filter value before running.
- `ViewsQuerySubstitution` — substitute query arguments/tokens.
- `ViewsExport` — export the result set.

No conditions of its own; combine result rows with `eca_base` list actions and `eca_content`
entity actions to process each row.
