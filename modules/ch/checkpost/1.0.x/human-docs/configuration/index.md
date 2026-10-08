# Configuration

Checkpost is configured entirely from one form. Until you fill it in and turn
enforcement on, the module lets every request through.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Checkpost**, or navigate directly to
   `/admin/config/development/checkpost`.

> **Set up your rules before enabling enforcement.** A good order is: add the ways
> *you* will still reach the site (your IPs and/or a bypass header), add any paths
> that must stay open, then switch enforcement on.

## The fields

**Enable / enforcement toggle** — the master switch. When off, Checkpost allows
all requests. When on, the middleware runs before routing and rejects any request
that doesn't match one of the allowlists below with a **403 Access Denied**.

**Ignore pages** — a list of page paths that are always allowed through, even to
visitors who match none of the other rules. Use this for things that must stay
publicly reachable, such as health-check endpoints or a status page. Enter one
path per line.

**Ignore source IPs** — a list of IP addresses and/or CIDR ranges whose requests
are always allowed. Add your office or VPN addresses here so your team can reach
the site. Both single IPs and CIDR ranges (for example a whole office subnet) are
supported; enter one per line.

**Headers** — one or more header name/value pairs that act as a bypass key. If an
incoming request carries **any one** of the configured header values, it is
allowed through. This is how you let automated systems in: set the header in your
CI configuration, in a webhook caller, or in a browser extension such as
[ModHeader](https://modheader.com/) while you work. Add as many header values as
you need. Treat the header value as a shared secret — anyone who knows it can
reach the site, so document it somewhere private for your CI and rotate it if it
leaks.

## Save

Click **Save configuration**. Once enforcement is on, open the site from a context
that matches one of your rules (your allowed IP, or a request carrying the bypass
header) to confirm you still get in, and check that a request from outside the
allowlist correctly receives a 403.

## Turning the gate off again

To temporarily reopen the site to everyone — for example right at launch — switch
the enforcement toggle off and save, or disable the module entirely. Either
restores unrestricted access.
