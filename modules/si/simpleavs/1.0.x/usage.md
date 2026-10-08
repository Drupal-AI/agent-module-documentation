<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple AVS provides a simple, cookie/session-based age verification gate with themable overlay.

---

Simple AVS provides a **cookie/session-based age-verification gate** — a themable "confirm you are over
N" overlay shown before content, for sites that need an age prompt. It provides its own permissions, in the Age
Verification package.

Use it to show an age-verification prompt. It uses a one-time session token
(`bin2hex(random_bytes(16))`). The gate is an advisory **JS overlay** (attached via `hook_page_attachments`)
over the normally rendered page, and both paths are self-reported: the "yes, I'm old enough" answer marks the
session passed, and the date-of-birth path uses the date the visitor enters. It satisfies a "we showed an age
prompt" requirement; use access control when content must be restricted. Configure the age gate.

---

- Show an age-verification prompt.
- Use a cookie/session gate.
- Provide a themable overlay.
- Generate a sound one-time token.
- Treat it as an advisory age prompt.
- Use access control when content must be restricted.
- Provide its own permissions.
- Configure the age gate.
- Handle age verification.
- Show the prompt.
- Configure the overlay.
- Gate by age (advisory).
- Handle the gate.
- Prompt for age.
- Not treat as access control.
- Provide an age prompt.
