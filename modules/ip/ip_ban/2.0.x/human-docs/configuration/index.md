# Configuration

IP Ban is set up on its settings form in the admin **Configuration** area, plus a
set of permissions on the People → Permissions page. The heart of it is deciding
which IPs and countries to ban, and whether each ban is a complete block or a
read‑only restriction.

## Ban by IP address or by country

- **By IP address** — list the specific IP addresses to restrict.
- **By country** — choose whole countries; the visitor's country is resolved from
  their IP via the IP2Country module.

For each, you choose a level of restriction:

- **Complete ban** — the visitor is blocked entirely. You can:
  - **redirect** them to any page you choose (this can even be an external
    address), and/or
  - **display an error message**.
- **Read‑only** — the visitor can still read the site, but:
  - blocks you nominate are disabled (for example the user login block, which
    makes no sense to show a read‑only visitor), and
  - access to all `/user` pages is disallowed.

  If you also need to disable *forms* for read‑only visitors, the module's page
  recommends pairing it with the
  [Read only mode](https://www.drupal.org/project/readonlymode) module.

## Blocks to disable in read‑only mode

The form lets you specify which blocks to hide for read‑only visitors. It's also
worth disabling blocks on the page you redirect complete‑ban users to, so that
page stays clean.

## Permissions

IP Ban provides its own permissions on **People → Permissions**
(`/admin/people/permissions`). Grant the administration permission only to
trusted roles.

## Important limitations — this is a coarse gate, not a firewall

Keep the security model in mind as you configure bans:

- **IP addresses are easily changed.** A visitor on a VPN or proxy presents a
  different IP, so a ban is trivial to sidestep for anyone motivated.
- **Header spoofing.** Unless Drupal's trusted‑proxy settings are configured
  correctly in `settings.php`, a forwarded IP header can be spoofed. Configure
  trusted proxies if you rely on the client IP behind a proxy or CDN.
- **GeoIP is approximate.** Country lookups are best‑effort and sometimes wrong,
  so country bans will catch some legitimate visitors and miss some unwanted ones.
- **Not your only defense.** Use IP Ban to reduce noise and casual abuse — never
  as the sole protection for sensitive content or as a substitute for real access
  control.
- **Don't lock yourself out.** Double‑check you haven't banned your own IP or
  country before saving.

## Save

Save the form to apply your bans. Test from a matching IP/country (a VPN helps)
to confirm the behavior is what you intended.
