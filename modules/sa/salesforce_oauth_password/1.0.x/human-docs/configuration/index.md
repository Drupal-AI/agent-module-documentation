# Configuration

This module has no settings form of its own — it adds a provider type to the
Salesforce Suite's authorization screen, and you configure it there.

## Add the auth provider

1. Make sure the module is enabled (at **Administration → Extend**, or via Drush).
2. Go to **Configuration → Salesforce → Salesforce Authorization**.
3. Add a new authorization provider and choose the **Salesforce OAuth Password**
   provider type (supplied by this module).
4. Enter the credentials the username-password flow needs:
   - the Salesforce **username**;
   - the **password** with the user's **security token** appended;
   - the connected app's **consumer key** and **consumer secret**;
   - plus any other connection details the Salesforce Suite asks for (such as the
     login URL for your org or sandbox).
5. Save. The Salesforce Suite will use this provider to obtain and refresh access
   tokens for its API calls.

## Handle the credentials securely — and prefer a safer flow

This is the sensitive part. Because the flow stores and reuses a Salesforce user's
password, keep **all** of the values above — username, password, security token,
consumer key and consumer secret — out of exported configuration and out of version
control. Source them from environment variables or a Key entity, and always operate
over HTTPS.

Use a **dedicated integration user** with the **least privilege** the integration
needs, never a real administrator account. And bear in mind the flow is **less
secure and is being deprecated by Salesforce** — if the JWT bearer or
client-credentials flows are available to you, prefer one of those instead.
