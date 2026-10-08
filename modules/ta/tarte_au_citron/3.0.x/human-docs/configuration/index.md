# Configuration

Everything is configured through two forms under **Configuration → Tarte au citron**.
Both forms are built dynamically from the tarteaucitron.js library you installed, so the
exact options, services, and text strings you see depend on that library version. If the
library is missing, install it first — see [Installation](../installation/index.md).

| Form | Path | Permission |
|------|------|------------|
| Services & options | `/admin/config/tarte_au_citron/js` | Administer tarte au citron |
| Texts | `/admin/config/tarte_au_citron/texts` | Translate tarte au citron |

## The services & options form

This is the main form. It has two parts:

**Options.** Every default/parameter that the library exposes appears here — for example
the banner position and orientation, the privacy-policy URL, the cookie name, and so on.
Boolean options show as checkboxes; the rest as text fields. Fields that hold a URL are
validated when you save, and are passed through Drupal's bad-protocol filter before being
sent to the browser, so only safe URLs are emitted.

**Services.** A checklist of every third-party service the library knows about (Google
Analytics/GA4, YouTube, Vimeo, Facebook, X/Twitter, ad networks, maps, and many more).
Tick only the services your site actually uses. Some services need a parameter (such as an
analytics ID); those are entered in the per-service settings and are stored only for
services you have enabled.

When you save, the module rebuilds `drupalSettings.tarte_au_citron` and, on every page
(unless the visitor has the bypass permission), attaches the library and initializes the
banner.

## The texts form

The texts form controls what wording the banner uses. It offers three **strategies**:

- **Default** (blank strategy) — use the library's own text for the current interface
  language.
- **Forced language** — pin the banner to one specific language regardless of the site's
  interface language. You choose the language (or "current") in the **Forced language**
  field.
- **Custom** — override individual text strings yourself. Each translatable string the
  library defines gets a field where you can type your own wording. Custom values are
  sanitized (admin XSS filtering) on save, and empty overrides are dropped.

The texts form is translatable through Drupal's configuration translation, so you can
provide overrides per language.

## Permissions

Three permissions gate the module:

- **Administer tarte au citron** — access the services & options form. This is a
  restricted, trusted-admin permission.
- **Translate tarte au citron** — access the texts form (so translation work can be
  delegated without granting full admin rights).
- **Bypass tarte au citron** — for visitors in a role with this permission, the banner is
  not shown and the consent scripts are not attached. Useful for logged-in editors who do
  not need the banner.

## Setting values with Drush

The module has no Drush commands of its own, but you can read and write its config with
core Drush:

```bash
drush cset tarte_au_citron.settings services.gtag gtag -y
drush cset tarte_au_citron.settings tacConfig.orientation bottom -y
drush cr
```
