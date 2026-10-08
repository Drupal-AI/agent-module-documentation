# Configuration

Configuration is a matter of giving the module a **Personal Access Token (PAT)**
so it can read the Jelastic Platform API, and then choosing which environment to
display.

## Open the settings form

1. Log in as a user with the **Administer Jelastic info** permission (`administer
   jelastic info`).
2. Open the Jelastic Info settings form, reachable from the **Jelastic
   environment** report at **Reports → Jelastic environment** (`/admin/reports`).

## The fields

- **Personal Access Token** — a token you generate in your Jelastic dashboard
  (read‑only scope is sufficient). The field is password‑typed and offers a "leave
  blank to keep current" experience, so the live token is never echoed back into
  the page HTML. The module authenticates with this token only — it never stores a
  Jelastic email or password.
- **Environment** — a dropdown populated from the API once a valid token is saved,
  so you pick the environment to monitor from a real list rather than typing a
  name.
- **Test connection** — a button that checks the token and connectivity and
  reports any misconfiguration inline, so you can confirm the setup before relying
  on it.

Enter the token, save, choose your environment, and use **Test connection** to
confirm everything is wired up.

## Keeping the token secret (recommended)

A Personal Access Token is a credential — treat it like a password and keep it out
of version control and out of exported configuration where you can.

If you run **DDEV**, store the token in an environment variable rather than typing
it into a shared config export:

```bash
ddev dotenv set .ddev/.env --jelastic-pat=<your-token>
ddev restart
```

That makes the value available inside the container as `JELASTIC_PAT` (never
commit `.ddev/.env`). You can then paste it into the settings form when
configuring the site, and rotate it by updating the variable. Because the token
grants read access to your hosting environment's API, limit who holds the
**Administer Jelastic info** permission and who can read your configuration
exports.

## Outbound network access (egress)

This module makes **outbound HTTPS requests to the Jelastic / Virtuozzo Platform
API**. If your site runs behind an egress firewall or in a locked‑down
environment, allow outbound access to your Jelastic provider's API host, otherwise
the dashboard and the "Test connection" button will fail to reach the platform.
