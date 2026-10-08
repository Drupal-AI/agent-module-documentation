<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Waste Collection — agent index

Provides **waste-collection schedule lookup (by address)** for LocalGov Drupal (council) sites, with a
pluggable provider system (CSV/example/whitespace provider submodules). Version **1.0.0-alpha12**. Core
`^10||^11`.

Integration/public-services — lookups are usually **by address (personal data)**: handle/log per privacy
policy; provider API **credentials** as secrets over HTTPS. No access role.
