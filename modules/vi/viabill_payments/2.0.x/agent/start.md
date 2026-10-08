<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ViaBill Payments — agent index

**ViaBill payment gateway for Drupal Commerce**. Version **2.0.3**. Core `^10||^11`.

Callback `/payment/viabill/callback` verifies a SHA-256 signature (over fields + secret) before completing the order (minor: `===`, non-constant-time). Keys env-backed. Depends on `commerce`/`commerce_payment`/`commerce_log`.