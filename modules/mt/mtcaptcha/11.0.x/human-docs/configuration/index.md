# Configuration

Configuring MTCaptcha is a matter of entering the two keys from your MTCaptcha
account and then choosing which forms should show the challenge. The keys are the
sensitive part, so this page also covers storing the private key safely.

## Get your keys first

Log in to your MTCaptcha account and register your website's domain. MTCaptcha
gives you two values:

- a **site key** (public — it is rendered into the page so the widget can load), and
- a **private key** (secret — used only server‑side to verify challenge responses).

## Open the settings form

1. Log in as a user with the permission to **administer MTCaptcha** (an
   administrator by default).
2. Go to the MTCaptcha settings form (route `mtcaptcha.settings`) via the module's
   *Configure* link on the **Extend** page.

## The fields

- **Site key** — paste your MTCaptcha public site key here. This is safe to store
  in configuration; it appears in the page markup.
- **Private key** — paste your MTCaptcha private key. This is a **secret**; see
  "Storing the private key safely" below.
- **Form protection** — tick the forms you want MTCaptcha to guard. Typical
  choices are the **login**, **registration**, **password‑reset**, **contact**, and
  **comment** forms. You can also enable it on other/custom forms as offered.
- **Theme / skin** — choose one of the built‑in MTCaptcha appearances (Standard,
  Overcast, Neowhite, Goldbezel, Blackmoon, Darkruby, Touchoforange, Caribbean,
  Woodyallen, Chrome, Highcontrast) to match your site. Full custom styling and
  custom languages are not exposed in the Drupal form.

Click **Save configuration** when done.

## Exempting trusted roles

The module provides a permission so that trusted roles are not challenged. On
**People → Permissions** (`/admin/people/permissions`), grant the "skip / bypass
MTCaptcha" permission to roles (for example administrators or editors) that should
never see the challenge. Keep the *administer* permission restricted to
administrators.

## Storing the private key safely

The private key is a credential — never commit it to version control or paste it
into a config export that lands in Git.

- **With DDEV**, store it as an environment variable rather than in plain config:

  ```bash
  ddev dotenv set .ddev/.env --mtcaptcha-private-key=<your-private-key>
  ddev restart
  ```

  (Keep `.ddev/.env` out of version control.) This puts the value in the
  container as `MTCAPTCHA_PRIVATE_KEY`.

- Confirm it is present **without printing it**:

  ```bash
  ddev exec 'test -n "$MTCAPTCHA_PRIVATE_KEY" && echo set'
  ```

- Where the module or your site supports referencing a **Key** entity or an
  environment variable for the private key, prefer that over pasting the raw value
  into the settings form. If you must enter it directly in the form, ensure your
  configuration is not exported to a public repository.

## Verify it worked

Log out (or use a private browser window) and open one of the forms you protected —
for example the user login or contact form. The MTCaptcha widget should appear, and
the form should refuse to submit until the challenge is satisfied.
