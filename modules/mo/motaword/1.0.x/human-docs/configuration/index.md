# Configuration

MotaWord is deliberately light to configure in Drupal: you paste an **Active
token** and the module reads the rest of what it needs from your MotaWord project.
Everything else — the languages you support, translation tuning, editing, and so
on — is managed in your MotaWord dashboard.

## Open the settings form

1. Log in as a user with the **Administer MotaWord** permission
   (`administer motaword`) — an administrator by default.
2. Go to **Configuration → MotaWord** (`/admin/config/motaword`).

## The settings

- **Active token** — paste the Active token from your MotaWord project (found on
  the project page in the MotaWord dashboard). Once you save, the module
  **configures itself from your project metadata** — the languages and settings
  come from the MotaWord project, so you don't re-enter them here. Treat the
  token as a **secret**: prefer supplying it from an environment variable rather
  than committing it. With DDEV you can store it with
  `ddev dotenv set .ddev/.env --motaword-active-token=<value>` (restart DDEV
  afterwards) and reference the environment value.
- **Preview / admin-only mode** — MotaWord supports an admin-only preview mode so
  you can see translations before they go live to visitors. Use it to check the
  result, then switch translation on for everyone.

## Controlling localisation of your own links

Beyond the automatically injected language switcher, you can tag your own links
to control how MotaWord treats them:

- `localize-page-as-fr` — link to the French version of a page.
- `localize-as-es-MX` — localise as a specific locale (here Mexican Spanish).
- `nolocalize` — leave a link untranslated.

MotaWord rewrites these correctly for both search engines and visitors.

## Multisite

Configuration is per-site, so each site in a multisite install has its own
MotaWord token and settings.

## Where the rest happens

The Drupal module is the connector; the language operations platform is your
MotaWord dashboard. There you pick which languages to support, tune the AI
translation, edit translations in a side-by-side editor, order professional human
translation for the pages that matter, and manage glossaries and style guides.

## Privacy

Your content is sent to and processed by MotaWord (a third-party service) and
served from its CDN. Factor this into your privacy assessment, and keep the
Active token secret.
