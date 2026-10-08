<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Typdf - Typst PDF Engine generates PDFs using the Rust-based Typst compiler (via Symfony Process, with a scrubbed subprocess environment).

---

Typdf **generates PDFs with the Typst compiler** — a high-performance PDF engine that replaces legacy PDF
generators by compiling Typst (a modern typesetting language) to PDF. It depends on core File, provides its own
permissions, in the PDF package.

Use it to render PDFs from Typst templates. It is a PDF-generation feature, and it invokes the external `typst`
binary **securely**: it uses **Symfony `Process`** (arguments passed as an argv array, not a shell string — so no
shell-injection), and it deliberately **scrubs sensitive environment variables** (DATABASE_URL, cloud credentials,
PLATFORM_*, etc.) from the child process so the Typst subprocess can't read them. Operational notes: it requires
the **`typst` binary** installed on the server, and Typst templates are code (a typesetting language) — treat the
templates as **trusted/developer-defined** (don't let untrusted users supply arbitrary Typst). It has no access-
control role beyond its permission. Configure the Typst binary path and templates.

---

- Generate PDFs from Typst.
- Use the Rust-based Typst compiler.
- Replace legacy PDF generators.
- Depend on core File + provide permissions.
- Serve PDF generation.
- Compile Typst to PDF.
- Invoke typst via Symfony Process (argv array, no shell injection).
- SCRUB sensitive env vars (DATABASE_URL, cloud creds) from the subprocess.
- Require the typst binary + treat Typst templates as trusted/developer-defined.
- Have no access-control role beyond permission.
- Configure the Typst binary + templates.
- Handle PDF generation.
- Render PDFs.
- Configure the engine.
- Compile Typst.
- Handle the subprocess.
- Produce PDFs.
- Generate documents.
- Trust the templates.
- Provide Typst PDF generation.
