# acquia_connector — agent start

Connects a Drupal site to an Acquia Cloud subscription: authenticates to Acquia
network services, exposes a JSON status endpoint for uptime monitoring, and sends
anonymized telemetry. Package **Acquia**; no hard module dependencies. Config UI:
**Admin → Config → Services → Acquia Connector**
(`/admin/config/services/acquia-connector`); settings route `acquia_connector.settings`.

- Connect to a subscription (OAuth / manual creds), settings keys, where creds come from → [configure/acquia_connector.md](configure/acquia_connector.md)
- Subscription service, status endpoint, telemetry, events (programmatic API) → [api/acquia_connector.md](api/acquia_connector.md)
- Permissions → [permissions/acquia_connector.md](permissions/acquia_connector.md)
