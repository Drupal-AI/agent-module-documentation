# Assist For WCAG — manual setup guide

**Assist For WCAG** (`assist_for_wcag`) adds a third‑party **accessibility
widget** to your site by injecting an external script. The widget is the kind of
overlay/toolbar that offers visitors assistive controls — adjusting font size,
contrast, and similar — to help your site meet WCAG accessibility expectations.
The script is loaded from the provider and authenticated with a **token** tied to
your account with that service.

In practice, you sign up with the accessibility‑widget provider, get a token, and
configure it here; the module then embeds the provider's script on your pages so
the widget appears for visitors. It supports Drupal 10, 11, and 12.

Two honest caveats to weigh before relying on it. First, the token/account is a
credential — store it securely rather than committing it into configuration (see
[Configuration](configuration/index.md)). Second, this embeds a **third‑party
overlay**: such overlays load external code onto your pages and have their own
privacy and effectiveness considerations, and accessibility experts generally
agree that an overlay is not a substitute for building an accessible site. Treat
it as an add‑on, not a replacement for real accessibility work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your provider token and switch
   the widget on.

## Where it lives in the admin menu

The module's settings — where you enter the widget token — are available to users
with the permission it provides. Grant that permission (**People → Permissions**)
only to trusted administrators, since it controls a script embedded on every page.
See [Configuration](configuration/index.md).
