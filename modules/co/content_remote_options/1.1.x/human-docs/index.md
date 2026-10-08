# Content Remote Options — manual setup guide

**Content Remote Options** (`content_remote_options`) provides a new field type,
**List (remote options)**, whose selectable options are fetched from a remote
endpoint over HTTP/REST instead of being a hard-coded allowed-values list. When a
field's choices really live in an external service — a product catalogue, a
taxonomy service, another site — this keeps the option list in sync automatically,
so nobody has to re-enter the values by hand.

You configure everything through the standard Field UI when you add the field to a
content type (or any content entity bundle): the endpoint URL, any headers to
send, and which keys in the JSON response supply the option value and label. The
field then renders as a normal select element, populated from the fetched data.
Responses are cached per entity, bundle, field, and language so the module isn't
hitting the endpoint on every request.

A note on how the endpoint is treated: the URL is **field configuration** set by a
site builder with field-admin rights — it is not supplied by end users at request
time — so this is not an open request-driven proxy. The server-side fetch uses
Guzzle with its normal defaults (TLS verification stays on). The module has no
dependencies beyond Drupal core and supports Drupal 8, 9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings page** — the field is configured entirely through
the Field UI on each field you add, described in "How to use it" below.

## Where it lives in the admin menu

Content Remote Options adds no admin settings page. You use it from **Structure →
Content types → *(your type)* → Manage fields** (or the Manage fields screen of
any content entity bundle), where **List (remote options)** appears as a field
type.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage fields** screen of the content type or bundle you want, and
   add a new field.
3. Choose the **List (remote options)** field type and continue.
4. In the field settings, configure:
   - **Endpoint** — the URL to fetch data from. A relative path starting with `/`
     is resolved against the current site's host.
   - **Headers** — optional additional request headers (for example an
     authorization header).
   - **Response data key** — a specific key within the response to read the items
     from, if the items are nested.
   - **Response items key** — the response property used as each option's **key**
     (the stored value).
   - **Response items value** — the response property used as each option's
     **label** (what editors see).
   - **Use empty option** — whether to show an empty option in the select.
   - **Empty option label** — override the default empty-option label
     (e.g. "- Select -" / "- None -").
5. Save the field. On content forms, the field now renders as a select populated
   from the endpoint, with results cached per entity/bundle/field/language.
