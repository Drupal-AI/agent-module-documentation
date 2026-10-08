# Configuration

The settings form is where you connect to Jira, decide which updates create
tickets, and choose whether the reporter runs automatically.

## Open the settings form

1. Log in as a user with the **administrator** role and the **access Jira Drupal
   Updates Reporter configurations** permission.
2. Go to `/jira-updates-reporter/config`.

## The fields

- **Jira base URL** (`jira_url`) — your Jira address, e.g.
  `https://your-domain.atlassian.net`.
- **Jira username** (`jira_username`) — the account used for authentication (HTTP
  Basic auth together with the token below).
- **Jira API token** (`jira_token`) — the API token paired with the username. See
  the security note below — this value is sensitive.
- **Project key** (`project_key`) — the key of the Jira project that should receive
  the tickets.
- **Release issue type** (`issuetype_name_release`) — the Jira issue‑type name used
  for ordinary release‑update tickets (prefixed `RELEASE`).
- **Security issue type** (`issuetype_name_security`) — the Jira issue‑type name
  used for security‑update tickets (prefixed `SECURITY`).
- **Security updates only** (`security_only`) — when checked, only security updates
  create tickets; release‑only updates are ignored.
- **Check for updates on cron** (`check_on_cron`) — when checked, the reporter runs
  automatically on each Drupal cron; leave it off if you'd rather run it manually.
- **Last check** (`last_check`) — a read‑only timestamp showing when the reporter
  last ran.

## Running it

Click **Save and update** to save your settings and run the reporter immediately.
It refreshes the update data and, for every project that's behind, opens a Jira
issue — unless a matching issue already exists, in which case it's skipped so you
don't accumulate duplicates. If you enabled **Check for updates on cron**, the same
run happens automatically on each cron.

## Keeping the Jira token secret

The Jira API token is stored in this module's configuration and shown in a plain
text field, which means **it will be present in any configuration export** — treat
those exports as sensitive and keep them out of public version control.

If you run **DDEV**, keep the token out of shared config by storing it in an
environment variable:

```bash
ddev dotenv set .ddev/.env --jira-api-token=<your-token>
ddev restart
```

That exposes it inside the container as `JIRA_API_TOKEN` (never commit
`.ddev/.env`). Limit who holds the administrator role and the reporter's
configuration permission, and rotate the token if an export is ever exposed.

## Outbound network access (egress)

The reporter makes **outbound HTTPS requests to your Jira instance** (over cURL,
with TLS certificate verification left at its secure default). If your site runs
behind an egress firewall, allow outbound access to your Jira host, otherwise
ticket creation will fail.
