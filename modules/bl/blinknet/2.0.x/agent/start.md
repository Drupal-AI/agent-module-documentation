<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blink.net Integration - agent index

**Blink.net Integration** wraps the Blink.net service with donation/subscription blocks. Version **2.0.0** (`2.0.x`). Core `^9.3 || ^10`.

## Key files
- `src/Form/ConfigForm.php` - settings at `/admin/config/services/blinknet` (`administer blinknet`).
- `src/Plugin/Block/{DonationButton,DonationContainer,SubscriptionButton,SubscriptionContainer}.php`.

Admin-configured embed blocks; no anonymous mutation routes.