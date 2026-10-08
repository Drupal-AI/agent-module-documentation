# REST Invalidate Cache — manual setup guide

**REST Invalidate Cache** (`rest_invalidate_cache`) adds a small REST endpoint that
invalidates specific cache tags on demand. It is meant for integrations: a CI or
deploy pipeline, a CMS sync job, or any external service can tell Drupal to clear
the caches for a given set of tags over REST, without forcing a full cache rebuild.
You call it with a POST request that names the tags to invalidate:

```
POST /invalidate_cache/[comma-separated cache tags]
```

The endpoint is a core REST resource, so it is **not anonymous by default** — a
caller must hold the granted REST permission and authenticate with the method you
configure. That said, cache invalidation is a **privileged and abusable action**:
repeatedly invalidating tags forces Drupal to do expensive rebuilds, which is a
performance and denial-of-service lever. Treat the permission accordingly — grant it
only to trusted machine accounts, require real authentication on the resource, and
consider rate-limiting the caller upstream. The module has no access-control role of
its own beyond that single permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   then turn on the REST resource, add authentication, and grant the permission
   narrowly.

There is **no dedicated settings form** for this module. The setup you do — enabling
the resource, choosing an authentication method, and granting the permission — all
happens through core's REST configuration (most easily via the REST UI module) and
the permissions page, and is covered in the installation guide.

## Where it lives in the admin menu

REST Invalidate Cache adds no admin page of its own. You enable and configure its
REST resource at **Configuration → Web services → REST**
(`/admin/config/services/rest`, provided by the REST UI module), and you grant the
calling permission at **People → Permissions**.
