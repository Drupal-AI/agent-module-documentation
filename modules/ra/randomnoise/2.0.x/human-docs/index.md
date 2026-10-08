# Random Noise — manual setup guide

**Random Noise** (`randomnoise`) is a privacy / anti-surveillance gesture. When
enabled, it attaches a small third-party JavaScript file to every page you serve.
That script causes each visitor's browser to make one extra request to a random
IP address for every page load — adding "noise" to the traffic logs kept by ISPs
and data brokers, so the aggregated browsing profile they can sell becomes less
reliable and therefore less valuable.

There is nothing to configure. The whole module is a single hook that adds the
`randomnoise` library on every page, for every visitor — anonymous and
authenticated alike. Enable it and it starts working; uninstall it and the effect
stops instantly.

> **Know what you're enabling.** The library loads an external, minified script
> from `https://randomnoise.us/js/squawk.js`. That means every page unconditionally
> pulls in a remote third-party script with no Subresource Integrity, and the
> behavior depends on that external domain staying available and trustworthy — a
> supply-chain and privacy consideration. Review `squawk.js` and weigh the
> third-party dependency before enabling it on a sensitive site. It also makes
> every visitor emit outbound requests to arbitrary IPs, which you should be
> comfortable disclosing to your users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page**, no settings, and no permissions — enabling
the module is the entire operation.

## How to use it

Simply enable the module (see [Installation](installation/index.md)). From that
moment, the noise script is attached to every page automatically. To stop it,
uninstall the module — the behavior is removed immediately.
