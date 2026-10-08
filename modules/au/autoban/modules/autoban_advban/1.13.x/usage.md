<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Autoban Advanced Ban Provider is the Autoban submodule that plugs the contrib **Advanced Ban (advban)** module into Autoban, adding two ban providers: `advban` ("Advanced Ban", single IP) and `advban_range` ("Advanced Ban (range)", CIDR/IP-range banning).

---

This glue submodule registers two services tagged `ban_providers`, both implementing
`Drupal\autoban\AutobanProviderInterface` and constructed with `@advban.ip_manager`:
`autoban_advban.ban_provider` (`Drupal\autoban_advban\AdvbanProvider`) exposes id `advban`
("Advanced Ban", ban type `single`), and `autoban_advban_range.ban_provider`
(`Drupal\autoban_advban\AdvbanRangeProvider`) exposes id `advban_range` ("Advanced Ban (range)",
ban type `range`); both return `hasMetadata() = TRUE`. Once enabled, `advban` and `advban_range`
become selectable as the **provider** of an Autoban rule, so matched IPs are banned through
Advanced Ban's IP manager — the range provider can ban whole CIDR blocks rather than single
addresses. It depends on the contrib `advban` module and on `autoban`; if `advban` is not
installed, this submodule cannot be enabled and its providers do not appear. It has no config,
settings form, permissions, or Drush of its own — its entire role is registering the two
Advanced Ban providers.

---

- Ban whole IP ranges (CIDR blocks) from Autoban rules using the `advban_range` provider.
- Ban single IPs through Advanced Ban instead of core Ban using the `advban` provider.
- Aggressively block a subnet of scanner IPs with one range ban rather than many single bans.
- Set an Autoban rule's `provider` to `advban_range` to escalate repeat offenders to range bans.
- Use Advanced Ban's expiry/temporary-ban features (via advban) for Autoban-created bans.
- Choose "Advanced Ban" or "Advanced Ban (range)" in the provider select on the rule form.
- Combine core-Ban single bans (autoban_ban) with advban range bans on the same site.
- Ban a hostile /24 network detected through repeated 404 or access-denied log entries.
- Route cron-run Autoban rules to Advanced Ban's IP manager automatically.
- Push IPs discovered on the Autoban Analyze page into Advanced Ban.
- Ban ranges reported by `drush autoban:ban` for rules whose provider is `advban_range`.
- Provide range-banning capability that core Ban alone cannot offer.
- Manage Autoban-created bans through Advanced Ban's admin UI.
- Use metadata-aware banning (`hasMetadata() = TRUE`) for richer ban records.
- Escalate from single-IP to range banning as an attack broadens across an address block.
- Serve as an example of a provider that wraps a contrib ban backend via `@advban.ip_manager`.
- Ban authenticated-user abuse by IP range where a single ban is insufficient.
- Keep single and range providers available side by side for per-rule choice.
- Deploy range-ban rules as configuration across environments (the rule's `provider` = `advban_range`).
