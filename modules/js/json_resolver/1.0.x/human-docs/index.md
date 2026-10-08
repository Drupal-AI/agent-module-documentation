# JSON Resolver — manual setup guide

**JSON Resolver** (`json_resolver`) is a developer utility for turning collected
data — most often a webform submission — into a JSON payload with a predefined
shape. You define JSON **templates** with placeholders like `{{amount}}` and a
**token map** that says which submission field each placeholder pulls from. At
runtime, the module's service swaps the placeholders for real values, giving you a
ready‑to‑send JSON structure. It's JSON‑structure agnostic: the templates can be
any shape you like.

The typical use case is building an API payload from a webform: capture the data,
then hand it to JSON Resolver to produce exactly the JSON an external service
expects. It's equally handy for transforming data for third‑party integrations,
generating configurable dynamic JSON responses, or mapping form data to another
service's requirements.

Templates and the token map are managed through an admin UI, and the resolving
itself is done in code by calling the module's service. Nested data is supported via
dot notation in the token map (for example `payment.credit_card.number`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the token map, template management,
   and permission.

## Where it lives in the admin menu

Once enabled, the admin UI sits at **Configuration → System → JSON Resolver
Settings** (`/admin/config/system/json-resolver`). Reaching it requires the
**Administer JSON Resolver** permission.

## How developers use it

In code, inject the `json_resolver.resolver` service (which implements
`JsonResolverInterface`) and call `resolve($template_name, $submission_data)`. The
method returns your template with every `{{token}}` replaced by the matching value
from the submission data, according to the token map you configured.
