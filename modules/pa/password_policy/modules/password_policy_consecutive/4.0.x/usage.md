Provides a Password Policy constraint that blocks runs of consecutive identical characters in a password.

---

This submodule adds the `consecutive` constraint plugin. Its single setting, `max_consecutive_characters` (a value from 2 to 5), sets the shortest run of the same character that is disallowed. Validation uses the regex `/(.)\1{max-1}/` to detect any character repeated that many times in a row (case-sensitive), so a value of 2 forbids any doubled character while a value of 3 forbids "aaa" and longer. It is a lightweight rule that discourages lazy patterns like "aaaa" or "111111". Add it to a policy on the Password Policy admin screen. Config schema lives at `password_policy.constraint.plugin.consecutive`.

---

- Forbid any character repeated 3 or more times in a row.
- Block doubled characters entirely (max of 2).
- Discourage lazy patterns like "aaaa" or "0000".
- Prevent keyboard-mashing passwords with long repeats.
- Add anti-pattern protection on top of length/complexity rules.
- Apply a stricter no-repeats rule to admin roles.
- Allow up to 4-in-a-row for low-risk roles.
- Provide a clear "too many consecutive characters" error.
- Show the rule live in the compliance table.
- Combine with a blacklist to catch obvious weak passwords.
- Meet policies that prohibit repeated character sequences.
- Deploy the rule as exportable policy config.
- Differentiate repeat limits per role via separate policies.
- Add it to an existing multi-constraint policy.
- Catch passwords that pass length checks but are still trivial.
- Enforce case-sensitive repeat detection.
- Nudge users toward more varied passwords.
- Layer with character-type minimums for stronger passwords.
