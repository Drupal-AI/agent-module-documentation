<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple password policy applies basic rules to passwords — length, character classes and similar — as a lighter alternative to the full Password Policy module.

---

The established module in this space, `password_policy`, is a plugin architecture with per-role policies, expiry, history and a constraint system, and for an organisation with a written password standard that is what it is for. Most sites do not have one: they have a requirement to not accept `password`, and the full module is a large amount of configuration surface for that. Something smaller is a reasonable choice, and the permissions here are sensibly split — `administer password policy` marked `restrict access: TRUE`, and a separate `bypass password policy` so a service account or an administrator can be exempted without weakening the rules. Version **1.0.5** on core `^10.1 || ^11`. **The uncomfortable point is worth making whenever a complexity policy comes up: current guidance has moved away from composition rules.** NIST 800-63B and the UK NCSC both now recommend against mandatory character-class requirements and against periodic forced expiry, on the evidence that they push people toward predictable transformations — `Password1!` satisfies most rule sets and appears in every breach corpus, and forced rotation produces `Password2!`. What the same guidance recommends instead is a **length minimum** and **checking against known-breached passwords**, which is what `pwned_passwords`, documented in wave 76, does. So the useful configuration of a module like this is usually a generous length floor and little else, with the breach check doing the work that complexity rules were meant to do. Two practical notes: policies apply where they are enforced, so check registration, profile edit, password reset and any programmatic user creation; and a rule that rejects a password after a long form has been filled in should say what it wants before the submission, not after.

---

- Require a minimum password length.
- Reject obviously weak passwords.
- Apply a basic password standard.
- Meet a simple security requirement.
- Set a length floor for accounts.
- Exempt a service account from the policy.
- Apply rules without a full policy module.
- Improve account security cheaply.
- Enforce a character requirement.
- Support a small site's password rules.
- Reject a password matching the username.
- Apply a policy at registration.
- Meet an audit's password requirement.
- Strengthen editor account passwords.
- Set rules for a membership site.
- Apply a policy without per-role complexity.
- Enforce length on password reset.
- Reduce weak password usage.
