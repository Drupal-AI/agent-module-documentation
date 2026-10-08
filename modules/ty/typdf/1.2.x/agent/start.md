<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Typdf - Typst PDF Engine — agent index

**Generates PDFs using the Rust-based Typst compiler**. Depends on core `file`. Provides permissions. Version
**1.2.0-alpha6**. Core `^10.3||^11||^12`.

PDF-generation — **security-conscious**: invokes `typst` via **Symfony Process** (argv, no shell injection) and
**scrubs sensitive env vars** (DATABASE_URL/cloud creds) from the subprocess. Requires the `typst` binary; treat
Typst templates as trusted/developer-defined. No access role beyond permission.
