<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TrustArc Cookie Consent Manager — agent index

Injects/configures the **TrustArc CMP (cookie-consent)** — script + banner + "Cookie Preferences" link
(obtain/manage consent). Config at `trustarc.admin.header`; provides permissions. Version **1.1.0**. Core
`^10.2||^11`.

**Privacy-positive** (a CMP for GDPR/ePrivacy/CCPA). To be effective it must **block/defer non-essential
scripts until consent** — wire tracking tags to respect the TrustArc consent signal (a banner that doesn't
gate scripts protects little). Loads TrustArc's third-party script. No access role.
