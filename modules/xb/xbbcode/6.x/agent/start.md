<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extensible BBCode (xbbcode) — agent index

Extensible **BBCode text filter** ([b], [url], custom tags → HTML). Version **6.0.0**. Submodule
`xbbcode_standard`.

**Security (any markup filter):** safety = proper escaping of user text/attributes so BBCode can't
inject HTML/JS (e.g. `[url]` with a `javascript:` URI). Mature module; standard tags output safe
HTML. **Confirm** the text format restricts **raw HTML** alongside BBCode, and **review custom tags**
for safe output (a custom tag echoing user input unescaped is an XSS vector — custom-tag authors are
trusted).