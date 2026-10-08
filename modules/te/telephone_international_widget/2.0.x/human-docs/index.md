# Telephone International Widget — manual setup guide

**Telephone International Widget** (`telephone_international_widget`) adds a much
friendlier input to Drupal core's telephone field: instead of a bare text box, the
editor gets a country selector with flags, as‑you‑type formatting, and validation
against the selected country's rules. It is a **field widget** for the existing
core telephone field — it does not add a new field type — built on the popular
`intl-tel-input` JavaScript library, which uses a custom build of Google's
libphonenumber for validation. The module suggests storing numbers in E.164 form.

The problem it solves is inconsistent phone entry. Core's telephone field accepts
almost anything, so users type `07700 900123` when the site really needs
`+44 7700 900123`, double up the country code, or add a national prefix that means
nothing to someone dialling from abroad. That inconsistency does not hurt at entry
— it surfaces later at an SMS gateway, a click‑to‑call link, or a CRM export. The
widget guides users to enter a well‑formed international number in the first place.

There is **no central settings page**; you use the module by setting it as the
form widget on a telephone field (see [Installation](installation/index.md) for how
it surfaces). It depends on core's **Telephone** module. This is a **release
candidate** (2.0.0‑rc2) and currently assumes the library's default settings plus
client‑side validation.

Two important caveats, both from the module's own guidance. First, **client‑side
validation is a usability feature, not a security control** — it is trivially
bypassed, so anything that relies on a number's shape (a downstream integration,
say) must revalidate on the server. Second, the widget **adds a country list and
JavaScript to every form that contains the field**, so be deliberate about using
it on a public registration form, and check whether geolocation‑based country
guessing is enabled, since that generally involves a third‑party lookup.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   `intl-tel-input` JavaScript library) and enable the module, then set the widget
   on a field.

## How to use it

On the entity that has your telephone field, open **Manage form display**, find the
field, and set its **Widget** to the Telephone International Widget. The country
selector and validation then appear wherever that form is used. Everything is
configured per field — there is no site‑wide settings page. It pairs well with
`telephone_validation` for server‑side validation and `telephone_formatter` for
display.
