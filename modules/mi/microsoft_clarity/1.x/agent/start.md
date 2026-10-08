<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Microsoft Clarity (microsoft_clarity) — agent index

Injects the **Microsoft Clarity** behavioral-analytics script (heatmaps, **session recordings**).
Version **dev**. Core `^8.9 || ^9 || ^10 || ^11`. Configure with a Clarity project ID.

**Privacy-sensitive:** session recording observes visitor behavior and sends it to Microsoft.
Disclose in the privacy policy, **gate behind cookie/tracking consent** (don't run before consent),
and configure Clarity **masking** for sensitive fields. The module places the script; compliance is
operator configuration.