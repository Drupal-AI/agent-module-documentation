<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vipps MobilePay — agent index

Base **integration with the Vipps MobilePay** payment/identity platform (Nordic mobile payments) — API client/
services for consuming modules. Depends on core `telephone`. Provides permissions. Version **1.0.0-alpha1**. Core
`^10.3||^11`.

Payment/integration base — authenticates with **merchant API credentials** (secrets, env/Key, HTTPS); payment
flows/verification live in the consuming module. No access role beyond permission.
