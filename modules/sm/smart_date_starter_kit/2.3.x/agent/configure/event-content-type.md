# The Event content type and the `field_when` Smart Date field

There is **no settings form**. Everything below is imported once from `config/install/*` at
module enable, then owned by your site. Edit it at the normal admin URLs afterward; uninstalling
the module does **not** remove it (you must delete the Event type and Events view manually, which
is also required before the module can be re-installed).

## Event node type (`node.type.event`)

| Property | Value |
|---|---|
| Machine name | `event` |
| Label | Event |
| Description | "Content which describes something happening at a specific time." |
| New revision | true (revisions on by default) |
| Preview before submit | optional (`preview_mode: 1`) |
| Display author + date | false |
| Menu settings | `menu_ui` third-party settings present, no menus available by default |

Manage at `admin/structure/types/manage/event`.

## Fields

| Field | Machine name | Type | Cardinality | Notes |
|---|---|---|---|---|
| When | `field_when` | `smartdate` (Smart Date) | **-1 (unlimited)** | The event start/end. Not required. Storage `field.storage.node.field_when`. |
| Body | `body` | `text_with_summary` | 1 | Standard body; storage shipped as optional config `field.storage.node.body`. |

`field_when` default value (from `field.field.node.event.field_when`): `default_duration: 60`
minutes, `default_date_type: next_hour`, and duration options `30 / 60 (1 hour) / 90 / 120
(2 hours) / custom`.

The **unlimited cardinality is deliberate** so the field can hold recurring instances. To restrict
to a single date, change it at
`admin/structure/types/manage/event/fields/node.event.field_when/storage` **before** creating any
Event content.

## Form display (`node.event.default`)

- `field_when` uses the **`smartdate_inline`** widget (weight 7): `modal: false`, `hide_date: true`,
  `allday: true` (all-day toggle shown), `separator: "to"`, `duration_overlay: '1'`,
  `remove_seconds: false`, plus the same duration increments as above.
- `body` uses `text_textarea_with_summary` (9 rows). Also exposed: `title`, `uid` (author
  autocomplete), `created`, `promote`, `sticky`, `status`, and a `path` alias widget.

## View displays

| View mode | `field_when` formatter | Label | Other |
|---|---|---|---|
| default (`node.event.default`) | `smartdate_default` | above | `format_type: medium`, `time_wrapper: true`; body `text_default`; links. |
| teaser (`node.event.teaser`) | `smartdate_default` | inline | body `text_summary_or_trimmed` (trim 600); links. The `teaser` view mode itself ships as optional config `core.entity_view_mode.node.teaser`. |

## Recurring events

Recurring dates are **not enabled by default** but the config supports them. Enable the
**Smart Date Recur** submodule of Smart Date, then open
`admin/structure/types/manage/event/fields/node.event.field_when` and turn on recurring values.
See [smart_date](../../../../smart_date/4.3.x/agent/start.md) for the Smart Date field/formatter
details this kit configures.

## Optional pathauto pattern

If the **Pathauto** module is installed, `config/optional/pathauto.pattern.events.yml` is imported:
pattern `/events/[node:title]` scoped to the `event` bundle (id `events`, weight -5).

## Extending

The kit is a starting point — the README expects you to add fields (e.g. a location) and adjust
the view. Add fields at `admin/structure/types/manage/event/fields`; they will not conflict with
the shipped config.
