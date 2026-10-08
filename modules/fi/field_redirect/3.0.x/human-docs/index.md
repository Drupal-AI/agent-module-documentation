# Field Redirect — manual setup guide

**Field Redirect** (`field_redirect`) sends a visitor who lands on an entity's
canonical page straight to a URL stored in one of that entity's own fields. When
someone opens a node, user, or taxonomy term, the module reads the URI from a
chosen **link**, **file**, or **image** field and issues an HTTP redirect to it —
so a "link" content type can forward people directly to an external site or a
downloadable document instead of showing a details page. It can also return a
plain **403 Forbidden** or **404 Not Found** when you'd rather hide a page than
redirect it.

Everything is driven by one small settings form. You describe, one rule per line,
which entity types and bundles should redirect and which field supplies the
destination — optionally choosing the HTTP status code (301, 302, 303, or the
default 307). If the chosen field is empty on a given entity, you can fall back to
another field, to a 403/404, or to showing the page normally.

> **Note.** Field Redirect forwards visitors to whatever URL the field happens to
> contain. The module itself performs no access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the redirect rules form, its syntax,
   and the status codes, field by field.

## Where it lives in the admin menu

Once enabled, Field Redirect's settings form sits at **Configuration → Search and
metadata → Field Redirect** (`/admin/config/search/field-redirect`,
route `field_redirect.settings`). It needs no other setup — as soon as you add a
rule and save, matching entities begin redirecting.
