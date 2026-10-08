<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Legal — configuration

## Routes & permissions

| Route | Path | Purpose |
|---|---|---|
| `legal.config_legal` | `/admin/config/people/legal` | Enter / save the T&C text (configure route) |
| `legal.config_settings` | `/admin/config/people/legal/settings` | Display & behaviour settings |
| `legal.config_language` | `/admin/config/people/legal/languages` | Per-language options (multilingual) |
| `legal.legal` | `/legal` | Public page rendering current terms (perm `view Terms and Conditions`) |
| `legal.legal_login` | `/legal_accept` | Post-login acceptance form |

T&C history/acceptance reports are the Views `view.legal_terms.page_1` (T&C History) and
`view.legal_users.page_1` (Accepted). Admin permission: `administer Terms and Conditions`.

## Entering Terms & Conditions

At `/admin/config/people/legal` (form `LegalAdminTermsForm`) you enter the terms text and
choose a display style. **Each save creates a new version/revision** in the `legal_conditions`
table (see [../api/terms.md](../api/terms.md)) — publishing new terms forces all users to
re-accept. Optional per-version fields: up to 10 **extra checkboxes** (each becomes its own
required tick, e.g. "I am 18+"), and a **changes** explanation shown to returning users.

## Behaviour settings — `legal.settings`

Config object `legal.settings` (shipped defaults shown):

```yaml
registration_terms_style: 0    # T&C display style on REGISTRATION (see table below)
registration_container: 1      # wrap terms in a collapsible <details> (1) or not (0)
login_terms_style: 0           # display style on LOGIN / profile
login_container: 1
user_profile_display: true     # show T&Cs on the user profile edit page
accept_every_login: false      # require acceptance on EVERY login, not just new versions
except_roles: []               # role IDs exempt from the T&C requirement
registration_modal_terms: true # when style=3 (Page link), open terms in a modal dialog
login_modal_terms: true
login_redirect_url: ''          # where to send the user after accepting on login
```

**Display style values** (`registration_terms_style` / `login_terms_style`):

| Value | Style |
|---|---|
| `0` | Scroll box (plain text, read-only) |
| `1` | Scroll box (CSS) — attaches the `legal/css-scroll` library |
| `2` | HTML text (rendered inline) |
| `3` | Page link — the Accept label links to the terms (optionally a modal) |

## Setting behaviour with Drush

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("legal.settings");
  $c->set("accept_every_login", TRUE);
  $c->set("registration_terms_style", 2);   // HTML text
  $c->set("except_roles", ["administrator"]);
  $c->save();
'
```

User 1 and masquerading users are always exempt regardless of settings.
