# Persistent Login — manual setup guide

**Persistent Login** (`persistent_login`) adds a familiar **"Remember me"** checkbox to
the Drupal login form and keeps those users signed in with its own long-lived cookie —
independently of the PHP session lifetime. This lets you keep editors or members logged in
for weeks without having to lengthen the session cookie for *everyone*, which is exactly
the kind of thing a security review tends to object to.

The cookie it issues is deliberately careful. It uses the classic *series + single-use
token* scheme, and both parts are stored **hashed** in the module's own database table.
Each time the cookie is used its single-use part is rotated, so if a stolen cookie is
replayed the whole series is invalidated — a built-in defence against cookie theft.
Persistent Login registers itself as an authentication provider ranked above core's normal
cookie auth, so a returning visitor whose PHP session has expired is logged straight back
in from the remembered-login cookie.

It works the moment you enable it, but there is one **required site setting**: your
`services.yml` must set the PHP session cookie's lifetime to `0` (a browser-session
cookie), or the module reports an error on the status page. Beyond that, a settings form
lets you tune the lifetime, how many devices each user can remember, the checkbox wording
and the cookie name. Users can review their own remembered logins, and can log out all
other devices by changing their password. The module needs Drupal core `^11.2 || ^12` and
has no permission of its own.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it,
   and set the required session-cookie option.
2. [Configuration](configuration/index.md) — the settings form, field by field.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → Persistent Login**
(`/admin/config/system/persistent_login`), gated by the core *Administer site
configuration* permission. Each user can see their own active remembered logins at
`/user/<uid>/persistent-logins`.
