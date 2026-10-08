# Coming Soon Mode — manual setup guide

**Coming Soon Mode** (`comingsoon_mode`) gives you a quick way to put up a
"coming soon" landing page while a site is still being built. When the mode is
active, anonymous visitors (and anyone without the bypass permission) are
redirected to a customizable landing page — complete with a countdown timer,
your logo, a message, background colour or image, and social/contact links —
while login, password reset, and static assets stay reachable so you and your
team can keep working. It's aimed at the pre‑launch phase: put up a friendly
placeholder, let privileged users through to the real site, and flip it off on
launch day.

The landing page is highly customizable from a single settings form, supports
right‑to‑left layouts and translation, and is responsive. Developers can fully
override its look by adding a `comingsoon.html.twig` template to their theme. The
module provides its own permission, `access website in comingsoon mode`, which
decides who bypasses the gate.

**Important — this is a soft gate, not a security boundary.** Coming Soon Mode
works by *redirecting* page requests, and it deliberately lets static files and
the authentication routes through. That's perfect for hiding an unfinished site
from casual visitors, but you should **not** rely on it to protect genuinely
sensitive content. For that, use real access control or an access‑restricted
(for example password‑protected or staging) environment. Note also that this
release is marked *not covered* by Drupal's security advisory policy, which is
another reason to treat it as a convenience rather than a security tool. It works
on Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — activate the mode, design the
   landing page, and choose who may bypass it.

## Where it lives in the admin menu

Once enabled, configure everything at **Configuration → System → Coming Soon
Mode** (`/admin/config/system/comingsoon_mode`). Nothing changes on your site
until you turn the mode on there — see [Configuration](configuration/index.md).
