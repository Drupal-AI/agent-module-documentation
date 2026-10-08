# Bootstrap Materialize DateTime Picker — manual setup guide

**Bootstrap Materialize DateTime Picker** (`materialize_datetime_picker`) gives
Drupal's date and datetime fields a **Materialize‑styled date/time picker** — a
Material‑design calendar and clock widget that is friendlier and better‑looking
than the default HTML date input. It works for both date‑only and date‑and‑time
fields, is responsive, supports 12‑ and 24‑hour formats, and can be localised for
both the date and time pop‑ups.

You apply it as a **field widget** on a datetime field's *Manage form display*, and
it is also available as a custom **form element** (`materialize_date_time`) you can
drop into any custom form in code. Per field you can control the hours format,
minute granularity, which weekdays are disabled, which day the week starts on, and a
list of specific dates to disable (for holidays or blackout days). A site‑wide
settings form provides global defaults and per‑field‑ID overrides.

> **Note on assets:** the picker's front‑end library pulls several assets from
> third‑party CDNs and hosts (for example BootstrapCDN, cdnjs, momentjs, and Google
> Fonts). That means visitors' browsers make requests to those external hosts (a
> privacy consideration) and the widget depends on those CDNs being reachable (an
> availability/supply‑chain consideration). If that matters for your site, plan to
> serve the assets locally or review the library definition before relying on it in
> production. There are no server‑side data‑fetching or mutating endpoints beyond
> the permissioned admin config form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — apply the widget to a field and set
   its options, plus the site‑wide defaults.

## Where it lives in the admin menu

- **Structure → *(content type)* → Manage form display** — choose the **Materialize
  DateTime Picker** widget for a date/datetime field and set its per‑field options.
- **Configuration → Materialize → DateTime Picker Config**
  (`/admin/config/materialize/datetime_picker_config`) — global defaults and
  per‑field‑ID overrides.
