<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Key per language lets a Key entity resolve to a different secret depending on the active language.

---

Key per language is a provider for the Key module that allows a key to resolve to a different value per language — so a multilingual site can use language-specific API keys or secrets (e.g. a different third-party credential per market/language) through a single Key entity.

Because it manages secrets, follow the Key module's secure-storage guidance (env/Key providers, never commit values); the per-language values should each be sourced securely. Supports Drupal 8.9 through 11.

---

- Provide a per-language Key value.
- Resolve secrets by active language.
- Support language-specific credentials.
- Use one Key entity per language set.
- Serve multilingual API keys.
- Follow Key's secure-storage guidance.
- Source each value securely.
- Never commit secret values.
- Support Drupal 8.9 through 11.
- Integrate with the Key module.
- Manage per-market secrets.
- Handle language-specific keys.
- Support multilingual integrations
- Provide a key provider.
- Vary keys by language.
- Keep secrets secure.
- Configure per-language keys.
- Resolve keys dynamically
