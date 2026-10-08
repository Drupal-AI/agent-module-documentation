<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Random Number Field adds a "Random Number (integer)" field type that fills an entity with a random integer from a configurable min/max range when the content is first created, for non-cryptographic identifiers, sampling or test data.

---

The module defines one field type (`random_integer`) that extends core's integer field, plus a matching widget and formatter. Its only added behaviour is in `applyDefaultValue()`: when a new entity is created the field's value defaults to `mt_rand(min, max)` using the per-field `min`/`max` settings (defaults 1 and 10). Once stored it is just an ordinary integer — editable, re-editable and displayed with core's integer formatter — so the "random" part happens exactly once, at creation, not on every load. The randomness is ordinary PHP randomness (not cryptographically secure), so it must never be used where unpredictability matters for security — not as a token, password, secret code or anything an attacker should not be able to guess. For raffle numbers, display randomisation, non-sequential IDs or test data it is a good fit; for anything security-sensitive use a cryptographic source instead. Note the field does not enforce uniqueness — two entities can receive the same number — so if you need a unique identifier add your own uniqueness handling.

---

- Add a random-number field to a content type or other entity bundle.
- Generate a raffle or lottery number on node creation.
- Populate a non-sequential display identifier for content.
- Assign a random sampling weight to entities.
- Seed test/demo content with varied numeric data.
- Give each new entity a random sort-tiebreaker value.
- Produce a pseudo-random reference number for internal, non-secret use.
- Scatter items randomly across buckets by number range.
- Set a per-field min/max range for the generated value.
- Use the default 1–10 range for a quick random flag.
- Display the value with core's integer formatter (thousands separator, prefix/suffix).
- Edit the generated number by hand after creation like any integer field.
- Attach the field to nodes, taxonomy terms, users or custom entities.
- Feed the value into Views as an ordinary integer field.
- Randomise which of several variants an entity uses via a number range.
- Keep the field for non-security randomness only.
- Never use the value as an access token or secret code.
- Add your own uniqueness check if you need distinct values.
- Restrict who can administer field settings.
- Test the range and behaviour on a staging site before production.
