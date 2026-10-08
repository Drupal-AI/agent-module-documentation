<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sequences provides a low-level named ID generator using database auto-increment.

---

Sequences **provides a named ID generator** — a low-level utility that generates unique sequential IDs per
named sequence using native database auto-increment, for developers needing gap-free/sequential identifiers (e.g.
invoice numbers). It works on core 10.3–11.

Use it as a developer building block for sequential IDs. It is a developer/API feature; it generates IDs and has no
content or access role. Note: sequential IDs are **predictable** — don't use them where unguessability is a
security requirement (use random tokens for secrets). Use the sequence API.

---

- Generate named sequential IDs.
- Use DB auto-increment.
- Provide gap-free identifiers.
- Serve developers.
- Offer an ID generator.
- Support invoice-number-style IDs.
- Generate predictable sequential IDs.
- Not use them where unguessability is required (use random tokens).
- Have no content/access role.
- Use the sequence API.
- Handle ID generation.
- Generate IDs.
- Configure nothing (API).
- Make IDs.
- Handle the sequences.
- Produce identifiers.
- Configure developers.
- Handle the generator.
- Number items.
- Provide a sequence generator.
