# Configuration

To take donations you need to give the module your PayU credentials and place the
donation block.

## PayU credentials

The module needs the merchant credentials from your PayU account:

- **Environment** — production or sandbox. Use sandbox while testing.
- **Point-of-sale ID (pos_id)** — your PayU POS identifier.
- **Second / MD5 signature key** — used when talking to PayU.
- **OpenPayU signature key** — the key the module uses to **verify the signature**
  on PayU's payment notifications. This is what makes forged notifications
  impossible, so it must match your PayU configuration exactly.
- **Currency** and any donation-presentation options.

## Store the keys as secrets

The PayU signature keys are live credential material and should be **env-backed**
rather than committed to your repository. Store each value in an environment
variable — for example with DDEV:

```bash
ddev dotenv set .ddev/.env --payu-signature-key=<value>
ddev restart
```

(Keep `.ddev/.env` out of version control.) Review your configuration export
before committing to make sure real keys are not written into exported config.

## Place the donation block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** next to the region where you want the donation form.
3. Choose the **PayU donation block**, configure its options, and save.

Visitors will then see an amount field and a donate button; on submit they are
redirected to PayU to complete payment.

## How confirmation works

You do not configure the confirmation flow — it is automatic. When PayU has taken
the payment it calls the module's **notify** endpoint, and the module verifies the
**OpenPayU signature** on that call before recording the donation as complete. The
redirect the donor's browser follows afterward only manages the on-screen
experience (via session data); it is never the source of truth for whether the
payment succeeded. Because of this, an attacker cannot fake a completed donation by
crafting a return URL.

## Test before going live

With the **sandbox** environment selected, run a full test donation and confirm it
is recorded only after PayU's signed notification arrives. Switch to production
credentials once the sandbox flow works.
