# SpamSpan — manual setup guide

**SpamSpan** (`spamspan`) hides email addresses in your rendered pages so that
spambots trawling the web can't harvest them — while keeping the addresses perfectly
usable for real visitors. With JavaScript enabled, an obfuscated address is reassembled
in the browser into a normal clickable `mailto:` link. With JavaScript off, it
gracefully degrades to a readable form like `me [at] example.com`, so screen readers and
no-JS browsers still show a usable address.

It works as a **text-format filter**. You enable the SpamSpan filter on any text format
(Full HTML, Basic HTML, etc.), and from then on any bare email address or existing
`mailto:` link in content using that format is automatically obfuscated on output. Per
format you can tune the "@" replacement text, use a small graphic in place of "@",
optionally replace dots too, or route addresses to a site contact form instead of
exposing a `mailto:` at all.

Beyond the filter, SpamSpan provides an **Email field formatter** (to obfuscate values
of core Email fields on Manage display), a **Twig filter** (`|spamspan`) for use in
templates, and a **service** for obfuscating arbitrary strings in code. It depends only
on core's **Filter** module, defines no permissions of its own (it uses core's
*Administer filters*), and adds no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent — the `spamspan` service, the Twig filter,
and the interface/traits — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.
2. [Configuration](configuration/index.md) — enable the filter on a text format, tune
   its options, use the Email field formatter, and preview output on the test page.

## Where it lives in the admin menu

SpamSpan has **no settings page of its own** — you configure it inside each text
format. The relevant screens:

- **Text formats and editors** — **Configuration → Content authoring → Text formats and
  editors** (`/admin/config/content/formats`), where you enable and configure the
  SpamSpan filter per format.
- **Test / preview page** — `/admin/config/content/formats/spamspan`, where you can paste
  text and see how it will be obfuscated.
- **Email field formatter** — on a content type's **Manage display**, for core Email
  fields.
