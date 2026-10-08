# Configuration

Localized Configuration has two distinct places you work: a **settings form** that
governs the framework, and the **editing form** where the actual values for each
plugin are entered per language.

## The settings form

1. Log in as a user with the **Access localized config settings** permission.
2. Go to **Configuration → Localized configuration → Settings**, or navigate
   directly to `/admin/config/localized/settings`.

From here you control:

- **Language filtering** — restrict the interface to the languages relevant to
  your site. In a multisite context languages are often coded in a
  `language-sitename` format, and you can filter the interface down to only the
  site-coded languages so editors aren't shown languages that don't apply to them.
- **Language support on/off** — you can turn the locale aspect off entirely and
  expose only the global configuration, which is handy if you want the centralized
  settings UI without the per-language layer.
- **Enabling plugins** — switch individual localized config plugins on or off.
  Only enabled plugins appear on the editing form.

## Editing values per language

Once plugins are enabled, edit their values at `/admin/config/localized/{language}`
(reachable through the module's editing form). Each language you are permitted to
edit appears as a tab. A plugin marked `global_only` is editable only at the global
level; other plugins can hold both a global value and per-language overrides, and
at runtime the helper resolves the current language first, then falls back to the
global value.

## Permissions

- **Access localized config** — needed to reach the editing interface at all.
- **Access localized config settings** — needed to reach the settings form above.
- **Enable localized config plugins** — governs toggling plugins on and off.
- **Per-plugin permissions** — each enabled plugin generates its own edit
  permission, so you can grant a role the ability to edit one plugin's settings
  without granting it the others.

Note that even where the editing route is declared with a `'TRUE'` access marker,
that is the hook for the module's own custom access checker — it still enforces the
**Access localized config** permission and checks that the language is one the user
is allowed to edit (and not blacklisted). It is not an open route.

## Which languages a user may edit

The framework limits editable languages to those in a user's allowed set and lets
you blacklist languages from the interface entirely, so you can hand specific
editors specific languages.
