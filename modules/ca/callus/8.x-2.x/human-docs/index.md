# Call Us — manual setup guide

**Call Us** (`callus`) adds a small floating "Call Us" button to your site,
showing a phone number and, if you want, links to your social‑media profiles. It
is a lightweight quick‑contact widget aimed at marketing or brochure sites where
you want a visitor to be one tap away from calling you.

Everything about the button is set from a single admin form: the phone number,
the button label, which side of the screen it floats on, and its background and
text colours. You can optionally add Facebook, Gmail, Twitter, LinkedIn, and
YouTube links, and any you leave blank simply don't appear. The button and links
are injected on the front end through the module's own CSS and JavaScript.

The module makes no external API calls — the social fields are just plain link
URLs — and it adds no callback or anonymous endpoints. The only required field is
the phone number.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field.

## Where it lives in the admin menu

The button's settings form sits at **Configuration → User interface → Call Us**
(`/admin/config/user-interface/call-us`, route `callus.form`). It is gated by the
**Administer site configuration** permission. Once you save a phone number, the
floating button appears on the front end site‑wide.
