# Configuration

OnePass is configured on a single settings form where you connect Drupal to your
1Pass account and choose whether the integration should also enforce a paywall.
The one thing to be careful with is the **secret key** — treat it as a credential,
not as a setting to be committed to code.

## Open the settings form

1. Log in as a user with permission to administer the site's configuration.
2. Go to **Configuration → Content authoring → OnePass**, or navigate directly to
   `/admin/config/content/onepass`.

## Connect your 1Pass account

- **Publishable key** — your 1Pass publishable (public) key. This is the key that
  is safe to expose in the button embed code that renders on the page.
- **Secret key** — your 1Pass secret key, used for server‑to‑server
  communication with 1Pass. This is a **secret**: anyone who has it can act
  against your 1Pass account, so it must not be committed to version control or
  exported into `config/sync`.

### Store the secret key securely

Rather than typing the secret key straight into exported configuration, keep it in
an environment variable and reference it from Drupal. With DDEV:

```bash
ddev dotenv set .ddev/.env --onepass-secret-key=<your-secret-key>
ddev restart
```

That exposes the value inside the container as `ONEPASS_SECRET_KEY` (and keeps
`.ddev/.env` out of Git). You can confirm it is present without printing it:

```bash
ddev exec 'test -n "$ONEPASS_SECRET_KEY"'   # exit status 0 means it is set
```

Then reference the environment variable from `settings.php` (via
`getenv('ONEPASS_SECRET_KEY')`) or a Key entity, so the secret never lands in
exported configuration. The publishable key, being public by design, is less
sensitive but is still cleanest kept alongside the secret.

## Choose the environment

- **Dev API host** — enable this while you are fine‑tuning your integration on a
  staging server, so OnePass talks to the **1Pass test server** instead of the
  live one. Turn it off in production so real transactions go to the live 1Pass
  service.

## Turn on the paywall (optional)

If you want to use 1Pass to control access to content that is currently free:

- **1Pass paywall** — enable this checkbox on the settings form to switch on the
  access‑control behavior. You then also enable 1Pass on each content type, and on
  each individual node tick its 1Pass checkbox and insert the `[1pass]` shortcode
  in the body. The post is truncated at the shortcode and the 1Pass button is
  injected there, so readers must pay through 1Pass to see the rest.

Leave the paywall off if you already restrict content another way and only want
1Pass for single‑article sales on otherwise‑visible posts.

## Save

Save the form. With the keys in place and the correct environment selected, the
1Pass button embed and the `onepass_atoms` feed become active; verify by viewing a
1Pass‑enabled node and confirming the button renders where you placed the
shortcode.
