# Configuration

Domain Availability has a settings form where you set up the lookup providers and
the safeguards that keep the outbound lookups sensible. Configure it before
opening the search or API to users.

## Open the settings form

1. Log in as a user with the **administer domain availability** permission.
2. Go to **Configuration → System → Domain availability**.

## What you configure

The exact fields depend on the release, but the form covers three areas described
in the module's own documentation:

- **Providers.** Choose and order the availability providers used for lookups.
  The module resolves domains via RDAP first and falls back to WHOIS, discovering
  the correct servers from the IANA bootstrap. Providers are pluggable (via the
  `domain_availability_provider` service tag), so if a developer has added a
  custom backend it appears here for selection.
- **Cache TTL.** How long results (and the discovered RDAP/WHOIS server list) are
  cached. A longer TTL reduces outbound traffic and speeds up repeat lookups; a
  shorter TTL keeps results fresher. Server-discovery data from the IANA
  bootstrap is cached as well.
- **Rate limits.** The per-client-IP request limit that throttles how often a
  single visitor can trigger lookups. This protects the outbound service from
  abuse — keep it in place, and tune it to your expected legitimate usage.

Set these values and click **Save configuration**.

## Which TLDs are swept

The strength of the module is checking a name across many top-level domains in one
parallel request. Configure the set of TLDs to sweep as offered on the form so a
single search returns availability for all of them at once.

## After saving

Test a lookup from the search UI at `/domain-search` or the JSON API at
`/domain-check`. Remember that any name no authority can answer is reported as
**unknown** by design — that is correct behavior, not a misconfiguration.
