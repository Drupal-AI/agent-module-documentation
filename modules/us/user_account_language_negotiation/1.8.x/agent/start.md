# User Account Language Negotiation — agent index

Adds one language-negotiation plugin, **User account saver** (`language-user-account-saver`), that
persists the language a logged-in user switches to into their account's `preferred_langcode`.
Depends on core `language` + `locale`. No permissions, no Drush, no config schema of its own;
`configure` points at core's negotiation page (`language.negotiation`).

- **Enable & configure the plugin, the exact save behavior, switch-link handling** →
  [configure/negotiation.md](configure/negotiation.md)

Key facts:
- Plugin id `language-user-account-saver`, weight 49, applies to interface + content + URL language types.
- `getLangcode()` matches the URL prefix (or `?language=` for prefix-less langs) against
  `language.negotiation` `url.prefixes.*`; on match it saves `preferred_langcode` to the current user
  (only when the session is writable) or `$_SESSION['language-anon']` for anonymous.
- No settings form; managed entirely from `admin/config/regional/language/detection`.
- Install seeds native-name locale translations; uninstall removes the plugin from `language.types`.
