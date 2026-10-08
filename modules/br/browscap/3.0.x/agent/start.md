<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Browscap — agent index

Replacement for PHP's **`get_browser()`** — detects browser/device capabilities from the user agent
(Browser Capabilities Project data). Config at `browscap.admin`; provides permissions. Version **3.0.x**
(dev). Core `^8.8||^9||^10||^11`.

Developer/detection utility — UA detection is a **spoofable heuristic**; use for presentation/features, not
security. No content-access role.
