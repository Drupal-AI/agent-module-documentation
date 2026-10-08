# Configuration

Push Framework Alerta is configured as a **channel** inside the Push Framework, so
there is no standalone settings page of its own. Configuration has two parts:
telling the channel how to reach your **Alerta** instance, and **enabling** the
channel in the Push Framework so notifications are routed through it.

## 1. Configure the Alerta channel

1. Log in as an administrator and open the Push Framework configuration under
   **Configuration → System → Push framework**.
2. Find the **Alerta** channel among the available channels and open its settings.
3. Provide your Alerta connection details:
   - the **URL / API endpoint** of your Alerta instance (use **HTTPS**), and
   - any **API key or credentials** your Alerta instance requires to accept
     alerts.
4. Save.

The exact field labels come from the Push Framework's channel UI; the essentials
are always your Alerta endpoint and its authentication.

## 2. Enable the channel

In the Push Framework, make sure the **Alerta** channel is **enabled** so that
Push Framework campaigns and notifications are delivered through it. From here on,
notifications routed to this channel land in your Alerta dashboard, where Alerta's
deduplication keeps repeated alerts tidy.

## 3. Optional — push log entries via DANSE Log

If you want operational log noise surfaced in Alerta automatically:

1. Enable **DANSE** and its **DANSE Log** submodule.
2. Configure DANSE Log to forward log entries above your chosen **error
   threshold**.

With that in place, qualifying log entries are pushed to Alerta through this
channel, giving your ops team a single deduplicated view of site errors.

## Keep credentials secret

If your Alerta instance uses an API key or other credentials, treat them as
**secrets**:

- Prefer supplying the value from an **environment variable** (with DDEV, e.g.
  `ddev dotenv set .ddev/.env --alerta-api-key=<value>`, keeping `.ddev/.env` out
  of version control), or store it via the **Key** module where supported, rather
  than committing it in exported configuration.
- Always connect to Alerta over **HTTPS**.
