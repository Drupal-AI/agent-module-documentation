<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Browscap provides a replacement for PHP's get_browser() function, detecting browser and device capabilities from the user agent.

---

Browscap provides a replacement for PHP's `get_browser()` function — detecting browser and device
capabilities from the user-agent string, using the Browser Capabilities Project data, so code can query
what browser/device a visitor is using (and its capabilities) without relying on the server's PHP browscap
configuration. It is configured at `browscap.admin`, provides its own permissions, and is in the Developer
Tools package.

Use it where code needs browser/device capability detection. It is a developer/detection utility; browser
detection is user-agent-based (a heuristic that can be spoofed), so use the results for presentation/feature
decisions, not for anything security-sensitive. It has no content-access role. Note it maintains browscap
data (updated periodically). Configure the data source/updates.

---

- Replace PHP's get_browser().
- Detect browser/device capabilities.
- Use Browser Capabilities Project data.
- Query the visitor's browser.
- Configure at browscap.admin.
- Provide its own permissions.
- Avoid server browscap config.
- Know detection is user-agent-based.
- Use results for presentation, not security.
- Have no content-access role.
- Maintain browscap data.
- Detect device capabilities.
- Query user-agent info.
- Update browscap data.
- Handle browser detection.
- Provide capability detection.
- Configure the data source.
- Detect browsers reliably.
- Use for feature decisions.
- Parse user agents.
