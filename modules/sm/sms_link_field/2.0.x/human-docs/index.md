# SMS Link Field — manual setup guide

**SMS Link Field** (`sms_link_field`) adds a link field type that understands
`sms:` URIs, together with a matching formatter that renders them as tappable
"click‑to‑text" links. It lets editors store links such as `sms:+15551234567`
(or `sms:+15551234567?body=Hello`) as a proper field value, which is especially
useful on mobile‑facing sites where a visitor can tap the link to open their
messaging app with the number — and optionally a pre‑filled message — ready to
go.

The field is built on core's **Link** field, so it inherits all the same
configuration options you already know; the difference is that it accepts `sms:`
URIs and provides a **Link with SMS support** formatter that renders them
correctly. It depends only on core's **Link** module and supports Drupal 11.
There is no site‑wide settings page — everything is done through Drupal's normal
field management screens.

This guide is written for a **human** adding and using the field through the
admin UI. If you want terse, token‑cheap references for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Go to **Structure → Content types →** *(your type)* **→ Manage fields → Add
   field** and choose the **Link (with SMS support)** field type.
2. When entering data, use `sms:` URIs such as `sms:+1234567890` or
   `sms:+1234567890?body=Hello`.
3. Under **Manage display**, choose the **Link with SMS support** formatter so
   the value renders as a proper tappable SMS link.

Because it extends the core Link field, all the usual link settings (cardinality,
link text, and so on) are available on the field's own configuration forms.
