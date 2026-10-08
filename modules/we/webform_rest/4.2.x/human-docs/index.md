# Webform REST — manual setup guide

**Webform REST** (`webform_rest`) exposes Drupal's Webform module over the REST API,
so an external or decoupled client can fetch a webform's fields and submit (or read
and update) submissions as JSON. It is the bridge you reach for when a React/Vue
app, a mobile app, a static front end, or another system needs to render a Drupal
webform remotely and post answers back.

The module registers five REST resource plugins: read a webform's **elements** (as a
render array) or its **fields** (a flattened list with default values resolved),
**submit** a new submission, **read/update a submission** by its UUID, and fetch a
**complete submission** (its data plus fields) in one call. A POST to the submit
resource runs the *same* validation, handlers, emails, and hooks as a browser
submission and returns the new submission's UUID (`sid`).

Like every core REST resource, none of these are active on install — you turn each
one on by creating a REST resource configuration that declares the allowed HTTP
methods, serialization formats, and authentication providers. The easiest way is the
optional **REST UI** module; you can also do it with config or code. The module adds
a small settings form of its own with one option (whether the submit response
includes the webform's confirmation message) and a `webform_rest.submit.return` event
that lets other modules rewrite the response.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the exact endpoints, payloads,
and the submit event — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (with Webform and core
   REST) and enable it.
2. [Configuration](configuration/index.md) — turning on the individual REST
   resources, the required permissions, and the settings form.

## How to use it

Once a resource is enabled, its endpoints live under `/webform_rest/…` and honour the
requested format via `?_format=json`. For example, a decoupled front end can fetch a
webform's fields with `GET /webform_rest/contact/fields?_format=json` and post a
submission with `POST /webform_rest/submit` (a JSON body containing `webform_id` plus
the field values). See [Configuration](configuration/index.md) for how to switch each
resource on, and the [`agent/`](../agent/start.md) docs for the full request/response
shapes.
