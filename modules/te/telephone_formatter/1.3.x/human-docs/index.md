# Telephone Formatter — manual setup guide

**Telephone Formatter** (`telephone_formatter`) makes the phone numbers stored
in Drupal's core **Telephone** fields display cleanly, and optionally turns them
into click-to-call links. Instead of printing the raw string an editor typed,
it parses the number with Google's **libphonenumber** library and re-emits it in
a proper, consistent format — so `+12025550136` can show as `+1 202-555-0136`
and, on a phone, be tappable to dial.

The module adds a single **field formatter** called **Formatted telephone**,
which you pick on an entity's **Manage display** screen. There is no separate
admin settings page — everything is configured right where you choose the field
formatter. You decide which of four libphonenumber output formats to use
(International, E164, National, or RFC3966), whether to wrap the number in a
`tel:` link, and an optional default country used to parse local numbers that
were entered without a `+` country code.

It is deliberately forgiving: if a stored value cannot be parsed or is invalid,
the formatter simply prints the raw value unchanged rather than throwing an
error. For developers, the formatting logic also lives in a reusable service
(`telephone_formatter.formatter`) whose `format($input, $format, $region)`
method you can call from custom code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   libphonenumber library) and enable the module.

## Where it lives in the admin menu

Telephone Formatter adds no admin page of its own (`configure` is null). You use
it on the display settings of any entity that has a Telephone field:
**Structure → (your entity type) → Manage display**, for example
**Structure → Content types → Article → Manage display**.

## How to use it

1. Add a core **Telephone** field to a content type (or other fieldable entity)
   if you don't already have one.
2. Go to that entity's **Manage display** screen — e.g.
   **Structure → Content types → Article → Manage display**.
3. Find your telephone field and set its **Format** to **Formatted telephone**.
4. Click the gear/settings icon next to it and choose:
   - **Format** — the libphonenumber output style:
     - **International** *(default)* — e.g. `+1 202-555-0136`.
     - **E164** — strict machine-readable form, e.g. `+12025550136`.
     - **National** — domestic style, e.g. `(202) 555-0136`.
     - **RFC3966** — e.g. `tel:+1-202-555-0136`.
   - **Link** *(on by default)* — wraps the formatted number in a `tel:` link
     (the link's href uses the RFC3966 form) so it is click-to-call on mobile.
     Untick it to output the number as plain text.
   - **Default country** — an ISO country code used to parse national/local
     numbers when your field allows input without the `+` country code. Leave
     empty if your numbers are already in full international (E.164) form.
5. Click **Update**, then **Save**.

You can set different formats per view mode — for instance International on the
full node display and National on the teaser — and export those display
settings as configuration between environments. Because the settings live in the
entity's display config, they behave like any other Manage display setting.

> **Tip:** the module pairs well with
> [`telephone_validation`](https://www.drupal.org/project/telephone_validation),
> which helps ensure only parseable numbers ever reach the formatter.

### For developers: the formatter service

The same logic is available as a service you can call directly:

```php
$formatter = \Drupal::service('telephone_formatter.formatter');
// format($input, $format, $region = NULL) — $format is a libphonenumber
// PhoneNumberFormat constant (0 = E164, 1 = International, 2 = National, 3 = RFC3966)
$intl = $formatter->format('+12025550136', \libphonenumber\PhoneNumberFormat::INTERNATIONAL);
// "+1 202-555-0136"
```

Note that the service throws `\InvalidArgumentException` for an invalid number,
so wrap calls in a try/catch (the field formatter does this for you and falls
back to the raw value).
