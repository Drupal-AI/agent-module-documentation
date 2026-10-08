<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare SDK Key lets a Cloudflare credential set resolve its API token from a Key entity instead of settings.php.

---

Cloudflare SDK Key is an optional submodule of Cloudflare SDK that integrates the suite with Drupal's Key module. By default a Cloudflare credential set reads its account ID and API token from settings.php; enable this submodule to instead resolve the token from a Key — so the secret can live in an environment variable, a file outside the webroot, or any other Key provider — while still keeping it out of exported configuration. It works by decorating the credential resolver: a credential set opts in by choosing an authentication Key on the credentials form and entering the (non-secret) account ID, both stored as third-party settings on the set (never the token itself). At runtime the decorator reads the token from the chosen Key; credential sets that name no Key fall straight through to the existing settings.php behaviour, so nothing else changes.

---

- Store a Cloudflare API token in a Key provider instead of settings.php.
- Keep the token out of exported configuration and version control.
- Choose the Key holding the token per credential set on the credentials form.
- Enter the (non-secret) account ID alongside the selected Key.
- Leave the Key empty to keep a set on the settings.php resolution path.
- Reuse any Key provider (environment variable, file, config, etc.) for the token.
- Enforce that an account ID is supplied whenever a Key is selected.
- Turn the integration on simply by enabling the submodule (it depends on Key).
