# CAPTCHA Protected Page — manual setup guide

**CAPTCHA Protected Page** (`captcha_protected_page`) puts a CAPTCHA challenge in
front of whole pages, not just forms. You list the paths you want to shield, and
when a visitor tries to reach one they are first redirected to a verification page;
only after passing the CAPTCHA are they allowed through. Once verified, a cookie
keeps them from being re-challenged until it expires. It is handy for protecting
download endpoints, sensitive listing pages, or long-running exports (such as Views
Data Export pages) from bots and scrapers.

By default the gate applies to anonymous users, and you can optionally require it
for specific authenticated roles as well. Protected paths can be exact matches or
`/prefix/*` wildcards. The module relies on the **CAPTCHA** module and uses its
default challenge settings, so whatever challenge type you have configured in CAPTCHA
is what visitors will see.

Please understand what this module is and is not. It is a **redirect layer**, not
access control — the underlying content permissions are unchanged, so it should be
treated as a bot-deterrent in front of otherwise-permitted pages rather than as a
way to protect genuinely private content. The public documentation also flags two
weaknesses in the current gate: the verification cookie's name is derived from an
unkeyed hash of the (known) path and its value is a fixed string, so a determined
client can forge the cookie and skip the challenge; and the gate is skipped for any
`POST` request. Because of these, do not rely on it as a security boundary — for
anything that must actually be restricted, use real access control (permissions, or
a signed/session-bound token) instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the CAPTCHA module.
2. [Configuration](configuration/index.md) — set the protected paths, cookie
   expiration, and any additional roles.

## Where it lives in the admin menu

The settings form is at **Configuration → System → CAPTCHA Protected Page**
(`/admin/config/system/captcha-protected-page`). Administering it is gated by the
**`administer captcha protected pages`** permission — grant it only to trusted
administrators.
