# Amplitude — manual setup guide

**Amplitude** (`amplitude`) loads the **Amplitude analytics SDK** on your site
and lets you define client-side tracking events from the admin UI — no
JavaScript required. Amplitude is a product-analytics service; this module is the
Drupal glue that puts its tracking script on your pages and fires the events you
configure.

You enter your Amplitude project **API key** on a settings form, and then you
build **events**: each event has a trigger (fire on page load, or on a click of a
CSS selector), a set of paths it applies to, and optional properties to capture.
The module evaluates each event's path rules on every request and passes the
matching ones to the Amplitude SDK in the browser. It integrates with the
**Token** module, so you can build user and event properties from the current
page's entity — for example segmenting events by content type.

One useful point about the API key: the value you enter here is Amplitude's
**public, client-side project key**. It is designed to ship to the browser, so it
is not a secret in the way a server API key would be. Access to the settings form
itself is gated by the `administer amplitude settings` permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set your API key and build tracking
   events.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → Amplitude**
(`/admin/config/system/amplitude`), behind the **Administer Amplitude settings**
permission. Events are managed from a list linked off that form.
