# Configuration

Setting up OAuth2 Client is a short sequence: teach Simple OAuth which scopes
exist, define a **client request type** that people can request against, hand the
generated permissions to the right roles, and then use the moderation page to
approve or reject requests. Each approved request becomes a real OAuth2 client
(consumer) managed by Simple OAuth.

## 1. Define OAuth2 scopes in Simple OAuth

Scopes describe what an issued token is allowed to do. They live in Simple OAuth,
not in this module. Create the scopes you want to offer there first, so they are
available when you build a request type. Consult the Simple OAuth documentation
for the exact screen in your version.

## 2. Create a Client Request Type

A request type is the template users request against — it decides which scopes and
which OAuth2 grants an approved client may use. When you create a request type and
select its allowed scopes and grants, the module **automatically generates a set of
permissions** tied to that type. (In this release the practical grant is
**client_credentials**; the interactive **authorization_code** login grant is not
yet enabled.)

## 3. Assign the generated permissions

Go to **People → Permissions** and grant the permissions that were generated for
your request type to the roles that should be allowed to request clients of that
type. Without these permissions, users will not see the request option on their
account.

## 4. Requesting and moderating clients

- **Users** request a client from the **OAuth2 client requests** tab on their
  account settings, choosing a request type they are permitted to use.
- **Privileged users** review incoming requests at **Configuration → Web services
  → Consumer → OAuth Client Request**
  (`/admin/config/services/consumer/oauth-client-request`), where they can
  **approve or reject** each one.
- On approval, a new OAuth2 client is created automatically and from then on is
  managed through Simple OAuth. Users can subsequently manage their approved
  clients — **rename**, **rotate the secret**, or **delete** them.

## Handling credentials and tokens securely

Every OAuth2 client has a **client id** and a **client secret**, and using it
produces **access tokens**. All of these are sensitive:

- Treat the **client secret** as a secret. If your integration code needs to hold
  a secret (for example when the site itself acts as a client against an external
  API), keep it in an environment variable rather than in code or configuration.
  With DDEV: `ddev dotenv set .ddev/.env --some-client-secret=<value>` then
  `ddev restart`, and where a module supports it, reference the value through the
  [Key](https://www.drupal.org/project/key) module instead of pasting it into a
  form. Make sure your outbound firewall/egress rules allow the site to reach the
  external token endpoint you are calling.
- **Protect stored tokens** — they are bearer credentials; anyone holding one can
  act as the client until it expires.
- Always serve token requests over **HTTPS** so credentials are never sent in the
  clear.

Because the browser‑based authorization_code login flow is disabled in this
version, there is no end‑user login redirect and therefore no login‑CSRF (state)
surface to configure here — the security focus is squarely on keeping the client
secret and issued tokens safe.
