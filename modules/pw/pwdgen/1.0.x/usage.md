<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Password Generator (pwdgen) generates passwords from one word or more to memorize.

---

Password Generator (pwdgen) generates memorable passwords — building a password from one or more words
(with symbol/case variation) so the result is easier to remember while still varied. It is configured at
`pwdgen.admin_settings`, provides Drush commands and its own permissions.

Use it to generate memorable passwords. Its randomness is sound: it uses PHP's **`random_int()`** (a
cryptographically-secure RNG) for its random choices (symbol insertion, selection), so the generated
passwords have proper entropy from a CSPRNG (a minor implementation note: it also uses `shuffle()` for
reordering, which is non-cryptographic, but the meaningful entropy comes from the `random_int`-based
selection). As with any generated password, the resulting strength depends on the configured length/
complexity — choose settings that yield sufficient entropy for the use case. It has no access-control role.
Configure the generation options.

---

- Generate memorable passwords.
- Build passwords from words.
- Add symbol/case variation.
- Configure at pwdgen.admin_settings.
- Provide Drush commands and permissions.
- Use random_int (CSPRNG) for randomness.
- Get proper entropy from a secure RNG.
- Note shuffle() is non-crypto (minor).
- Choose sufficient length/complexity.
- Have no access-control role.
- Configure generation options.
- Generate passwords securely.
- Handle password generation.
- Configure complexity.
- Make memorable passwords.
- Generate from words.
- Handle the generator.
- Configure passwords.
- Produce strong passwords.
- Generate credentials.
