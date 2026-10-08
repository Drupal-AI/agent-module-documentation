# Klaro Cookie & Consent Manager — manual setup guide

**Klaro Cookie & Consent Manager** (`klaro`) brings the open-source Klaro!
JavaScript consent manager into Drupal. It shows a GDPR-style cookie/consent
banner and holds back third-party services — analytics, maps, video embeds,
social widgets — until the visitor opts in.

Klaro models consent as two kinds of configuration entity. **Services**
(`klaro_app`) are the individual scripts or integrations you want to gate — for
example Matomo, Google Analytics, YouTube, or Leaflet — and each one is grouped
under a **Purpose** (`klaro_purpose`), a category such as analytics, advertising,
or external content. The module ships ready-made service and purpose definitions
for many common tools, so much of the setup is already done for you.

Once enabled, Klaro adds its banner and modal to every page and quietly rewrites
matching script tags and library assets so they do not run until the visitor
accepts the relevant service. A bundled text filter, **Decorate external
sources**, does the same for iframes and embeds pasted into body content — they
show a click-to-load placeholder until consent is given. Everything is stored as
configuration, so your consent setup is exportable and deployable across
environments, and a bundled recipe wires Klaro into Google Consent Mode.

Two permissions keep the roles clean: one for administering Klaro, and one that
simply lets a visitor re-open the consent manager to change their mind. Global
behavior (styling, default state, testing mode, cookie name and expiry) and all
the banner copy each live on their own settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its JavaScript
   library with Composer, then enable it.
2. [Configuration](configuration/index.md) — the settings and text forms, the
   services and purposes, permissions, and the Google Consent Mode recipe.

## Where it lives in the admin menu

Klaro's settings live under **Configuration → User interface → Klaro**
(`/admin/config/user-interface/klaro`). From there you reach the global
**Settings** form, the **Text settings** form, and the collections of **Services**
and **Purposes**. Permissions are granted at **People → Permissions**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). The Klaro banner
   appears on the front end straight away.
2. Review the bundled **Services** and **Purposes** and enable the ones that match
   the tools your site actually loads (Matomo, YouTube, Google Maps, and so on).
3. Adjust global behavior and cookie settings on the **Settings** form, and edit
   the banner wording on the **Text settings** form.
4. Give the **Use Klaro! UI** permission to your visitors (authenticated and/or
   anonymous) so they can re-open the consent manager from a "Cookie settings"
   link.
