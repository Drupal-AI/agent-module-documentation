<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Waste Collection provides lookup for waste collection schedules and common data providers.

---

LocalGov Waste Collection provides **waste-collection schedule lookup** for LocalGov Drupal (council)
sites — residents look up their bin-collection schedule (typically by address), with a pluggable provider
system (it ships CSV, example and whitespace providers) to source the data. It provides submodules per
provider, in the LocalGov Drupal package.

Use it on council sites for bin-collection lookups. It is an integration/public-services feature. Privacy note:
lookups are usually **by address/location**, which is personal data — handle and log those queries per your
privacy policy, and if a provider calls an external council API, handle its **credentials** as secrets and use
HTTPS. It has no access-control role. Configure the waste-collection provider.

---

- Look up waste-collection schedules.
- Serve council (LocalGov) sites.
- Look up by address.
- Use a pluggable provider system.
- Ship CSV/example providers.
- Show bin-collection dates.
- TREAT address lookups as personal data.
- Handle/log queries per privacy policy.
- Handle provider API credentials as secrets.
- Have no access-control role.
- Configure the provider.
- Handle waste collection.
- Provide schedule lookup.
- Configure the lookup.
- Look up bins.
- Handle the providers.
- Show schedules.
- Provide lookups.
- Set the provider.
- Provide waste-collection lookup.
