# Configuration

Configuring Assist For WCAG comes down to giving it the **token** that
authenticates the accessibility widget's script for your account. Because that
token is a credential, keep it out of committed configuration.

## Open the settings

1. Log in as a user with the permission the module provides (an administrator by
   default). Grant it under **People → Permissions**
   (`/admin/people/permissions`) to trusted administrators only, since the setting
   controls a script embedded on every page.
2. Open the module's settings form from the administration area and enter the
   **widget token** supplied by your accessibility‑widget provider.

Save the form. Once the token is in place, the module injects the provider's
script and the accessibility widget appears for visitors.

## Handle the token as a secret

Do not hard‑code the token into a config file or commit it to Git. Keep it in an
environment variable. With DDEV:

```bash
ddev dotenv set .ddev/.env --assist-wcag-token=<your-token>
ddev restart
```

The flag `--assist-wcag-token` becomes the variable `ASSIST_WCAG_TOKEN` inside the
web container. Do **not** commit `.ddev/.env`. Confirm the variable is set without
printing its value:

```bash
ddev exec 'test -n "$ASSIST_WCAG_TOKEN"'   # exit status 0 means it is set
```

Where the module or your site setup allows it, reference the environment variable
(for example through a **Key** entity using the `env` provider, or via `getenv()`
in `settings.php`) rather than pasting the raw token into the form.

## Things to weigh

- **It's a third‑party overlay.** The widget loads external code onto your pages
  and has its own privacy and effectiveness considerations. Review the provider's
  data handling before enabling it site‑wide.
- **It's not a substitute for accessible markup.** An overlay does not fix
  underlying accessibility problems; keep doing the real work of accessible
  content, structure, and themes.

## Verify it worked

Load a page as a normal visitor and confirm the accessibility widget appears and
its controls (font size, contrast, and so on) work as expected.
