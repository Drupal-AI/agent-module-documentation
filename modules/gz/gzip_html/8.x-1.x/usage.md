<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gzip Html output compresses the rendered HTML output of pages with gzip.

---

Gzip Html output compresses the rendered HTML of pages with gzip — reducing the size of HTML responses
sent to the browser to save bandwidth and speed up page loads. It is configured via the core performance
settings (`system.performance_settings`).

Use it to gzip HTML responses (typically where the web server isn't already doing compression). It is a
performance feature. A general note for HTTP compression: compressing responses that mix a secret (e.g. a
CSRF token or session-derived data) with attacker-influenced reflected input can, in specific setups, enable
compression side-channel attacks (BREACH); this is a niche concern and usually mitigated by TLS-layer
factors, but it's why compression of highly sensitive dynamic responses is worth a thought. For normal
public HTML it is a straightforward optimization. It has no content-access role. Enable compression in the
performance settings.

---

- Gzip-compress HTML output.
- Reduce HTML response size.
- Save bandwidth.
- Speed up page loads.
- Configure via performance settings.
- Compress rendered HTML.
- Use where the server isn't compressing.
- Note the BREACH side-channel niche.
- Think before compressing sensitive dynamic responses.
- Have no content-access role.
- Enable HTML compression.
- Optimize public HTML.
- Compress page output.
- Configure compression.
- Reduce page size.
- Handle gzip output.
- Enable gzip.
- Compress responses.
- Optimize delivery.
- Gzip HTML.
