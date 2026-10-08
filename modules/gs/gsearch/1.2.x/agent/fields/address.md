# Address field (`address_gsearch`)

One field type with a matching widget and formatter, all with plugin id `address_gsearch`.
Requires the `token` in `gsearch.settings` to be set (see `configure/settings.md`).

## Add the field

1. On any fieldable entity (content type, user, etc.) add a field of type
   **"Address Dataforsyningen/GSearch"**.
2. In *field settings* optionally tick **"Allow storing free-text addresses"**
   (`allow_freetext`) to accept non-Danish / unvalidated input.
3. In *form display* configure the widget (see settings below); the widget uses Select2.

## Field type — `AddressGsearchItem`

`src/Plugin/Field/FieldType/AddressGsearchItem.php`. `mainPropertyName()` is `value`;
`isEmpty()` is true when `value` is empty. Stored columns / properties:

| Column | Type | Meaning |
|---|---|---|
| `id` | varchar(255), indexed | Dataforsyningen address id (UUID) |
| `user_input` | varchar(255) | Raw text the user searched/entered (required property) |
| `value` | varchar(255) | Full human-readable address (`visningstekst`, or free text) — the main value |
| `address` | varchar(255) | Combined `[vejnavn] [husnummer], [etage]. [dør]` |
| `postal_code` | varchar(255) | `postnummer` |
| `postal_name` | varchar(255) | `postnummernavn` |
| `country_code` | varchar(255) | ISO country code; `DK` for GSearch matches |
| `latitude` | float | WGS84 latitude |
| `longitude` | float | WGS84 longitude |

Field setting: `allow_freetext` (boolean, default 0).

Typed getters (via `AddressGsearchItemInterface`): `getUserInput()`, `getAddress()`,
`getPostalCode()`, `getPostalName()`, `getCountryCode()`, `getCountryName()` (translated country
label via `CountryManager::getStandardList()`), `getLatitude()`, `getLongitude()`. `getString()`
returns just `value` (overriding Map's comma-join of all properties).

## Widget — `AddressGsearchWidget`

`src/Plugin/Field/FieldWidget/AddressGsearchWidget.php`. Renders a `select2` element with
`tags => TRUE` and autocomplete wired to route `gsearch.autocomplete.select2`; attaches library
`gsearch/base`. Widget settings:

| Setting | Type | Default | Purpose |
|---|---|---|---|
| `size` | integer | 60 | Text field size |
| `placeholder` | string | `''` | Placeholder text ("Type to search address…" if empty) |
| `freetext_coords` | boolean | FALSE | Show latitude/longitude inputs in free-text mode |

How submitted values are resolved (`massageFormValues()`):
- Select2 submits a single value. The module packs `id` + display `query` into it via
  `Gsearch::encodeSelect2Value()` (base64url of `{"id","query"}`) and recovers both with
  `decodeSelect2Value()`, because GSearch cannot resolve an id alone — it needs `q` + an
  `"id"='…'` filter together (`Gsearch::getFieldValueById()`).
- If **free-text** is enabled and the editor ticks "Enable freetext", the widget shows
  `address` / `postal_name` / `postal_code` / `country` (and lat/long when `freetext_coords`)
  textfields, and stores them verbatim with `id => ''` and `country_code` from the select.
- A search value that can't be resolved and isn't free-text raises a form error.

## Formatter — `AddressGsearchFormatter`

`src/Plugin/Field/FieldFormatter/AddressGsearchFormatter.php`. Renders each item through the
`gsearch_address` theme hook, passing `value`, `address`, `postal_code`, `postal_name`, and
`country` (country name is only passed when `country_code` is not `DK`).

## Rendering / theme

Two theme hooks (`gsearch_theme()` in `gsearch.module`), overridable templates in `templates/`:
- `gsearch_address` (`variables: content`) → `gsearch-address.html.twig` — an `<address>` block
  printing the street line then `postal_code postal_name`, plus country when non-DK; falls back to
  `content.value` when no `address`.
- `gsearch_addresses` (`variables: items`) → `gsearch-addresses.html.twig` — loops pre-rendered
  items.

CSS library `gsearch/base` (`assets/gsearch.css`) lays out the free-text row (`.gsearch__main`).
