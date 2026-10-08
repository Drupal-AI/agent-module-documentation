# Configuration

Everything Klaro does is configuration, so it exports cleanly with
`drush config:export` and deploys across environments. There are two settings
forms plus two collections of entities, all reachable from **Configuration → User
interface → Klaro** (`/admin/config/user-interface/klaro`).

## Settings

The main **Settings** form (`klaro.admin`) controls the global behavior of the
consent widget:

- **Styling / theme** — how the banner and modal look, so you can match the site.
- **Default toggled state** — whether services start opted-in or opted-out before
  the visitor chooses.
- **Show the banner automatically** — whether the notice appears on first visit or
  waits to be triggered.
- **Testing mode** — a preview mode you can leave on while building the site, so
  the banner behaves predictably during setup.
- **Cookie name, domain, and expiry (in days)** — where and how long the visitor's
  consent choices are remembered.
- **Library loading options** — how the Klaro! JavaScript is loaded.

These are stored in the `klaro.settings` config object.

## Text settings

The separate **Text settings** form (`klaro.admin.texts`) holds every piece of
user-facing copy — the consent notice, the Accept/Decline/OK button labels, the
purpose and service headings, the "learn more" link text, and the contextual
consent wording. Keeping the text apart from the behavior means translators (and
the core Configuration Translation module, which Klaro supports) can localize the
banner without touching how it works. This copy lives in `klaro.texts`.

## Services and Purposes

- A **Purpose** (`klaro_purpose`) is a category of consent — for example
  *analytics*, *advertising*, *external content*, *security*, *styling*, or
  *livechat*. Visitors can accept or decline each purpose.
- A **Service** (`klaro_app`) is a single script or integration that belongs to a
  purpose — for example Matomo, Google Analytics, Google Tag Manager, YouTube,
  Vimeo, Google Maps, Leaflet, Facebook, X, LinkedIn, Instagram, or Stripe.

Klaro ships predefined services and purposes for all of the above. Enable the ones
your site actually uses and they appear in the banner immediately; add your own by
creating a new `klaro_app` entity and pointing it at the right purpose. Each
service can carry a description and an info/privacy-policy URL, and you can set a
default opt-in or opt-out state per service. Mark a purpose as required (for
example an "essential/security" purpose) when it must not be declinable.

## Permissions

Grant these at **People → Permissions** (`/admin/people/permissions`):

| Permission | Machine name | What it allows |
|-----------|--------------|----------------|
| **Administer Klaro!** | `administer klaro` | Access to all Klaro settings, the text form, and the Services/Purposes collections. This is a restricted permission — give it to trusted administrators only. |
| **Use Klaro! UI** | `use klaro` | Lets a user re-open the Klaro consent manager to change their preferences. Safe to grant broadly (authenticated and anonymous) so visitors can revisit their choices from a "Cookie settings" trigger. |

## Google Consent Mode recipe

The module bundles a **Google Consent Mode** recipe (in its `recipes/` folder).
Apply it if you need Klaro's consent decisions to feed Google's consent-mode
signals — it wires the two together for you rather than requiring manual setup.

## Save and export

Save each form after editing. Because all of this is standard Drupal
configuration, run `drush config:export` to capture your consent setup and deploy
the exact same banner, services, and purposes to another environment.
