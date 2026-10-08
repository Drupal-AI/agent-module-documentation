<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Localization Client lets translators translate a site's interface strings directly on the page they are viewing.

---

The functional module is `l10n_client_ui`, which depends on core Locale. Users with the `use localization client ui` permission get an on-page editor: browsing the site in a non-English language they open a translation pane listing every interface string on the current page (translated strings shown green, untranslated white), pick a string, and enter or edit its translation, which is saved to the local `locale` store via a `string_translator` service (`InterfaceTranslationRecorder`). A settings form lives at `/admin/config/regional/translate/client` behind the `administer languages` permission. A `l10n_client_contributor` submodule adds the ability to contribute translations to a remote localization server (e.g. localize.drupal.org) using an API key, gated by its own `contribute translations to localization server` permission.

Historically (Drupal 6/7) the module also shared translations and re-imported translation packages; the sharing/contribution path in this release is handled by the contributor submodule. The 3.0.x branch is an alpha and its UI submodule declares core `^8.8 || ^9 || ^10`; the project ships a hidden `^11` compatibility stub. Access is permission-based: on-page translation is limited to the translate permission and settings to language administrators; the contributor path needs an API key. Treat that localization-server API key as a secret.

---
- Enable on-page interface translation with the `l10n_client_ui` submodule.
- Grant translators the `use on-page interface translation` permission.
- Translate visible interface strings without leaving the page.
- Switch the site to a non-English language to start translating.
- Open the translation pane to see all strings on the current page.
- Filter the on-page string list to find a specific string.
- See at a glance which strings are already translated (green vs white).
- Edit an existing translation inline.
- Save translations to the local locale database.
- Configure the client at `/admin/config/regional/translate/client`.
- Restrict settings access to users with `administer languages`.
- Contribute translations to localize.drupal.org (contributor submodule).
- Store a localization-server API key for sharing.
- Gate contributions with the `contribute translations to localization server` permission.
- Speed up translating a new module's UI strings.
- Complement core Locale's bulk translation UI with in-context editing.
- Avoid the Overlay module, which the on-page pane cannot translate through.
- Review and correct machine/imported translations in context.
