# Configuration

Telephone Advanced has **no central settings page**. Everything is configured per
field, on the same telephone field you already use — you just point the field's
form widget and display formatter at the ones this module provides, and set the
options there. Because it extends the core telephone field, there is no data
migration and no field conversion involved.

## Turn on validation (form widget)

1. Go to the content type (or other entity) that has your telephone field, and open
   **Manage form display**.
2. Find your telephone field and set its **Widget** to the Telephone Advanced
   widget.
3. Open the widget's settings (the gear icon) to configure how numbers are
   accepted and validated. This is where per‑field settings live — for example the
   default/expected country used to interpret numbers entered without a `+`
   country code, and any restriction on the line type (for instance accepting
   **mobile numbers only**, using libphonenumber's classification of mobile, fixed
   line, toll‑free, and so on).
4. Save.

From now on, numbers entered into that field are validated with libphonenumber and
impossible numbers are rejected at entry.

## Choose the display format (formatter)

1. On the same entity, open **Manage display**.
2. Set the telephone field's **Format** to the Telephone Advanced formatter.
3. Open its settings to pick the **output format**. libphonenumber supports several:
   - **E.164** — the canonical `+447700900123` form, ideal for storing and
     comparing numbers.
   - **International** — a readable international form.
   - **National** — the number as written locally.
   - **RFC3966** — a `tel:` form suitable for a click‑to‑call link.
4. Save.

## A note on adopting it on an existing site

Switching the widget on does not touch already‑stored values, but the next time an
editor saves a piece of content, that field's value is validated. Numbers that
core previously accepted without checking may now fail validation, so expect some
legacy data to need cleaning up. If you need everything in a single canonical form,
storing in **E.164** and displaying in **national** or **international** is the
usual choice.

Bear in mind that libphonenumber's line‑type detection (mobile vs fixed line, etc.)
is best‑effort and country‑dependent — it is good enough for form validation, but
do not treat a "mobile only" restriction as a hard guarantee for billing or SMS
routing.
