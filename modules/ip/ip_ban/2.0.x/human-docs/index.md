# IP Ban — manual setup guide

**IP Ban** (`ip_ban`) lets you restrict who can reach your site based on their **IP
address or their country**. A lot of sites serve content that's only relevant to
one country or region, and traffic from elsewhere is often noise (or worse). IP
Ban gives you two levers for that: a **complete ban** (block the visitor entirely,
optionally redirecting them to a page of your choice and/or showing an error
message) and a **read‑only** mode (let them read but disable blocks like the login
form and lock them out of the `/user` pages).

Country matching is done by looking the IP up through the **IP2Country** module,
so you can block, say, an entire country without listing individual addresses.
IP‑address rules let you target specific addresses directly. For read‑only mode you
can also name which blocks to hide (there's little point showing a login block to
someone who can't act on it).

Please read this before you rely on it: **IP/country banning is a coarse,
best‑effort filter, not a strong security boundary.** A visitor can change their
apparent IP with a VPN or proxy (and spoof headers unless you've configured trusted
proxies), and GeoIP country data is only approximate — so a determined person can
get around it. Use it to cut down noise and casual abuse, never as your only access
control for sensitive content. And take care not to **lock yourself out** by
banning your own IP or country.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its IP2Country
   dependency with Composer, then enable it.
2. [Configuration](configuration/index.md) — defining IP and country bans,
   redirects, and read‑only mode.

## Where it lives in the admin menu

IP Ban adds a settings form under the admin **Configuration** area where you set
up the IP and country rules. It also provides its own permissions. See
[Configuration](configuration/index.md).
