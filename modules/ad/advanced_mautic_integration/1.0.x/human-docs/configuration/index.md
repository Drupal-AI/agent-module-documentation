# Configuration

Advanced Mautic Integration is configured on its own settings, where you point
Drupal at your Mautic instance and choose how tracking behaves.

## Who can configure it

The module provides its own permission. Grant it on **People → Permissions**
(`/admin/people/permissions`) to the administrators who should manage the Mautic
connection, then configure the settings as one of those users.

## Mautic endpoint and credentials

- **Base URL / endpoint** — the address of your Mautic instance. Always use the
  **HTTPS** endpoint so tracking and API traffic are encrypted.
- **Credentials** — where the module talks to the Mautic API, it needs API
  credentials. **Treat these as secrets.** Store the values in environment
  variables (and reference them through a Key entity where the field supports it),
  and keep them out of committed configuration and config exports. On this
  project, use DDEV's dotenv command to set the variable and a Key entity to
  consume it — see the repository's secrets guidance.

## Tracking

Enable the Mautic **tracking script** so page activity is recorded against Mautic
contacts, and configure any contact / token data you want passed through (the
Token dependency is what lets you map Drupal values into the data sent to Mautic).

## Privacy and consent

Turning on tracking means setting cookies and sending visitor activity to Mautic,
which carries GDPR / ePrivacy obligations. **Pair the tracking with your
cookie-consent tool** so the script only fires once the visitor has consented, and
make sure your privacy policy reflects the Mautic integration.
