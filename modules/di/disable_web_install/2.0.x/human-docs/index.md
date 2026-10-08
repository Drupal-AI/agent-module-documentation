# Disable Web Install — manual setup guide

**Disable Web Install** (`disable_web_install`) is a security-hardening module that
removes the ability to **install modules and themes through the web UI**. Drupal core
lets a user with the right permission add a new module or theme straight from the
browser — by uploading an archive or pointing at a URL — and this module takes that
flow away, so extensions can only be added through the filesystem (in practice, via
Composer). It leaves the rest of the Update Manager alone: you still get update
*notifications*, you just can't *install* from the browser.

The reason to want this on a production site is that the web install flow is a
powerful capability and a genuine attack surface. Adding a module or theme means
adding executable code to the site, so an account that can install from the browser
is an account that can run arbitrary code — a serious foothold if that account is ever
compromised. Turning the flow off enforces that all code changes go through your
controlled deployment pipeline instead.

This is **security-positive** hardening you can enable and largely forget. It works
the moment you turn it on — there is nothing to configure. It complements, but does
not replace, restricting the relevant install permissions to as few accounts as
possible; do both. It depends on core's System and Update modules and runs on Drupal
10 and 11.

Note the project is **not covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form. Once
enabled, the browser-based install flow is disabled automatically.

## How to use it

Enable it on production (see [Installation](installation/index.md)) and you're done.
From then on, the "Install new module" and "Install new theme" browser flows are
unavailable — add modules and themes with `composer require` and deploy them through
your normal pipeline. Update notifications from the Update Manager continue to work as
before. For defence in depth, also make sure only trusted administrators hold the
permissions that control installing and administering modules and themes.
