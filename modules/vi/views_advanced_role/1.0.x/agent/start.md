<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Advanced Role — agent index

Views **access plugin with advanced role logic** (AND/OR/NOT — require all/any/exclude roles, beyond core's
simple role access). Depends on core `views`. Version **1.0.2**. Core `^8.8||^9||^10||^11`.

Genuine access-control — returns proper forbidden when the role condition isn't met (doesn't fail open),
gating the View's route. Verify the configured role logic matches intent.
