# Configuration

External Data Source has no site-wide settings page. You configure everything on
a field of type **External Data Source Field**, in three places: the field's
storage settings, its form-display widget, and its display formatter.

## Add the field

1. Go to the Manage fields screen for your bundle — for a content type, **Structure
   → Content types → (edit a type) → Manage fields** — and add a new field of
   type **External Data Source Field**.
2. On the field's **storage settings**, set:
   - **External Data Source** (`ws`, default `countries`) — the data-source
     plugin that supplies the options. The shipped choices are `countries`,
     `franceregions`, and `francezipcodes`; any custom data-source plugin you
     add appears here too.
   - **Max result count** (`count`, default `10`) — the maximum number of remote
     suggestions to request.
   - **Maximum length** (`max_length`, default `255`) — the varchar length used
     to store the chosen value.

   > These storage settings become **locked once the field holds data**, so pick
   > the data source before editors start using the field.

## Choose a widget (Manage form display)

On the bundle's **Manage form display**, pick how editors select a value:

- **Select** (`external_data_source_select_widget`, the default) — a `<select>`
  dropdown built from the remote options at form-build time, with a "None"
  option prepended.
- **Checkboxes / radios** (`external_data_source_checkboxes_widget`) — checkboxes
  for a multi-value field, radios for single-value.
- **Autocomplete** (`external_data_source_auto_complete_widget`) — a text field
  that queries the remote service as the editor types. Best for large datasets,
  where a full dropdown would be unwieldy.

Each widget also offers **size** and **placeholder** settings.

## Choose a formatter (Manage display)

On **Manage display**, the **External Data Source** formatter
(`external_data_source_formatter`) prints the stored value as escaped plain text
(with line breaks preserved). This is what shows on the rendered entity.

## Notes on the data source

- The built-in plugins call **fixed, hardcoded** third-party endpoints; the
  search term the editor types is appended to that fixed API's query. There is
  no admin field for a custom URL, and the request cannot be redirected to
  another host.
- The autocomplete widget uses the module's autocomplete route
  (`/external_data_source/autocomplete`), which is available to any user with the
  **Access content** permission.
- To back a field with your own REST/JSON service, write an `@ExternalDataSource`
  plugin — see the agent docs at
  [`agent/plugins/data-source.md`](../agent/plugins/data-source.md). After adding
  one and clearing caches, it appears in the **External Data Source** storage
  setting.
