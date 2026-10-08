<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Query Auth Params

## Add a protected page
At `/admin/config/development/query_auth_params` (permission `administer site configuration`) add a rule with:
- **Url to apply** — a relative path starting with `/` (validated with the path validator; system path or alias both work).
- **Query param name** / **value** — each ≤10 chars, alphanumeric only (`ctype_alnum`).
- **Display options** — `forever`, `once`, or `datetime_period` (with a datetime).
- **Redirect URL** — optional; defaults to `/`.

## Runtime behavior (`QueryAuthParamsSubscriber`)
- Runs on `KernelEvents::CONTROLLER`; resolves current path and alias against each rule's `restrict_url` and its resolved system path.
- On match: triggers the page-cache kill switch, then checks `$params[name] === value`.
- `once`: after the first successful view, sets `shown = 1` in config; later visits always redirect.
- `datetime_period`: once `time() > datetime_period`, the page is no longer gated.

## Access examples
- Allowed: `/mathematics?access=secret123`
- Redirected: `/mathematics` (missing/incorrect param)

## Caution
The gate only redirects; it does not change route/entity access. The secret is visible in the URL — avoid for confidential content.
