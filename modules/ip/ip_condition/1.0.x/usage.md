<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IP Condition provides a condition plugin for the visitor's IP address.

---

IP Condition provides a **condition plugin that evaluates the current visitor's IP address** — so blocks (or
other condition-driven behaviour) can be shown/hidden based on the visitor's IP (e.g. internal vs external). It
works across core 9–11.

Use it to gate visibility by IP. Understand its security model: it controls **visibility, not access control**,
and the **client IP is not a trustworthy security boundary** — it comes from the request (via `getClientIp()`/
`getClientIps()`, which honor `X-Forwarded-For`), so it can be **spoofed** unless you have correctly configured
trusted reverse proxies; never rely on IP-based visibility to protect sensitive content or capabilities. It has
no access-control role. Configure the IP condition.

---

- Evaluate the visitor's IP.
- Gate visibility by IP.
- Distinguish internal/external.
- Serve condition-driven behaviour.
- Use getClientIp()/getClientIps().
- Show/hide blocks by IP.
- Control VISIBILITY, not access.
- TREAT client IP as untrusted (spoofable via X-Forwarded-For).
- Configure trusted proxies if relying on IP.
- Never protect sensitive content by IP.
- Have no access-control role.
- Configure the IP condition.
- Handle IP conditions.
- Condition on IP.
- Configure the condition.
- Check the IP.
- Handle the visibility.
- Gate by IP.
- Not trust the IP.
- Provide an IP condition.
