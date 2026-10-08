# Configuration

International Phone is configured in two places: a small **global settings form**
(where the JavaScript library comes from) and the **per-field widget and
formatter settings** (how each phone field behaves and displays).

## Global settings — CDN vs local library

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → International Phone** (`/admin/config/phone_international`).

The single setting here is:

- **Load assets from CDN** — when enabled, the intl-tel-input JavaScript and CSS
  are loaded from the jsDelivr CDN. When disabled, the module expects a local copy
  in `libraries/intl-tel-input` (use the `drush phone_international:plugin` command
  to fetch it — see [Installation](../installation/index.md)). Choose local if you
  need to avoid third-party requests for privacy or offline reasons.

Click **Save configuration**.

## Per-field widget settings

Each phone field is configured on its own, on **Structure → Content types →
*(type)* → Manage form display**. Select the **International Phone** widget for the
field and open its gear icon to reveal the options:

- **Initial country** — the country flag/dial code shown by default (default
  `PT`). Set this to your primary audience's country (e.g. `GB`, `US`).
- **Geolocation** — when on, the widget auto-detects the visitor's country (via
  `ipinfo.io`) and preselects that flag, overriding the initial country. Note this
  makes a request to an external service.
- **Preferred countries** — a list of countries pinned to the top of the selector
  for quick access (default `PT`).
- **Countries** — controls which countries are selectable: **all**, **exclude** a
  list, or **include** only a list.
- **Exclude / include countries** — the list of country codes used by the mode
  above (either the ones to hide, or the only ones to allow).
- **Dial code** — show the separate country dial code next to the flag.
- **National number** — display numbers in national format rather than the full
  international form in the input (default on).
- **Auto placeholder** — show an example number as placeholder text that updates
  with the selected country: **off**, **aggressive** (default), or **polite**.

## Per-field display (formatters)

On **Manage display** for the same field, pick how the stored number renders:

- **International phone** (`phone_international_formatter`) — renders a valid
  number as a clickable `tel:` link; invalid values are shown as escaped plain
  text.
- **Plain** (`phone_international_basic_string`) — shows the number as plain text.

## How validation and storage work

You don't configure this, but it's good to know: whatever an editor types is run
through the `phone_international.validate` service on save, which uses
`libphonenumber` to parse and reformat the value to **E.164** (for example
`+351912345678`). Invalid or impossible numbers are rejected at form submission,
so every saved value is a real, canonical number.
