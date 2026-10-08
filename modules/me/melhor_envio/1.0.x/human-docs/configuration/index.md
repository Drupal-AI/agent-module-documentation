# Configuration

Melhor Envio is configured as a **Commerce shipping method**, so its settings live
on a shipping‑method entity rather than on a separate module page. You add a shipping
method that uses the Melhor Envio plugin and give it your Melhor Envio API
credentials.

## Get your Melhor Envio credentials

From your Melhor Envio account, obtain an **API access token** (and note whether you
are pointing at the **sandbox** or **production** environment). Treat this token as a
secret — it can request rates and act against your Melhor Envio account.

## Add the shipping method

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Shipping → Shipping methods**
   (`/admin/commerce/shipping-methods`) and click **Add shipping method**.
3. Give it a **name** (for example "Melhor Envio"), choose the store(s) it applies
   to, and select **Melhor Envio** as the plugin.
4. Enter the plugin settings:

   - the **Melhor Envio API token** (your access credential),
   - the **environment** (sandbox vs production) if offered, and
   - any origin/package defaults the plugin exposes (such as the sender postcode) so
     the API can calculate rates correctly.

5. Save the shipping method.

## Handling the API token safely

The API token is an account‑level secret. Keep it out of code and out of
version‑controlled configuration:

- With DDEV, store the token in an environment variable rather than in exported
  config:

  ```bash
  ddev dotenv set .ddev/.env --melhor-envio-token=<your-token>
  ddev restart
  ```

  Keep `.ddev/.env` out of version control. You can confirm the variable is present
  without printing it:

  ```bash
  ddev exec 'test -n "$MELHOR_ENVIO_TOKEN"'   # exit status 0 means it is set
  ```

- If the module stores the token in configuration, avoid committing that config to a
  public repository; override the sensitive value per‑environment in `settings.php`
  with `getenv('MELHOR_ENVIO_TOKEN')`, or use the **Key** module if the field
  supports selecting a Key.

## Test the rates

Add a shippable product to the cart and proceed to checkout with a Brazilian
delivery address. You should see Melhor Envio rate options (Correios and other
carriers) returned from the API. Use the **sandbox** environment while testing so you
are not making live calls, then switch to production when ready.

## Network note

Rate calculation makes **server‑side HTTPS requests** from Drupal to the Melhor Envio
API on each quote. Ensure your Drupal server has outbound network access to Melhor
Envio, and prefer the production endpoint only once sandbox testing succeeds.
