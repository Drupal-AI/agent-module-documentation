<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Big pipe override — agent index

**Overrides core BigPipe by disabling it** (turn off streaming/placeholder rendering — for reverse-proxy/
decoupled/caching setups that conflict with streamed responses). Version **1.0.x** (dev). Core
`^8||^9||^10||^11`.

Performance/rendering — disabling BigPipe renders dynamic content inline (weigh the perceived-performance
tradeoff); no content/access role.
