User Account Language Negotiation provides a single language-negotiation plugin ("User account saver") that persists the language a logged-in user switches to into their account's `preferred_langcode`, so the site opens in their previously chosen language on their next login.

---

The module extends core's `LanguageNegotiationUser` with a plugin (`language-user-account-saver`) that is enabled at *Configuration → Regional and language → Detection and selection* (`admin/config/regional/language/detection`). On each request the plugin's `getLangcode()` reads the URL prefix (or `?language=` query for prefix-less languages) against the configured `language.negotiation` prefixes; when a match is found it returns that langcode AND — as a side effect — writes it to the current authenticated user via `$user->set('preferred_langcode', ...)->save()` (skipped when the session is not writable, e.g. during `AccountSwitcher` impersonation), or stores it in `$_SESSION['language-anon']` for anonymous visitors. It also implements `LanguageSwitcherInterface::getLanguageSwitchLinks()` so a standard Language switcher block renders links (using either a URL prefix or a `language` query argument), and `InboundPathProcessorInterface::processInbound()` to strip the language prefix from the path. The module ships no config UI of its own (`configure` points at core's negotiation page), no permissions, no schema, and no Drush. On install it seeds locale translations of the standard language names (so languages display in their own translation); on uninstall it removes itself from `language.types` enabled plugins to avoid a "plugin does not exist" error. The maintainer recommends making this the ONLY enabled interface-language plugin so the login transition is deterministic.

---

- Persist a logged-in user's interface language across sessions/logins via `preferred_langcode`.
- Let a language switcher block save the chosen language into the user's account, not just the session.
- Transition a returning user to their previously preferred language automatically at login.
- Provide language negotiation for interface, content, and URL language types from one plugin.
- Detect language from a URL path prefix (e.g. `/de/...`) and record it on the account.
- Detect language from a `?language=<langcode>` query for languages configured without a prefix.
- Fall back to core's user-account negotiation (`preferred_langcode`) when no prefix is present.
- Store the chosen language in the session for anonymous visitors (`$_SESSION['language-anon']`).
- Render language switch links through Drupal's standard Language switcher block.
- Show languages in their own native translation on a fresh multilingual install.
- Avoid clobbering the stored language while a user is being impersonated (write-safe session check).
- Replace the default set of interface-language detection plugins with a single deterministic one.
- Give multilingual sites with mostly-authenticated users a "remember my language" behavior.
- Strip the language prefix from inbound paths so routing resolves correctly.
- Combine with core's Language switcher and the Language Icons module for a flag-based UI.
- Cleanly uninstall without leaving a dangling negotiation plugin reference in `language.types`.
