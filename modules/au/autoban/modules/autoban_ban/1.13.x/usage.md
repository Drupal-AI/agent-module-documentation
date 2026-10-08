<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Autoban Core Ban Provider is the Autoban submodule that plugs Drupal core's **Ban** module into Autoban, exposing a ban provider with id `ban` ("Core Ban") that bans single IP addresses through core's `BanIpManager`.

---

This is a thin glue submodule: one service, `autoban_ban.ban_provider`
(`Drupal\autoban_ban\BanProvider`), tagged `ban_providers` and implementing
`Drupal\autoban\AutobanProviderInterface`. It reports `getId() = 'ban'`,
`getName() = 'Core Ban'`, `getBanType() = 'single'`, `hasMetadata() = FALSE`, and returns a
core `Drupal\ban\BanIpManager` from `getBanIpManager()`. Once enabled it makes `ban` selectable
as the **provider** of any Autoban rule; when such a rule fires, the matched IPs are written to
core Ban's blocked-IP list (the same list managed at `/admin/config/people/ban`). It depends on
core `ban` and on `autoban`. It has no config, no settings form, no permissions, and no Drush of
its own — its entire contribution is registering the `ban` provider so Autoban can execute
single-IP bans without any extra infrastructure.

---

- Enable single-IP banning for Autoban rules using nothing but Drupal core's Ban module.
- Set an Autoban rule's `provider` to `ban` so matched IPs are added to core Ban's blocklist.
- Ban IPs that trigger repeated 404s straight into the core Ban list, no contrib ban backend needed.
- Provide the default, always-available ban provider on a site that only wants single-IP bans.
- Let administrators see and manage Autoban-created bans on the standard core Ban admin page.
- Use `drush autoban:ban` with rules whose provider is `ban` to push IPs into core Ban.
- Choose "Core Ban" in the provider select on the Autoban Add/Edit rule form.
- Ban anonymous scanner IPs individually via core Ban when a rule's threshold is exceeded.
- Serve as the reference implementation of `AutobanProviderInterface` for writing your own provider.
- Keep ban storage in core (no Advanced Ban / range support) for a minimal footprint.
- Combine core-Ban single bans (this provider) with range bans from `autoban_advban` on the same site.
- Have cron-run Autoban rules deposit offending IPs into the core Ban table automatically.
- Wire a manual "ban all" run for a rule to core Ban's blocklist.
- Rely on core Ban's middleware to actually block the banned IPs on subsequent requests.
- Migrate from a custom ban approach to Autoban while continuing to use core Ban as the backend.
- Guarantee at least one working provider exists for Autoban on a vanilla site with Ban enabled.
- Test Autoban rule matching end-to-end using the simplest possible ban backend.
- Ban IPs discovered on the Autoban Analyze page through core Ban.
- Use the provider's `single` ban type where whole-range banning is unnecessary or too aggressive.
- Provide Autoban functionality on hosting where only core modules are permitted.
