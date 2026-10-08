# Configuration

BulkGate SMS is configured as a gateway inside the SMS Framework UI. There is no
separate settings page for the module itself.

## Add the BulkGate gateway

1. Make sure the **SMS Framework** (`sms`) module is enabled.
2. Go to **Configuration → SMS Framework → Gateways**
   (`/admin/config/smsframework/gateways`) and choose **Add gateway**.
3. Select the **BulkGate** plugin.

## Enter your credentials

On the gateway form, enter the two values from your BulkGate portal:

- **Application ID** (`app_id`)
- **Application token** (`app_token`)

Save the form. If the credentials are valid, the gateway form displays your
account's **wallet, credit, currency, and free-message balance** (BulkGate SMS
fetches this from BulkGate's `simple/info` endpoint). If instead you see a
"Can't connect…" style warning, re-check the Application ID and token.

### How the credentials are stored — and how to protect them

Be aware of how this module handles your secrets, so you can protect them:

- The Application ID and token are stored in the SMS gateway **configuration
  entity as plain text** (this is the standard behavior for SMS Framework
  gateways). That means they can end up in exported configuration. **Keep gateway
  config out of any version-controlled or publicly shared config exports**, and
  treat the exported YAML as a secret if it contains these values.
- The credit-balance check sends the Application token as part of the request URL
  (a query-string parameter on a GET request). That can cause the token to appear
  in HTTP client, proxy, or server logs. If you keep such logs, be mindful they
  may contain the token.
- API traffic uses **HTTPS with normal TLS certificate verification** (there is no
  insecure "skip verification" setting), so the connection to BulkGate is
  encrypted.

> Because this module reads credentials from the gateway config entity rather than
> from an environment variable, there is no built-in way to point it at a secret
> stored via DDEV `ddev dotenv set` or a Key entity. Protect the values by
> restricting who can administer SMS gateways and by excluding the gateway config
> from committed exports.

## Optional: sender name

By default messages use your BulkGate system sender number (leave the **Sender
type** set to None). To send from a text sender name instead, set **Sender type**
to Text sender and enter a **Sender name** of **3–11 non-diacritic characters**.

## Choose when the gateway is used

Finally, tell SMS Framework to use this gateway — either set it as the **default**
gateway or bind it to specific phone numbers via SMS Framework's routing. Sending
behavior: each message goes to a single recipient
(`outgoing_message_max_recipients = 1`), and BulkGate's responses are mapped to
SMS Framework delivery statuses (for example, an HTTP 400 becomes "invalid
recipient" and a 401 becomes "account error").
