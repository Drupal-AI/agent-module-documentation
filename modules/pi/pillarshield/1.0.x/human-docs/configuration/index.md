# Configuration

Configuration follows the order in the module's own post‑installation checklist:
store the API key securely, test the connection, choose what to evaluate, then
tune enforcement and permissions. You'll need the **Administer site
configuration** permission.

## 1. Store your PillarShield API key securely

The API key is a secret and should be stored with the **Key** module, not typed
directly into configuration or committed to code. On this project the recommended
pattern is an environment variable exposed through an env‑backed Key entity:

1. Save the secret into DDEV's dotenv file (the flag name becomes the variable
   name), then restart so DDEV loads it:

   ```bash
   ddev dotenv set .ddev/.env --pillarshield-api-key=<value>
   ddev restart
   ```

   Keep `.ddev/.env` out of version control.

2. Confirm the variable is present in the container **without printing its value**:

   ```bash
   ddev exec 'test -n "$PILLARSHIELD_API_KEY"'   # exit status 0 means it is set
   ```

3. Create an env‑backed Key (the Key module is already enabled as a dependency):

   ```bash
   ddev drush key:save pillarshield_api_key --label='PillarShield API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"PILLARSHIELD_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

4. On the PillarShield settings form, select that Key as the API credential.

## 2. Test the connection

Go to **Configuration → Content authoring → PillarShield**
(`/admin/config/content/pillarshield`) and use the **test connection** control to
confirm Drupal can reach the PillarShield service with your key before you turn on
enforcement.

## 3. Choose what gets evaluated

On the settings form, select which **content types and fields** should be sent to
PillarShield for evaluation. Review this carefully — it determines exactly what
site data leaves your server for the SaaS. Use the **whitelisting** option to
exclude content that doesn't need checking and reduce unnecessary calls.

## 4. Configure enforcement (the "Gate")

Decide how decisions are enforced:

- **Gate enforcement** blocks content only at the **publish / visibility
  boundary** — draft saves are not blocked by default. If you use core Content
  Moderation, you can tie the gate to moderation‑state transitions.
- The permission‑gated **manual "Check PillarShield Governance"** action lets
  authorised users run a check on any save that records the decision **without**
  blocking.
- Optional **overrides** let authorised users proceed past a block; overrides are
  fully audit‑logged.

Grant the corresponding permissions at **People → Permissions** only to the roles
that should perform manual checks or overrides.

## 5. Review decisions

Blocked publish attempts and returned decisions are listed in the report at
**Reports → PillarShield** (`/admin/reports/pillarshield`). Check it periodically
to see what PillarShield has allowed, warned on, or blocked.

## Save

Click **Save configuration** when done. Because this module is in early
development, re‑check the settings after module updates in case new options appear.
