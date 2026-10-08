# Configuration

This module has **no settings form of its own**. You configure it entirely on
Drupal's standard language‑detection page by enabling and ordering its plugin.

## Enable the plugin

1. Log in as a user who can administer languages.
2. Go to **Configuration → Regional and language → Detection and selection**
   (`/admin/config/regional/language/detection`).
3. For the language type you want (usually **Interface text language detection**),
   tick **User account saver** to enable it, and set its weight.
4. Save.

## Recommended setup

For a clean, deterministic "remember my language" experience, the maintainer
recommends making **User account saver** the **only** enabled plugin for
*Interface text language detection*. That way the language a user picks is always
the one that's saved and restored, with no other detection method overriding it.

You'll also want a way for users to switch language — for example, place core's
**Language switcher** block at **Structure → Block layout**. If you want a
flag‑based switcher, this pairs well with the Language Icons module.

## What the plugin does on each request

Once enabled, **User account saver** runs on every request:

- It reads the language from the **URL prefix** (e.g. `/de/...`) for languages
  configured with a prefix, or from a **`?language=<langcode>`** query for
  languages configured without one.
- On a match, for a **logged‑in user** it saves that language to their account's
  `preferred_langcode` — but it deliberately skips saving while the user is being
  impersonated or otherwise switched by the system, so an admin viewing as another
  user doesn't overwrite that user's preference.
- For an **anonymous visitor** it stores the choice in the session instead.
- If there's no prefix or query match, it falls back to core's normal
  user‑preference lookup (or the anonymous session value).

It also renders language‑switch links for the standard Language switcher block and
strips the language prefix from inbound paths so routing works correctly.

## Clean uninstall

When you uninstall the module it removes its own plugin from the enabled
language‑detection list, so you won't be left with a dangling "plugin does not
exist" reference. If you had made it the only interface‑detection plugin, remember
to enable another detection method afterward so language detection still works.
