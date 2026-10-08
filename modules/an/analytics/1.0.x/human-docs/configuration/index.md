# Configuration

There are two things to configure: the **services** you want to run (one per
vendor/tag), and the **shared privacy settings** that apply to all of them. Both
are under **Configuration → Services → Analytics** and require the *Administer
analytics* permission.

## Step 1 — Add a service

1. Go to **Configuration → Services → Analytics**
   (`/admin/config/services/analytics`). This lists your configured services.
2. Add a service and give it a **label** and machine name.
3. Choose a **Service** — the vendor plugin to use (for example *Google Tag
   Manager*). The list depends on which submodules you've enabled. Note the service
   type can't be changed after the service is created.
4. The plugin's own settings appear below (loaded via AJAX when you pick the
   service). Fill them in. What you'll see depends on the vendor:

   - **Google Tag Manager** — a container ID, an optional JSON **data layer**
     (name + value), and an optional **Google Optimize anti‑flicker** snippet.
   - **Google Optimize** — a container ID, plus async and anti‑flicker options.
   - **Google Analytics** (from `analytics_google`) — a tracking ID.
   - **AMP analytics / AMP tracking pixel** (from `analytics_amp`) — the AMP
     analytics type and config URL/JSON, or a pixel URL.
   - **Piwik/Matomo** (from `analytics_piwik`) — the Matomo URL and site ID.

5. Save the service.

Some plugins allow **multiple** instances (for example two GTM containers) — if
so, you can add the same service type more than once.

### Enabling and disabling services

Each service in the list can be **enabled or disabled** without deleting its
configuration, so you can switch a tag off temporarily and keep its settings. Only
enabled services emit anything.

## Step 2 — Shared privacy and behaviour settings

Go to **Configuration → Services → Analytics → Settings**
(`/admin/config/services/analytics/settings`). These apply to every service:

- **Do Not Track (`dnt`)** *(on by default)* — when on, each tracking snippet is
  wrapped in a `navigator.doNotTrack` guard and a small Do Not Track JavaScript
  library is attached, so visitors who have DNT enabled in their browser aren't
  tracked.
- **Anonymize IP** *(off by default)* — requests IP anonymization from services
  that support it.
- **Cache URLs** *(off by default)* — controls URL cache behaviour for the
  snippets.
- **Disable page build** *(off by default)* — a global kill switch. When on, **no**
  analytics output is emitted at all, regardless of which services are enabled.
  Handy for staging environments where you don't want live tags firing.

Save the settings.

## How tracking is applied

At the bottom of each page, the module renders every **enabled** service whose
"can track" check passes. That check automatically:

- **skips admin routes** (so you're not tracked while administering the site), and
- **skips users with the *bypass all analytics services* permission** (so, for
  example, staff visits aren't counted).

## Permissions

Grant these on **People → Permissions**:

- **Administer analytics** — access to the entire Analytics admin UI: adding,
  editing, deleting, enabling, and disabling services, plus the shared settings
  form. Because the snippets an admin authors are JavaScript injected on every
  front‑end page, grant this only to **trusted administrators**.
- **Bypass all analytics services** — a simple "opt me out" capability: holders
  are excluded from all tracking output. It grants no administrative power — use it
  for staff or roles whose visits shouldn't be tracked.

## For developers

Analytics services are plugins, so you can build your own to emit a custom tag, and
there are alter hooks to adjust tracking access and inject data‑layer values. See
the [`agent/`](../agent/start.md) docs (`plugins/analytics-service.md`) for the
plugin interface and hook list.
