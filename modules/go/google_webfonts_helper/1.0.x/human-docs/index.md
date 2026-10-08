# Google Webfonts Helper — manual setup guide

**Google Webfonts Helper** (`google_webfonts_helper`) downloads Google Fonts and
serves them from your own server, so no visitor request ever reaches Google's font
CDN. It integrates with the online service of the same name: you pick fonts through
the admin interface, and the module downloads the files and generates the matching
`@font-face` stylesheet as a Drupal library.

The reason to self-host is usually **legal rather than technical**. A 2022 German
court ruling found that embedding Google Fonts from Google's servers transmits the
visitor's IP address to a third country without consent, in breach of the GDPR, and
a wave of claims followed — so many European organisations now require self-hosting
as policy. Self-hosting also removes the need to gate fonts behind a consent
banner (a font loaded from your own domain is not a third-party request), and,
since browser cache partitioning ended cross-site font reuse, it is generally
faster too.

Each font you add becomes a `google_webfont` **configuration entity**, so your font
choices export with `drush cex` and travel in version control. One deployment
caveat: the actual font *files* are downloaded to the filesystem, so each
environment must either carry those files or re-fetch them — a config export alone
does not include them.

This release is an alpha (8.x-1.0-alpha14); keep that in mind on production sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no traditional settings form** — you manage fonts as configuration
entities, described in "How to use it" below.

## Where it lives in the admin menu

Font management is at **Configuration → System → Google Webfonts Helper**
(`/admin/config/system/google-webfonts-helper`), behind the *administer
google_webfonts_helper* permission.

## How to use it

1. Go to **Configuration → System → Google Webfonts Helper**.
2. **Add** as many fonts as you need, choosing the specific weights and subsets you
   want. The module downloads the font files and generates a stylesheet for each
   font.
3. Attach the generated library where you need it, using the library name shown on
   the admin page — `google_webfonts_helper/[webfont_id]`. You can copy it straight
   from that page into your theme's `*.libraries.yml` / `*.info.yml`.
4. Reference the new font family in your CSS and you are self-hosting.

Remember that the downloaded files live on the filesystem: commit them or re-fetch
per environment so every environment has the actual fonts, not just the config.
