# Permissions Policy — manual setup guide

**Permissions Policy** (`permissionspolicy`) sends a `Permissions-Policy` HTTP
response header that tells browsers which powerful features your site — and any
iframes embedded in it — are allowed to use. Camera, microphone, geolocation,
fullscreen, autoplay, USB, payment, and dozens more browser capabilities can each be
allowed for your own origin only, blocked entirely, allowed for everyone, or opened
up to specific trusted origins.

This is a security-hardening header. A common use is to switch off features you never
need (so an injected script or a rogue ad iframe cannot quietly ask the browser for
the camera or the user's location), or to opt out of advertising APIs like
`interest-cohort` and `browsing-topics`. You configure it entirely from one admin
form, and the module builds the correctly formatted header for you using the
`gapple/structured-fields` library.

Importantly, the module **ships enabled but with no features configured**, which
means it sends *no header at all* until you add at least one feature. So installing it
is safe and invisible; the header only appears once you decide what to lock down. It
is a purely site-wide security header — there are no per-content settings, no
permissions gates on individual features, no Drush commands, and no field or entity
integration. Other modules can adjust the policy programmatically through an alter
event if needed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the required
   library) and enable the module.
2. [Configuration](configuration/index.md) — the admin form, per-feature Base and
   Sources options, and the resulting header.

## Where it lives in the admin menu

The single settings form is at **Configuration → System → Permissions Policy**
(`/admin/config/system/permissionspolicy`), guarded by the **Administer permissions
policy configuration** permission.
