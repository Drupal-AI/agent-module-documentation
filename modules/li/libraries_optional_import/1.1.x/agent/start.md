<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Libraries optional import (libraries_optional_import) — agent index

**Marks theme library CSS/JS assets as optional so missing files are dropped instead of erroring.**

- **Version:** 1.1.x (1.1.0)
- **Core:** ^10 || ^11
- **How:** alters library info; for assets with `optional: true`, removes the entry when the file is absent under the theme path. Service `OptionalImport` (`optionalJsScripts` / `optionalCssScripts`, `ThemeExtensionList`-based existence check).
- **No routes, permissions, services exposed to users, or config.** Declarative via `*.libraries.yml` (`optional: true`).

**Security:** build-time asset filtering only; no web endpoints, no user input, operates on theme-owned files. No security findings.