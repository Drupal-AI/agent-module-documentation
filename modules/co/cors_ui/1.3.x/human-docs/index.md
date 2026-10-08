# CORS UI — manual setup guide

**CORS UI** (`cors_ui`) gives Drupal core's CORS (Cross-Origin Resource Sharing) settings an
admin form. Core ships a CORS middleware, but out of the box it is only configurable by
hand-editing the `cors.config` parameter in `sites/default/services.yml` — which means shell and
file access, a cache rebuild, and no validation. CORS UI turns those same settings into editable
Drupal configuration at **Configuration → Web services → CORS**, and rebuilds the container for
you so changes take effect immediately. This is what you want for a decoupled / headless front
end (React, Vue, Next.js) consuming your site's JSON:API or REST, or for third-party widgets that
call your API.

The form edits the standard CORS options — whether CORS is enabled, the allowed origins, methods,
and request headers, the response headers exposed to cross-origin JavaScript, whether credentials
(cookies/auth) are supported, and the preflight cache lifetime (`maxAge`). Values are stored in
the `cors_ui.configuration` config object, and a service provider feeds them back into the
container's `cors.config` parameter so they override `services.yml`. On install the module seeds
its config from the site's *current* `cors.config`, so enabling it does not change existing
behaviour, and it does **not** ship a permissive default.

Because CORS is a container-level parameter, any change triggers an automatic container rebuild
(and clears the response cache). The single permission, *administer cors*, is marked
*restrict access*, so only trusted administrators can touch it. The module works on Drupal 9, 10,
and 11, has no dependencies, and provides no Drush commands.

> **Security matters here.** CORS controls which other websites' JavaScript may read responses
> from your site. A too-permissive policy — especially a `*` wildcard origin combined with
> **Supports credentials** — can expose authenticated data to any origin. Set the narrowest
> policy that works: list the specific front-end origins you trust rather than allowing all, and
> only enable credentials when you genuinely need cross-origin cookies/auth. See the
> [Configuration](configuration/index.md) page for the validation rules and the security note.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and grant the
   permission.
2. [Configuration](configuration/index.md) — every field, the origin validation rules, how it
   overrides `services.yml`, and the security implications of a wrong CORS policy.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → CORS**
(`/admin/config/services/cors`), gated by the *administer cors* permission.
