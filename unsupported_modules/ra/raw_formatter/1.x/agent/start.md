<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Raw Field Formatter (raw_formatter) — agent index

Renders a (JSON) field value through a theme template. Version **dev**.

**WARNING (verified — see `security.md`, danger 3, STORED XSS):** its only sanitization is
`preg_replace('/<[^>]*>/', '', …)` and the template outputs `{{ raw_value|raw }}` (unescaped). The
regex needs a closing `>`, so a **malformed** tag survives — verified `<img src=x onerror=alert(1)`
(no `>`) reaches the raw output and executes. Field value is authored content → **content editors can
plant it**. **Do not use on fields set by untrusted users** until fixed (drop `|raw`, or use
`Xss::filter()`/`check_markup()`).