# Configuration

Beautify is configured on its settings form (**`beautify.settings_form`**), at
**Configuration → Development → Beautifier**
(`/admin/config/development/beautifier`).

## Open the settings form

1. Log in as a user who holds the beautifier permission. Note the upstream typo —
   the permission is literally named **`admninister beautifiers`** — grant it
   under **People → Permissions**.
2. Go to **Configuration → Development → Beautifier**.

## Choose the beautifier

The form lets you select the **active beautifier** and set its per-plugin options.
Two plugins ship with the module:

- **HTMLBeautify** — a pure-PHP formatter. No extra software required; a good
  default.
- **Tidy** — uses PHP's `tidy` extension for the reformatting. Only pick this if
  the `tidy` extension is installed on the server (see
  [Installation](../installation/index.md)); otherwise it cannot run.

Select one, adjust its options as offered, and save. From then on the chosen
plugin reformats the HTML of every matched response.

## A note on production

Because the beautifier runs on every matched response, it adds a little processing
to each page. That is negligible in development but worth weighing on a
high-traffic production site, where the benefit — cleaner page source — is mostly
cosmetic. You can turn the effect off entirely by disabling the module.

## Adding your own beautifier

Developers can add a custom formatter by implementing the module's `Beautifier`
plugin type; the new plugin then appears as a choice on this form. See the
[`agent/`](../agent/start.md) docs for the interface and annotation details.
