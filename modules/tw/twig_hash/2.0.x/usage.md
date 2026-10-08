<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig Hash provides hashing functionality for Twig variables, exposing hash functions in templates.

---

Twig Hash provides Twig functions for hashing values within templates — letting theme/template code
compute a hash of a variable (e.g. for cache keys, deterministic IDs, or gravatar-style
email-hashing) without a preprocess function. It exposes hashing to the Twig layer.

Use it in themes/templates that need a hash of some value inline. It is a theming/developer utility
adding Twig functions; it has no content or access behaviour. Note that hashing in templates is for
non-security purposes (IDs, cache keys) — do not treat a template-computed hash as a security control
(it is not a substitute for proper cryptographic handling of secrets). Use the functions where a hashed
value is needed in markup.

---

- Hash values in Twig templates.
- Compute a hash of a variable.
- Generate deterministic IDs.
- Create cache keys from values.
- Hash an email for gravatar.
- Expose hashing to Twig.
- Avoid a preprocess for hashing.
- Use in themes/templates.
- Have no content/access behaviour.
- Not use as a security control.
- Compute inline hashes.
- Add Twig hash functions.
- Hash for non-security IDs.
- Provide template hashing.
- Generate hashed markup values.
- Use hashes in templates.
- Compute template hashes.
- Add hashing utilities.
- Hash template variables.
- Produce deterministic hashes.
