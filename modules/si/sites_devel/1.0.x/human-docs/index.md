# Sites devel — manual setup guide

**Sites devel** (`sites_devel`) is a development companion for the **Sites**
multi‑site ecosystem. It shows you, on every page, exactly which site the current
request resolved to and why — and it unlocks Devel's dumper output for developers
whenever Sites is in "development mode," without needing the usual Devel
permission.

The problem it solves is debugging site negotiation. In a Sites multi‑site, a
given hostname resolves to a particular site through a chain of candidate plugins,
and when that goes wrong it can be hard to see what happened. Sites devel adds a
**"Sites devel debug" block** that dumps the site candidates considered for the
request, the active site that was chosen, the matched route, the negotiated
language, and — when the relevant submodules are installed — per‑site path‑alias
information (`sites_path_alias`) and redirect information (`sites_redirect`). It also
decorates Devel's dumper service so `dump()` output renders for developers while
development mode is on.

There is nothing to configure: **enabling the module is the whole setup**. Once on,
the debug block renders automatically on every page. It depends on **Sites**,
**Devel** and **Block plugin view builder**, and targets Drupal 11+.

**This is strictly a development tool — do not enable it on production.** Access to
the debug features is granted either to users holding the *Use sites development*
permission (`use sites_devel`, marked *restrict access*), or to **everyone** while
the container parameter `sites.development` is `TRUE`. Because that parameter opens
the debug block and the Devel dumper to all visitors — including anonymous ones —
turning it on in production would leak internal request details. Keep the module,
and development mode, to local and development environments only, and remove or
disable it before you deploy.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module in a development environment.

## How to use it

There is no admin form. After enabling the module in a development environment:

1. The **"Sites devel debug"** block renders automatically on every page, showing
   the site candidates, the active site, the route, and the negotiated language.
2. Install `sites_path_alias` and/or `sites_redirect` to see per‑site path‑alias and
   redirect details in the block too.
3. Turn on Sites **development mode** (the `sites.development` container parameter)
   to let Devel's dumper output render without the standard Devel permission — but
   remember this exposes the debug output to all visitors, so only do it in a
   development environment.
4. Grant the **Use sites development** permission (`use sites_devel`) to a developer
   role if you prefer permission‑scoped access instead of opening development mode.
5. **Disable or remove the module before deploying to production.**
