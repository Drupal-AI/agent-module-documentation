# Configuration

Domain Availability has a settings form where you set up the lookup providers and
the safeguards that keep the outbound lookups sensible. Configure it before
opening the search or API to users.

## Open the settings form

1. Log in as a user with the **administer domain availability** permission.
2. Go to **Configuration → System → Domain availability**.

## What you configure

The main settings form covers:

- **TLDs to sweep.** The set of top-level domains checked on every search.
  Twenty ship enabled, starting with `sa`, `com`, `net`, `org`, `io`.
- **Providers.** Which lookup backends are active. The module resolves domains via
  RDAP first and falls back to WHOIS, discovering the correct servers from the
  IANA bootstrap. An authoritative HTTP API provider is available but off by
  default. Providers are pluggable (via the `domain_availability_provider` service
  tag), so a developer's custom backend appears here for selection.
- **Cache TTL.** How long results (and the discovered RDAP/WHOIS server list) are
  cached. A longer TTL reduces outbound traffic and speeds up repeat lookups; a
  shorter TTL keeps results fresher.
- **Timeouts and the lookup budget.** Per-query and overall wall-clock ceilings
  for RDAP, WHOIS and DNS, so a single slow registry cannot hold a request open.
- **Rate limits.** The per-client-IP request limit that throttles how often a
  single visitor can trigger lookups. This protects the outbound service from
  abuse — keep it in place, and tune it to your expected legitimate usage.
- **CORS allowed origins.** If you call the JSON API from a browser on another
  origin, list the origins allowed to read the responses. Leave it empty to send
  no CORS headers at all.

Set these values and click **Save configuration**.

## Pricing

A separate **Pricing** section lets you attach a price to available results. Two
modes ship, one active at a time: a single **fixed price for all domains**, or a
**different price per extension** (a table generated from your enabled TLD list).
An extension left blank is simply shown without a price. Prices are applied after
the lookup cache, so a change takes effect on the next search.

## Registration settings

If you use the optional Saudi domain **registration-request** workflow, its own
form (**→ Registration settings**) controls whether the feature is on, which TLDs
accept requests (`sa` by default), the certificate upload size and extensions, the
administrator notification addresses, and the duplicate-request window.

## Which TLDs are swept

The strength of the module is checking a name across many top-level domains in one
parallel request. Configure the set of TLDs on the form so a single search returns
availability for all of them at once.

## After saving

Test a lookup from the search UI at `/domain-search` or the JSON API at
`/domain-check`. Remember that any name no authority can answer is reported as
**unknown** by design — that is correct behavior, not a misconfiguration.
