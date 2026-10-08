<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TrustArc Cookie Consent Manager configures and injects the TrustArc CMP script along with a banner and Cookie Preferences link.

---

TrustArc Cookie Consent Manager integrates the TrustArc Consent Management Platform (CMP) — injecting the
TrustArc script, a consent banner and a "Cookie Preferences" link, so the site can obtain and manage visitor
consent for cookies/tracking via TrustArc. It is configured at `trustarc.admin.header`, provides its own
permissions, in the Other package.

Use it to add TrustArc cookie-consent management. This is a **privacy-positive** feature: a CMP is how you
gate third-party tracking behind consent and meet GDPR/ePrivacy/CCPA obligations. To be effective it must
actually **block/defer non-essential scripts until consent** — ensure your tracking tags are wired to respect
the TrustArc consent signal (a consent banner that doesn't gate the scripts provides little protection). It
loads TrustArc's third-party script. It has no access-control role. Configure the TrustArc account and
consent behaviour.

---

- Inject the TrustArc CMP script.
- Show a consent banner + preferences link.
- Manage cookie/tracking consent.
- Configure at trustarc.admin.header.
- Provide its own permissions.
- Meet GDPR/ePrivacy/CCPA obligations.
- Gate non-essential scripts until consent.
- Wire tracking tags to the consent signal.
- Ensure the banner actually blocks scripts.
- Load TrustArc's third-party script.
- Have no access-control role.
- Configure the TrustArc account.
- Obtain visitor consent.
- Handle consent management.
- Configure consent.
- Add a CMP.
- Manage cookies.
- Gate tracking.
- Configure the banner.
- Handle privacy consent.
