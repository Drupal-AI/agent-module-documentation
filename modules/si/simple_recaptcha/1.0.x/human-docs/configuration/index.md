# Configuration

## Step 1 — get your Google reCAPTCHA keys

Go to Google's reCAPTCHA admin console
(<https://www.google.com/recaptcha/admin>) and register your site. Choose the
reCAPTCHA type you want — **v2 ("I'm not a robot" checkbox)** or **v3
(invisible, score‑based)** — and Google gives you a **site key** and a **secret
key** for that type. Without valid keys the widget will render but verification
can never succeed.

## Step 2 — open the settings form

Go to **Configuration → Web services → Simple reCAPTCHA**
(`/admin/config/services/simple_recaptcha`). You need the **Administer
simple_recaptcha** permission. The form holds every option:

- **reCAPTCHA type** — **v2** (checkbox) or **v3** (invisible). This choice
  applies site‑wide.
- **v2 site key** and **v2 secret key** — used when the type is v2.
- **v3 site key** and **v3 secret key** — used when the type is v3. You can store
  both key pairs and switch type without re‑entering them.
- **v3 score threshold** (`v3_score`, default **80**, range 0–100) — the minimum
  score a request must reach to be accepted. Higher is stricter. Only relevant to
  v3.
- **Form IDs** — a **comma‑separated list** of the form IDs to protect. Wildcards
  are supported, so `contact_message_*` covers every contact form. The default is
  `user_pass, user_register_form`. Common additions are `user_login_form`,
  comment forms, and your own module's forms.
- **Use globally** — when ticked, reCAPTCHA is added to **every** form on the
  site and the Form IDs list is ignored. Use with care.
- **Hide the v3 badge** — hides Google's floating v3 badge. If you use this, you
  must still display the required reCAPTCHA attribution somewhere on the page.

Click **Save configuration**, then rebuild caches (`drush cr`) if a form still
shows a stale widget.

### Finding a form's ID

The module attaches to forms by their **form ID**. To find one, you can inspect
the form's `<form>` element (its `id` attribute reflects the form ID with dashes)
or use a module like Devel. Then add that ID to the Form IDs list.

## Step 3 — the permissions

Manage these at **People → Permissions**:

- **Administer simple_recaptcha** — grants access to the settings form above.
- **Bypass simple_recaptcha** — any user with this permission **skips** reCAPTCHA
  on every form. Grant it to trusted roles (for example editors or admins) so
  they aren't challenged. Anonymous users should normally *not* have it.

For per‑form exceptions in code, developers can implement
`hook_simple_recaptcha_bypass_alter()` — see the
[`agent/api/api.md`](../../agent/api/api.md) reference.

## Protecting individual webforms

If you enabled the **Simple reCAPTCHA Webform** submodule, you can instead add
reCAPTCHA to a specific webform through its **Handlers** — add the reCAPTCHA
handler on that webform rather than listing its form ID here. This is the neatest
way to protect selected webforms.
