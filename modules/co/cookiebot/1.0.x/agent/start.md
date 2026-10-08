# Cookiebot — agent index

Injects the hosted **Cookiebot** (Usercentrics) consent script from a single **CBID** (Domain
Group ID). All state lives in the `cookiebot.settings` config object; the actual consent UI,
scanning and blocking run on Cookiebot's servers. Depends on `js_cookie`. Configure route:
`cookiebot.admin_settings_form` → `/admin/config/cookiebot`. Permission: `administer cookiebot settings`.

- **All settings keys, the CBID, blocking/IAB/culture/exclusion options, drush config** →
  [configure/settings.md](configure/settings.md)
- **Cookie declaration block + theme hooks + marketing placeholder templates** →
  [theming/declaration.md](theming/declaration.md)
- **Alter hooks other modules can implement (`hook_cookiebot_path_match_alter`, `hook_cookiebot_culture_alter`)** →
  [hooks/alter-hooks.md](hooks/alter-hooks.md)

Key facts: the module is inert until `cookiebot_cbid` (a UUID `00000000-0000-0000-0000-000000000000`)
is set; the script tag is `https://consent.cookiebot.com/uc.js` with `data-cbid`. There are no
plugin types and no Drush commands.
