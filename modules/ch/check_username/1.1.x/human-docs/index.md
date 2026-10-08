# Check Username — manual setup guide

**Check Username** (`check_username`) gives visitors instant feedback on whether a
chosen username is already taken. As someone types a name into the registration
form (or a user create/edit form), the module makes a background AJAX check and
tells them right away whether the name is available — no need to submit the form and
wait for a validation error. A configurable debounce delay controls how long it
waits after typing stops before firing the check.

It works by attaching a small JavaScript behaviour to the relevant user forms and
exposing an AJAX endpoint that looks up the username. There's a single settings form
where you set the debounce delay. The module has no other dependencies.

One important caveat to weigh before deploying this on a public site: the
availability endpoint is reachable by anonymous visitors and reports whether a
specific username exists ("The name X is already taken"), with no rate limiting.
That makes it possible for an anonymous caller to **enumerate valid usernames** in
bulk — a low‑severity information‑disclosure concern. (This module is also not
covered by Drupal's security advisory policy.) If username privacy matters for your
site, consider restricting the endpoint to authenticated users, adding flood/rate
limiting, or returning a non‑revealing response for anonymous callers before relying
on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the debounce delay.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Check Username**
(`/admin/config/system/check-username`, route `check_username.config_form`),
reachable by users with the **Administer check_username configuration** permission.
The check itself is served from `/check-username`.
