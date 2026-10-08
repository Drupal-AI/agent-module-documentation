<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Invitation generates random codes that gate access to a specific webform, so only holders of a valid, unused invitation code can submit it.

---

Some forms should only be filled in by invited people — an RSVP tied to a specific guest, a survey sent to a selected panel, a claim form for a known list. Webform Invitation supports that: it generates random invitation codes, and a webform can require a valid code to be submitted, with codes being single-use or limited as configured. Someone without a code cannot submit the form.

It is a gating mechanism, and its strength is exactly the strength of the codes and how they are checked. The security-relevant questions for any code-gated form are whether the codes have enough entropy to resist guessing, whether they are single-use so a leaked code cannot be replayed indefinitely, and whether the validation is not bypassable. Treat the codes as low-grade secrets: distribute them over a channel appropriate to what the form protects, and remember that a code gate controls *who can submit*, not confidentiality of the form itself.

For invitation-only submissions — events, panels, claims — it is a focused tool. Match the code quantity and reuse policy to the sensitivity of what the form does, and do not rely on a short or reusable code to protect a high-value submission.

---

- Gate a webform with invitation codes.
- Require a code to submit a form.
- Send invitation-only RSVPs.
- Restrict a survey to invited people.
- Generate random access codes.
- Make codes single-use.
- Limit who can submit a form.
- Distribute codes to a guest list.
- Protect a claim form with a code.
- Match code entropy to sensitivity.
- Prevent uninvited submissions.
- Track used invitation codes.
- Run an invite-only event form.
- Issue codes to a panel.
- Validate a code on submit.
- Bound code reuse.
- Control form submission access.
- Send unique codes.
- Gate a registration form.
- Restrict a form to a known list.